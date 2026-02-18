import asyncHandler from 'express-async-handler';
import axios from "axios";
import user from '../models/user.js';
import notification from '../models/notifications.js';
import { db_connection } from '../config/db_connection.js';
import { logger } from "../utils/logger.js";
import { fileURLToPath } from 'url';
import { dirname } from 'path';
import path from 'path';
import fs from 'fs';

import generatePassword from "../utils/passwordGen.js";
import createNotification from '../utils/createNotification.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);


//desc      create User Account
//access    Public
//route     POST --> /api/user/createAccount
const createAccount = asyncHandler(async (req, res) => {

    const { userWorkstation, userOfficeEmail, userFirstname, userMidname, userSurname, userRole } = req.body;

    const userProfilePic = req.file;

    if (!userWorkstation || !userOfficeEmail || !userFirstname || !userMidname || !userSurname || !userRole) {
        res.status(400);
        throw new Error('All User fields are required');
    }

    // Check if user email already exists in the database
    const emailExist = await user.findOne({ where: { userEmail: userOfficeEmail } });

    if (emailExist) {

        res.status(400);
        throw new Error('Account with the same email already exists');

    } else {

        const transaction = await db_connection.transaction();

        try {

            logger.info(`User: ${req.user?.userID || 'System'} is attempting to create new user`);

            // Generate temporary password
            const userPassword = generatePassword();

            // Insert user into database
            const insertUser = await user.create({ worktStation: userWorkstation, userEmail: userOfficeEmail, userfname: userFirstname, userMidname, userSurname, userPassword, userRole }, { transaction });

            // If profile picture is uploaded correctly, move it to the storage location
            if( userProfilePic ){
        
                const year = new Date().getFullYear().toString();
                const profilePicRelPath = path.join(`website-repository/users/${year}`, insertUser.userID );
                const profilePicFullPath = path.join(__dirname, '..', profilePicRelPath);

                if (!fs.existsSync(profilePicFullPath)) {
                    fs.mkdirSync(profilePicFullPath, { recursive: true });
                }

                let profilePicPath = null;

                const targetPath = path.join(profilePicFullPath, userProfilePic.filename);
                fs.renameSync(userProfilePic.path, targetPath);

                profilePicPath = path.join(profilePicRelPath, userProfilePic.filename).replace(/\\/g, '/');

                // Update profile Picture path
                insertUser.userProfilePicPath = profilePicPath;

                await insertUser.save({ transaction });
            }
            
            await transaction.commit();

            // create user account notification - account created
            await createNotification({ 
                userID: insertUser.userID,
                source: 'User Management', 
                title: 'User Account Alert', 
                desc: `We’ve set up your website account. Your temporary password is: ${userPassword}. Please remember to change your password.`,
                scope: 'personal',
            });


            // Send email notification
            const sendEmail = axios({
                method: "POST",
                url: process.env.MAIL_HOST,
                data: {
                    email: insertUser.userEmail,
                    fullname: `${insertUser.userfname} ${insertUser.userMidname} ${insertUser.userSurname}`,
                    subject: 'Your Account Has Been Created',
                    mail: `
                            <p>Welcome to Judiciary Website CMS! Your account has been successfully created.</p>
                            <p><strong>Email:</strong> ${insertUser.userEmail}</p>
                            <p><strong>Temporary Password:</strong> ${userPassword}</p>
                            <p>Please login and change your password. <a href="${process.env.FRONT_END_URL}/login">Click here to login</a></p>
                        `
                }
            });

            if (!sendEmail || sendEmail) {

                logger.error(`Successfully created user with ID ${insertUser.userID}, but failed to send welcome email to ${insertUser.userEmail}`);
                res.status(201).json({ message: 'User created successfully, but failed to send welcome email' });

            } else {

                logger.info(`Successfully created user with ID ${insertUser.userID}`);
                res.status(201).json({ message: 'User created successfully' });
            }

        } catch (error) {

            logger.error(`Error creating user: ${error.message}`);
            res.status(400);
            throw new Error(`Error creating user: ${error.message}`);
        }
    }
});


//desc      Get users list
//access    Protected
//route     GET --> /api/user/getUsersList
const getUsersList = asyncHandler(async (req, res) => {

    try {
        
        logger.info(`Attempting to fetch all users from database`);

        const allUsers = await user.findAll({ attributes: [ 'userID', 'worktStation', 'userEmail', 'userfname', 'userMidname', 'userSurname', 'userRole', 'userVerfication', 'userStatus', 'userProfilePicPath', 'userCreatedAt'], order: [['userID', 'DESC']] });

        res.status(200).send(JSON.stringify(allUsers, null, 2));

    } catch (err) {

        logger.error(`Error fetching users list: ${err.message}`);
        res.status(400);
        throw new Error(`Error fetching users list: ${err.message}`);
    }

});


