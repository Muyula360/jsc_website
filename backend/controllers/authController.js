import asyncHandler from 'express-async-handler';
import jwt from 'jsonwebtoken';
import axios from "axios";


import { logger } from '../utils/logger.js';
import user from '../models/user.js';


//desc      authenticate user
//access    Public
//route     POST --> /api/auth/login
const login  = asyncHandler(async (req, res) => {

    const { userEmail, userPassword } = req.body;

    if(!userEmail || !userPassword){

        console.log(req.body)
        res.status(400);
        throw new Error('All user fields are required');

    }

    //check if user email exists in database
    const ismailExist = await user.findOne({ where: { userEmail:userEmail } });
    
    if(!ismailExist){

        res.status(400);
        throw new Error('Email not registered. Please create account');

    }else{

        if(ismailExist.userStatus != 'Active'){
             
            res.status(400);
            throw new Error('This is account is deactiveted. Please contact system admin');

        }

        //check if user password matches password in database
        const isPasswordMatch = await ismailExist.comparePassword(userPassword);

        if(isPasswordMatch){

            const userID = ismailExist.userID; //get userID

            const token = jwt.sign({ userID: userID }, process.env.SECRET_KEY, { expiresIn: '1h'});

            res.cookie('JoTWeb_AuthToken', token, { httpOnly:true, sameSite: 'strict' });

            res.status(200).json({ authToken: token });

        }else{
            res.status(400);
            throw new Error('Incorrect user password');
        }

    }

});



//desc      validate/verify user authentication and user existance
//access    Protected
//route     GET --> /api/auth/authValidation
const authValidation  = asyncHandler( async (req, res) => {

    if( !req.user ){
       
        logger.error(`Error: auth validation failed. Invalid or unauthorized user`);
        res.status(400);
        throw new Error('Error: auth validation failed. Invalid or unauthorized user');
    }

    // Destructure req.user to exclude userID
    const { userID, ...userData } = req.user.toJSON();

    res.status(200).send(userData); 

});




//desc      forgot password
//access    Public
//route     POST --> /api/auth/forgotPassword
const forgotPassword  = asyncHandler(async (req, res) => {

    const { resetPasswordEmail } = req.body;

    if( !resetPasswordEmail ){

        res.status(400);
        throw new Error('Email address is required field');

    }

    try {

        logger.info(`User with email '${resetPasswordEmail}' attempts to reset password`);

        //check if email exists in database
        const ismailExist = await user.findOne({ where: { userEmail:resetPasswordEmail } });
        
        if(!ismailExist){

            throw new Error('Email not registered. Please provide registered/correct email');

        }else{

            //send password reset link to email address

            const userID = ismailExist.userID; //get userID

            const resetPwdToken = jwt.sign({ userID: userID, userEmail: resetPasswordEmail }, process.env.SECRET_KEY, { expiresIn: '10m'}); //

            const resetPasswordLink = `${process.env.FRONT_END_URL}/resetPassword/${resetPwdToken}`;

            // send reset password link
            const response = axios({
                method: "POST",
                url: process.env.MAIL_HOST,
                data: { 
                    email: ismailExist.userEmail,
                    fullname: `${ismailExist.userfname} ${ismailExist.userMidname} ${ismailExist.userSurname}`,
                    subject: 'Password Reset',
                    mail: `
                        <p></p>
                        <p>We received a request to reset your password. You can reset your password by clicking the link below:</p>
                        <p>
                        <a href="${resetPasswordLink}" target="_blank"> Reset Your Password </a>
                        </p>
                        <p>This link will expire in 5 minutes for your security. If you didn’t request a password reset, please ignore this email — your account will remain secure.</p>
                        <p>If you have any questions or need help, feel free to contact our support team.</p>
                    `
                }
            });

            logger.info(`Successfully, reset password link has been sent to '${ resetPasswordEmail }' `);
            res.status(200).json({ message: `Successfully, reset password link has been sent to '${ resetPasswordEmail }'`, resetPasswordLink: true });
        }


    } catch (error) {
        
        res.status(400);
        throw new Error(`Failed to generate reset link: ${error.message}`);   
        
    }

});



//desc      reset password
//access    Public
//route     POST --> /api/auth/resetPassword
const resetPassword = asyncHandler(async (req, res) => {

  const { resetPwdToken, newPassword, confirmPassword } = req.body;

  if (!resetPwdToken || !newPassword || !confirmPassword) {
    res.status(400);
    throw new Error('Reset password token, New password and Confirm password fields are all required fields');
  }

  if (newPassword !== confirmPassword) {
    res.status(400);
    throw new Error('Password and Confirm Password do not match');
  }

  try {

    const decodeResetPwdToken = jwt.verify(resetPwdToken, process.env.SECRET_KEY);

    // Fetch the user instance
    const userRecord = await user.findOne({ where: { userID: decodeResetPwdToken.userID } });

    if (!userRecord) {
      res.status(404);
      throw new Error("User not found");
    }

    // Set new password and save
    userRecord.userPassword = newPassword;
    await userRecord.save();

    // send notification email to alert user their email has changed/updated
    const response = axios({
        method: "POST",
        url: process.env.MAIL_HOST,
        data: { 
            email: userRecord.userEmail,
            fullname: `${userRecord.userfname} ${userRecord.userMidname} ${userRecord.userSurname}`,
            subject: 'Password Reset Successful',
            mail: `
                <p>This is a confirmation that your password has been successfully reset.</p>
                <p>If you did not perform this action, please contact our support team immediately to secure your account.</p>
            `
        }
    });

    logger.info(`Successfully updated user password`);
    res.status(200).json({ message: 'Password updated successfully' });

  } catch (err) {

    if (err.name === 'TokenExpiredError') {
        res.status(400);
        throw new Error(`Failed to reset password, reset password link has expired`);
    } else {
        res.status(400);
        throw new Error(`Failed to reset password, ${err}`);
    }

  }

});



//desc      update user password
//access    Public
//route     POST --> /api/auth/changePassword
const updatePassword  = asyncHandler(async (req, res) => {

    const { authToken, newPassword } = req.body;

    if(!authToken){

        res.status(400);
        throw new Error('No authorization token provided');

    }else if(!newPassword){

        res.status(400);
        throw new Error('Password and confirmPassword fields are required');
    }


    //update user password
    try{

        logger.info(`User is attempting to change their password`);
        
        //decode the authToken
        const decode = jwt.verify(authToken, process.env.SECRET_KEY);

        if(!decode){
            throw new Error('Invalid authorization token');
        }

        // update user password
        const updatePassword = await user.update({ userPassword: newPassword }, { where: { userID: decode.userID }, returning: true });

        if(!updatePassword){
            throw new Error('Could not update user password into database');
        }

        logger.info(`Successfully, password for user: ${decode.userID} has been updated`);
        res.status(201).json({ message: 'password updated successfully' });

    }catch(err){

        logger.error(`Change password failed. ${err}`);

        res.status(400);
        throw new Error(`Change password failed. ${err}`);

    }

});



//desc      logout user
//access    Private
//route     POST --> /api/auth/logout
const logout  = asyncHandler( async (req, res) => {

    res.cookie('JoTWeb_AuthToken', '', { httpOnly:true, sameSite: 'strict', expires: new Date(0) });

    logger.info(`Successfully, user: logged out`);

    res.status(200).send('Logged Out');
});


export { login, authValidation, forgotPassword, resetPassword, logout }