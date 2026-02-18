
import asyncHandler from 'express-async-handler';
import announcement from '../models/announcement.js';
import announcements_vw from '../models/announcement_vw.js';
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
//route     POST --> /api/announcement/postAnnouncement
const postAnnouncement = asyncHandler( async (req, res) => {

  const { announcementTitle, announcementBody } = req.body;

  if( !req.file || !announcementTitle || !announcementBody ){

      console.log(req.body)
      res.status(400);
      throw new Error('Announcement title, Location and attachment are all required fields');
      
  }

  const transaction = await db_connection.transaction();

  try {

    logger.info(`Attempting to create new announcement`);

    // Create announcement into db
    const newAnnouncement  = await announcement.create({ userID:req.user.userID, announcementTitle:announcementTitle.trim(), announcementDesc:announcementBody.trim() }, { transaction });

    // move announcement attachment to the storage location and get new path
    let announcementAttachmentPath = null;


    // If announcement attachment was uploaded, move it to the storage location
    if( req.file ){
      
      const year = new Date().getFullYear().toString(); 
      const attachmentRelPath = path.join(`website-repository/announcements/${year}`, newAnnouncement.announcementID );
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
      source: 'Announcement', 
      title: 'New Announcement Alert', 
      desc: `A new announcement has just been published on the website. Please review the content and ensure it is aligned with the current editorial guidelines.`,
      scope: 'global',
    });
    
    logger.info(`Successfully created announcement with ID ${ newAnnouncement.announcementID }`);
    res.status(201).json({ message: 'announcement created successfully', postId: newAnnouncement.announcementID });

  } catch(error){

    await transaction.rollback();
  
    // Clean up uploaded file
    if (req.file && fs.existsSync(req.file.path)) {
      fs.unlinkSync(req.file.path);
    }

    res.status(400);
    throw new Error(`Error creating announcement: ${error.message}`);   

  }

});



//desc      retrieve all announcements
//access    Public
//route     GET --> /api/announcement/getAllAnnouncements
const getAllAnnouncements = asyncHandler( async (req, res) => {

  try {

    const announcements = await announcements_vw.findAll({ attributes: ['announcementID', 'announcementTitle', 'announcementDesc', 'hasAttachment', 'postedBy', 'worktStation', 'postedAt', 'attachmentPath'], order: [['announcementID', 'DESC']], });
    res.status(200).send(JSON.stringify(announcements, null, 2));

  } catch (err) {

    logger.error(`Error fetching announcements: ${err.message}`);

    res.status(400);
    throw new Error(`Error fetching announcements: ${err.message}`);   
  }

});


//desc      retrieve single announcement
//access    Public
//route     GET --> /api/announcement/getAnnouncement
const getAnnouncement = asyncHandler( async (req, res) => {

  if(!req.params || !req.params.announcementID){
    res.status(400);
    throw new Error(`Error fetching announcement, no parameter provided`); 
  }

  try {

    const announcementDetails = await announcement.findOne({ attributes: ['announcementID', 'announcementTitle', 'announcementDesc', 'attachmentPath', 'postedAt'], where: { announcementID: req.params.announcementID } });
    
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
//route     PUT --> /api/announcement/updateAnnouncement/:id
const updateAnnouncement = asyncHandler(async (req, res) => {

  const announcementID = req.params.announcementID;
  const { announcementTitle, announcementBody } = req.body;

  if (!announcementTitle || !announcementBody) {
    res.status(400);
    throw new Error('Announcement title and body are required.');
  }

  const transaction = await db_connection.transaction();

  try {

    const existingAnnouncement = await announcement.findByPk(announcementID);

    if (!existingAnnouncement) {
      res.status(404);
      throw new Error(`Announcement not found with ID: ${announcementID}`);
    }

    existingAnnouncement.announcementTitle = announcementTitle.trim();
    existingAnnouncement.announcementDesc = announcementBody.trim();

  
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
      source: 'Announcement', 
      title: 'Announcement Upadate Alert', 
      desc: `Announcement titled "${existingAnnouncement.announcementTitle}" has been modified. Please review the content and ensure it is aligned with the current editorial guidelines.`,
      scope: 'global',
    });

    logger.info(`Successfully updated announcement with ID ${announcementID} by user ${req.user.userID}`);
    res.status(200).json({ message: 'Announcement updated successfully' });

  } catch (error) {
    await transaction.rollback();

    if (req.file && fs.existsSync(req.file.path)) {
      fs.unlinkSync(req.file.path);
    }

    res.status(400);
    throw new Error(`Error updating announcement: ${error.message}`);
  }
  
});


//desc      delete existing announcement
//access    Protected
//route     DELETE --> /api/announcement/deleteAnnouncement/:id
const deleteAnnouncement = asyncHandler(async (req, res) => {

  const announcementID = req.params.announcementID;

  const transaction = await db_connection.transaction();

  try {

    let announcementTitle;

    const existingAnnouncement = await announcement.findByPk(announcementID);

    if (!existingAnnouncement) {
      res.status(404);
      throw new Error(`Announcement not found with ID: ${announcementID}`);
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
      source: 'Announcement', 
      title: 'Announcement Delete Alert', 
      desc: `Announcement titled "${announcementTitle}" has been deleted from the website.`,
      scope: 'global',
    });

    logger.info(`Announcement with ID ${announcementID} deleted by user ${req.user.userID}`);
    res.status(200).json({ message: 'Announcement deleted successfully' });

  } catch (error) {
    await transaction.rollback();
    res.status(400);
    throw new Error(`Error deleting announcement: ${error.message}`);
  }

});



export { postAnnouncement, getAllAnnouncements, getAnnouncement,  updateAnnouncement, deleteAnnouncement}