//desc      Get user details by userID
//access    Protected
//route     GET --> /api/user/getUserByID/:id
const getUserByID = asyncHandler(async (req, res) => {

    const userID = req.params.userID;

    const foundUser = await user.findByPk(userID, { attributes: ['userID', 'worktStation', 'userEmail', 'userfname', 'userMidname', 'userSurname', 'userRole', 'userStatus', 'userProfilePicPath', 'userCreatedAt'] });

    if (!foundUser) {
        res.status(404);
        throw new Error('User not found');
    }

    res.status(200).json(foundUser);
});


//desc      Update user account
//access    Protected
//route     PUT --> /api/user/updateUser/:id
const updateUser = asyncHandler(async (req, res) => {

    const userID = req.params.userID;

    const { userWorkstation, userOfficeEmail, userFirstname, userMidname, userSurname, userRole } = req.body;
    const userProfilePic = req.file;

    if (!userID || !userWorkstation || !userOfficeEmail || !userFirstname || !userMidname || !userSurname || !userRole) {
        res.status(400);
        throw new Error('User ID and all fields are required');
    }

    const foundUser = await user.findByPk(userID);

    if (!foundUser) {
        res.status(404);
        throw new Error('User not found');
    }

    const transaction = await db_connection.transaction();

    try {

        logger.info(`User: ${req.user?.userID || 'System'} is attempting to update user with ID ${userID}`);

        foundUser.userfname = req.body.userFirstname;
        foundUser.userMidname = req.body.userMidname;
        foundUser.userSurname = req.body.userSurname;
        foundUser.userEmail = req.body.userOfficeEmail;
        foundUser.worktStation = req.body.userWorkstation;
        foundUser.userRole = req.body.userRole;

        // If new image uploaded
        if (userProfilePic) {
            const year = new Date().getFullYear().toString();
            const userRelPath = path.join(`website-repository/users/${year}`, foundUser.userID);
            const userFullPath = path.join(__dirname, '..', userRelPath);

            if (!fs.existsSync(userFullPath)) {
                fs.mkdirSync(userFullPath, { recursive: true });
            }

            // Remove old image
            if (foundUser.userProfilePicPath) {
                const oldFullPath = path.join(__dirname, '..', foundUser.userProfilePicPath);
                if (fs.existsSync(oldFullPath)) fs.unlinkSync(oldFullPath);
            }

            // Save new image
            const targetPath = path.join(userFullPath, userProfilePic.filename);
            fs.renameSync(userProfilePic.path, targetPath);

            const newRelPath = path.join(userRelPath, userProfilePic.filename).replace(/\\/g, '/');
            foundUser.userProfilePicPath = newRelPath;
        }

        await foundUser.save({ transaction });
        await transaction.commit();

        
        // create user account notification - account modified
        await createNotification({ 
            userID: foundUser.userID,
            source: 'User Management', 
            title: 'User Account Modification', 
            desc: `You account information was updated successfully`,
            scope: 'personal',
        });


        logger.info(`User with ID ${userID} updated successfully by user ${req.user.userID}`);
        res.status(200).json({ message: 'User updated successfully' });

    } catch (err) {

        await transaction.rollback();
        logger.error(`Error updating billboard: ${err.message}`);
        res.status(500);
        throw new Error(`Error updating billboard: ${err.message}`);
    }

});


//desc      Delete user account
//access    Protected
//route     DELETE --> /api/user/deleteUser/:id
const deleteUser = asyncHandler(async (req, res) => {

    const userID = req.params.userID;

    if (!userID) {
        res.status(404);
        throw new Error('User ID is required');
    }
    
    if (userID === req.user.userID || userID === '1') {
        res.status(403);
        throw new Error('You cannot delete your own account or super admin account');
    }

    const foundUser = await user.findByPk(userID);

    if (!foundUser) {
        res.status(404);
        throw new Error('User not found');
    }

    // Delete user profile picture from server
    if (foundUser.userProfilePicPath && fs.existsSync(foundUser.userProfilePicPath)) {
        fs.unlinkSync(foundUser.userProfilePicPath);
    }

    // Delete user record from database
    await user.destroy({ where: { userID } });

    res.status(200).json({ message: 'User deleted successfully' });
});


//desc      Retrieve personal details of logged-in user
//access    Protected
//route     GET --> /api/user/getMyDetails
const getMyDetails = asyncHandler(async (req, res) => {

    if (!req.user) {
        logger.error(`Error: GetMyDetails request failed. Invalid or unauthorized user`);
        res.status(400);
        throw new Error('GetMyDetails failed, request.user is required');
    }

    // Destructure and remove sensitive info like password
    const { userID, ...userData } = req.user.toJSON();

    res.status(200).send(userData);
});



export { createAccount, getUsersList, getUserByID, updateUser, deleteUser, getMyDetails }