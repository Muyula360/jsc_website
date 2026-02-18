
import asyncHandler from 'express-async-handler';
import speeches from '../models/speeches.js';
import speeches_vw from '../models/speeches_vw.js';
import { db_connection } from '../config/db_connection.js';
import { logger } from "../utils/logger.js";
import { fileURLToPath } from 'url';
import { dirname } from 'path';
import path from 'path';
import fs from 'fs';

import createNotification from '../utils/createNotification.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);


//desc      add new announcement
//access    Protected
//route     POST --> /api/speech/postspeech
const postSpeech = asyncHandler( async (req, res) => {

  const { announcementTitle, announcementlocation } = req.body;

  if( !req.file || !announcementTitle || !announcementlocation ){

      console.log(req.body)
      res.status(400);
      throw new Error
      
  }

  const transaction = await db_connection.transaction();

  try {

    logger.info(`Attempting to create new Speech`);

    // Create announcement into db
    const newAnnouncement  = await speeches.create({ userID:req.user.userID, announcementTitle:announcementTitle.trim(), announcementDesc:announcementlocation.trim() }, { transaction });

    // move announcement attachment to the storage location and get new path
    let announcementAttachmentPath = null;


    // If announcement attachment was uploaded, move it to the storage location
    if( req.file ){
      
      const year = new Date().getFullYear().toString(); 
      const attachmentRelPath = path.join(`website-repository/Speeches/${year}`, newAnnouncement.announcementTitle );
      const attachmentFulPath = path.join(__dirname, '..', attachmentRelPath);

      if (!fs.existsSync(attachmentFulPath )) {
        fs.mkdirSync(attachmentFulPath , { recursive: true });
      }

      const targetPath = path.join(attachmentFulPath, req.file.filename);
      fs.renameSync(req.file.path, targetPath);

      announcementAttachmentPath = path.join(attachmentRelPath, req.file.filename).replace(/\\/g, '/'); // Convert Windows slashes to URL-friendly;

      // Update announcement attachment path into db
      newAnnouncement.hasAttachment = 1;
      newAnnouncement.attachmentPath = announcementAttachmentPath;

      await newAnnouncement.save({ transaction });

    }

    await transaction.commit();

    // create announcement notification - posted
    await createNotification({ 
      userID: req.user.userID,
      source: 'Speech', 
      title: 'New Speech Alert', 
      desc: `A new Speech has just been published on the website. Please review the content and ensure it is aligned with the current editorial guidelines.`,
      scope: 'global',
    });
    
    logger.info(`Successfully created Speech with ID ${ newAnnouncement.announcementID }`);
    res.status(201).json({ message: 'Speech created successfully', postId: newAnnouncement.announcementID });

  } catch(error){

    await transaction.rollback();
  
    // Clean up uploaded file
    if (req.file && fs.existsSync(req.file.path)) {
      fs.unlinkSync(req.file.path);
    }

    res.status(400);
    throw new Error(`Error creating Speech: ${error.message}`);   

  }

});



//desc      retrieve all announcements
//access    Public
//route     GET --> /api/speech/getAllSpeeches
const getAllSpeeches = asyncHandler( async (req, res) => {

  try {

    const announcements = await speeches_vw.findAll({ attributes: ['announcementID', 'announcementTitle', 'announcementDesc', 'hasAttachment', 'postedBy', 'worktStation', 'postedAt', 'attachmentPath'], order: [['announcementID', 'DESC']], });
    res.status(200).send(JSON.stringify(announcements, null, 2));

  } catch (err) {

    logger.error(`Error fetching Speeches: ${err.message}`);

    res.status(400);
    throw new Error(`Error fetching Speeches: ${err.message}`);   
  }

});


//desc      retrieve single announcement
//access    Public
//route     GET --> /api/speech/getSpeech
const getSpeech = asyncHandler( async (req, res) => {

  if(!req.params || !req.params.announcementID){
    res.status(400);
    throw new Error(`Error fetching announcement, no parameter provided`); 
  }

  try {

    const announcementDetails = await speeches.findOne({ attributes: ['announcementID', 'announcementTitle', 'announcementDesc', 'attachmentPath', 'postedAt'], where: { announcementID: req.params.announcementID } });
    
    if (!announcementDetails) {
      res.status(400);
      throw new Error(`Announcement not found with ID: ${req.params.announcementID}`); 
    }

    res.status(200).send(JSON.stringify(announcementDetails, null, 2));

  } catch (err) {
 
    logger.error(`Error fetching announcement: ${err.message}`);

    res.status(400);
    throw new Error(`Error fetching announcement: ${err.message}`);   
  }

});


