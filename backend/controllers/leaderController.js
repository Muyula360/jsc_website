
import asyncHandler from 'express-async-handler';
import leader from '../models/leader.js';
import leadersview from '../models/leaders_vw.js';
import { db_connection } from '../config/db_connection.js';
import { logger } from "../utils/logger.js";
import { fileURLToPath } from 'url';
import { dirname } from 'path';
import path from 'path';
import fs from 'fs';


const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);



//desc      post leader to the website
//access    Protected
//route     POST --> /api/leader/postLeader
const postLeader = asyncHandler( async (req, res) => {

    const { leaderTitleID, fname, midname, surname, profession, experienceYears, bio, email, phone, linkedin_acc, fb_acc, twitter_acc, instagram_acc } = req.body;

    if( !req.file || !leaderTitleID || !fname || !midname || !surname || !profession || !experienceYears || !bio ){

        console.log(req.body)
        res.status(400);
        throw new Error(`Error posting leader: Profile Picture, Firstname, MiddleName, Surname, Prefix, leaderTitleID, Profession, ExperienceYears, Bio are required fields`);
        
    }


    // move leader profile picture to the storage location and get new path
    let profilePicPath = null;

    if( req.file ){
      
      const year = new Date().getFullYear().toString(); 
      const profilePicRelativePath = path.join(`website-repository/leadersprofilepictures/${year}`, leaderTitleID );
      const profilePicFullPath = path.join(__dirname, '..', profilePicRelativePath);

      if (!fs.existsSync(profilePicFullPath )) {
        fs.mkdirSync(profilePicFullPath , { recursive: true });
      }

      const targetPath = path.join(profilePicFullPath, req.file.filename);
      fs.renameSync(req.file.path, targetPath);

      profilePicPath = path.join(profilePicRelativePath, req.file.filename).replace(/\\/g, '/'); // Convert Windows slashes to URL-friendly;

    }


    // initiate transaction
    const transaction = await db_connection.transaction();


    // check if leader title ID exist
    const isLeaderTitleIDExist = await leader.findOne({ where: { leadersTitleID: leaderTitleID } });
    
    if(isLeaderTitleIDExist ){

        try {

          logger.info(`Attempting to update management leader`);
    
          // Update leader data into db
          const [ updatedRows, [ updateLeader ]] = await leader.update({ userID:req.user.userID, leadersTitleID:leaderTitleID, fname:fname, midName:midname, surname:surname, profession:profession, experienceYears:experienceYears, bio:bio, profile_pic_path:profilePicPath }, { where: { leadersTitleID: leaderTitleID }, returning: true }, { transaction });

          await updateLeader.save({ transaction });
    
          await transaction.commit();
          
          logger.info(`Successfully, leader profile has been updated`);
          res.status(201).json({ message: 'Leader profile updated successfully'});

        } catch(error){

          await transaction.rollback();
        
          // Clean up uploaded file
          if (req.file && fs.existsSync(req.file.path)) {
            fs.unlinkSync(req.file.path);
          }

          res.status(400);
          throw new Error(`Error posting leader: ${error.message}`);   

        }
      
    } else {

          try {

            logger.info(`Attempting create new management leader`);
      
            // Create leader into db
            const newLeader  = await leader.create({ userID:req.user.userID, leadersTitleID:leaderTitleID, fname:fname, midName:midname, surname:surname, profession:profession, experienceYears:experienceYears, bio:bio, profile_pic_path:profilePicPath }, { transaction });

            await newLeader.save({ transaction });
      
            await transaction.commit();
            
            logger.info(`Successfully, leader has been posted with ID ${ newLeader.leaderID }`);
            res.status(201).json({ message: 'Leader posted successfully', leaderID: newLeader.leaderID });

          } catch(error){

            await transaction.rollback();
          
            // Clean up uploaded file
            if (req.file && fs.existsSync(req.file.path)) {
              fs.unlinkSync(req.file.path);
            }

            res.status(400);
            throw new Error(`Failed to send password reset link: ${error.message}`);   

          }

    }

});



//desc      retrieve all leaders
//access    Public
//route     GET --> /api/leader/getAllLeaders
const getAllLeaders = asyncHandler( async (req, res) => {

  try {

    const leaders = await leadersview.findAll({ attributes: ['leaderID', 'level', 'title', 'leadersTitleID', 'titleDesc', 'fname', 'midName', 'surname', 'fullname', 'profession', 'experienceYears', 'prefix', 'bio', 'status', 'profile_pic_path', 'createdAt'], order: [['level', 'ASC']], });
    res.status(200).send(JSON.stringify(leaders, null, 2));

  } catch (err) {

    logger.error(`Error fetching leaders: ${err.message}`);

    res.status(400);
    throw new Error(`Error fetching leaders: ${err.message}`);   
  }

});


//desc      retrieve single leader
//access    Public
//route     GET --> /api/leader/getLeader
const getLeader = asyncHandler( async (req, res) => {

  if(!req.params || !req.params.leaderID){
    res.status(400);
    throw new Error(`Error fetching leader details, no parameter provided`); 
  }

  try {

    const leaderDetails = await leader.findOne({ attributes: ['leaderID', 'fname', 'midName', 'surname', 'prefix', 'title', 'level', 'bio', 'status', 'profile_pic_path', 'createdAt'], where: { leaderID: req.params.leaderID } });
    
    if (!leaderDetails) {
      res.status(400);
      throw new Error(`Leader not found with ID: ${req.params.newsletterID}`); 
    }

    res.status(200).send(JSON.stringify(leaderDetails, null, 2));

  } catch (err) {
 
    logger.error(`Error fetching leader details: ${err.message}`);

    res.status(400);
    throw new Error(`Error fetching leader details: ${err.message}`);   
  }

});



export { postLeader, getAllLeaders, getLeader }