//desc      update existing announcement
//access    Protected
//route     PUT --> /api/speech/updateSpeech/:id
const updateSpeech = asyncHandler(async (req, res) => {

  const announcementID = req.params.announcementID;
   const { announcementTitle, announcementlocation } = req.body;

  if (!announcementTitle || !announcementlocation) {
    res.status(400);
    throw new Error('Speech title and Location are required.');
  }

  const transaction = await db_connection.transaction();

  try {

    const existingAnnouncement = await speeches.findByPk(announcementID);

    if (!existingAnnouncement) {
      res.status(404);
      throw new Error(`Speech not found with ID: ${announcementID}`);
    }

    existingAnnouncement.announcementTitle = announcementTitle.trim();
    existingAnnouncement.announcementDesc = announcementlocation.trim();

  
    if (req.file) {

      const year = new Date().getFullYear().toString();
      const attachmentRelPath = path.join(`website-repository/announcements/${year}`, announcementID);
      const attachmentFulPath = path.join(__dirname, '..', attachmentRelPath);

      if (!fs.existsSync(attachmentFulPath)) {
        fs.mkdirSync(attachmentFulPath, { recursive: true });
      }

      const targetPath = path.join(attachmentFulPath, req.file.filename);
      fs.renameSync(req.file.path, targetPath);

      const announcementAttachmentPath = path.join(attachmentRelPath, req.file.filename).replace(/\\/g, '/');

      existingAnnouncement.attachmentPath = announcementAttachmentPath;
      existingAnnouncement.hasAttachment = 1;
    }

    await existingAnnouncement.save({ transaction });
    await transaction.commit();

    // create announcement notification - modified
    await createNotification({ 
      userID: req.user.userID,
      source: 'Speech', 
      title: 'Speech Upadate Alert', 
      desc: `Speech titled "${existingAnnouncement.announcementTitle}" has been modified. Please review the content and ensure it is aligned with the current editorial guidelines.`,
      scope: 'global',
    });

    logger.info(`Successfully updated Speech with ID ${announcementID} by user ${req.user.userID}`);
    res.status(200).json({ message: 'Speech updated successfully' });

  } catch (error) {
    await transaction.rollback();

    if (req.file && fs.existsSync(req.file.path)) {
      fs.unlinkSync(req.file.path);
    }

    res.status(400);
    throw new Error(`Error updating Speech: ${error.message}`);
  }
  
});


//desc      delete existing announcement
//access    Protected
//route     DELETE --> /api/speech/deleteSpeech/:id
const deleteSpeech = asyncHandler(async (req, res) => {

  const announcementID = req.params.announcementID;

  const transaction = await db_connection.transaction();

  try {

    let announcementTitle;

    const existingAnnouncement = await speeches.findByPk(announcementID);

    if (!existingAnnouncement) {
      res.status(404);
      throw new Error(`Speech not found with ID: ${announcementID}`);
    }

    // assign title
    announcementTitle = existingAnnouncement.announcementTitle;

    // Remove attachment files if exist
    if (existingAnnouncement.hasAttachment && existingAnnouncement.attachmentPath) {
      const fullAttachmentPath = path.join(__dirname, '..', existingAnnouncement.attachmentPath);
      const dirPath = path.dirname(fullAttachmentPath);

      if (fs.existsSync(dirPath)) {
        fs.rmSync(dirPath, { recursive: true, force: true });
      }
    }

    await existingAnnouncement.destroy({ transaction });
    await transaction.commit();

    // create announcement notification - deleted
    await createNotification({ 
      userID: req.user.userID,
      source: 'Speech', 
      title: 'Speech Delete Alert', 
      desc: `Speech titled "${announcementTitle}" has been deleted from the website.`,
      scope: 'global',
    });

    logger.info(`Speech with ID ${announcementID} deleted by user ${req.user.userID}`);
    res.status(200).json({ message: 'Speech deleted successfully' });

  } catch (error) {
    await transaction.rollback();
    res.status(400);
    throw new Error(`Error deleting Speech: ${error.message}`);
  }

});



export { postSpeech, getAllSpeeches, getSpeech,  updateSpeech, deleteSpeech}