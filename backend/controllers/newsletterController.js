import asyncHandler from 'express-async-handler';
import { db_connection } from '../config/db_connection.js';
import { logger } from "../utils/logger.js";
import { fileURLToPath } from 'url';
import { dirname } from 'path';
import path from 'path';
import fs from 'fs';


import newsletter from '../models/newsletter.js';
import newsletter_vw from '../models/newsletter_vw.js';


const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);



//desc      add new newsletter
//access    Protected
//route     POST --> /api/newsletter/postNewsletters
const postNewsletter = asyncHandler( async (req, res) => {

    const { newsletterNo, newsletterYear, newsletterMonth } = req.body;

    if( !req.files || !newsletterNo || !newsletterYear || !newsletterMonth ){

        console.log(req.body)
        res.status(400);
        throw new Error('NewsletterNo, NewsletterYear, NewsletterMonth, Newsletter cover picture and PDF attachment are all required fields');
        
    }

    const transaction = await db_connection.transaction();

    try {

        logger.info(`Attempting to post new newsletter`);
  
        // Create newsletter into db
        const newNewsletter  = await newsletter.create({ userID:req.user.userID, newsletterNo, newsletterYear, newsletterMonth }, { transaction });


        // If newsletter cover picture and PDF attachment were uploaded, move then to the storage location
        if( req.files['newsletterCover']?.[0] || req.files['newsletterAttachment']?.[0] ){

          const year = new Date().getFullYear().toString();
          const newsletterRelPath = path.join(`website-repository/newsupdates/${year}`, newNewsletter.newsletterID );
          const newsletterFullPath = path.join(__dirname, '..', newsletterRelPath); 

          if (!fs.existsSync(newsletterFullPath)) {
          fs.mkdirSync(newsletterFullPath, { recursive: true });
          }


          let newsletterCoverPicPath = null;
          let newsletterDocPath  = null;
      
          // newsletterCover
          const newsletterCoverFile = req.files['newsletterCover']?.[0];
          if (newsletterCoverFile) {
            const targetPath = path.join(newsletterFullPath, newsletterCoverFile.filename);
            fs.renameSync(newsletterCoverFile.path, targetPath);

            newsletterCoverPicPath = path.join(newsletterRelPath, newsletterCoverFile.filename).replace(/\\/g, '/'); 
          }

          // newsletterAttachment
          const newsletterDocFile = req.files['newsletterAttachment']?.[0];
          if (newsletterDocFile) {
            const targetPath = path.join(newsletterFullPath, newsletterDocFile.filename);
            fs.renameSync(newsletterDocFile.path, targetPath);

            newsletterDocPath= path.join(newsletterRelPath, newsletterDocFile.filename).replace(/\\/g, '/'); 
          }
  
          // Update newsletter attachment/cover path
          newNewsletter.newsletterCoverPath = newsletterCoverPicPath;
          newNewsletter.newsletterPath = newsletterDocPath;

          await newNewsletter.save({ transaction });
        }

        await transaction.commit();
        
        logger.info(`Successfully created newsletter with ID ${ newNewsletter.newsletterID }`);
        res.status(201).json({ message: 'newsletter posted successfully', postId: newNewsletter.newsletterID });

      }catch(error){

        await transaction.rollback();
      
        // Clean up uploaded file
        if (req.file && fs.existsSync(req.file.path)) {
          fs.unlinkSync(req.file.path);
        }

        res.status(400);
        throw new Error(`Error creating announcement: ${error.message}`);   

      }

});



//desc      retrieve all newsletters
//access    Public
//route     GET --> /api/newsletter/getAllNewsletters
const getAllNewsletters = asyncHandler( async (req, res) => {

  try {

    const newsletters = await newsletter_vw.findAll({ attributes: ['newsletterID', 'newsletterNo', 'newsletterYear', 'newsletterMonth', 'postedBy', 'worktStation', 'newsletterCoverPath', 'newsletterPath', 'downloads', 'reads', 'postedAt'], order: [['newsletterID', 'DESC']], });
    res.status(200).send(JSON.stringify(newsletters, null, 2));

  } catch (err) {

    logger.error(`Error fetching newsletters: ${err.message}`);

    res.status(400);
    throw new Error(`Error fetching newsletters: ${err.message}`);   
  }

});


//desc      retrieve single newsletter
//access    Public
//route     GET --> /api/newsletter/getNewsletter
const getNewsletter = asyncHandler( async (req, res) => {

  if(!req.params || !req.params.newsletterID){
    res.status(400);
    throw new Error(`Error fetching newsletter, no parameter provided`); 
  }

  try {

    const newsletterDetails = await newsletter.findOne({ attributes: ['newsletterID', 'newsletterNo', 'newsletterYear', 'newsletterMonth', 'newsletterCoverPath', 'newsletterPath', 'downloads', 'reads', 'postedAt'], where: { newsletterID: req.params.newsletterID } });    
    if (!newsletterDetails) {
      res.status(400);
      throw new Error(`Announcement not found with ID: ${req.params.newsletterID}`); 
    }

    res.status(200).send(JSON.stringify(newsletterDetails, null, 2));

  } catch (err) {
 
    logger.error(`Error fetching newsletter: ${err.message}`);

    res.status(400);
    throw new Error(`Error fetching newsletter: ${err.message}`);   
  }

});


//desc      update newsletter
//access    Protected
//route     PUT --> /api/newsletter/updateNewsletter
const updateNewsletter = asyncHandler(async (req, res) => {

  const { newsletterID } = req.params;

  const { newsletterNo, newsletterYear, newsletterMonth } = req.body;

  if (!newsletterID || !newsletterNo || !newsletterYear || !newsletterMonth) {
    res.status(400);
    throw new Error("NewsletterID, newsletterNo, newsletterYear and newsletterMonth are all required fields for updating the newsletter.");
  }

  const transaction = await db_connection.transaction();

  try {

    const existingNewsletter = await newsletter.findByPk(newsletterID);

    if (!existingNewsletter) {
      res.status(404);
      throw new Error("Newsletter not found");
    }

    // Update basic fields
    existingNewsletter.newsletterNo = newsletterNo;
    existingNewsletter.newsletterYear = newsletterYear;
    existingNewsletter.newsletterMonth = newsletterMonth;

    const year = new Date().getFullYear().toString();
    const newsletterRelPath = path.join(`website-repository/newsupdates/${year}`, newsletterID.toString());
    const newsletterFullPath = path.join(__dirname, '..', newsletterRelPath);

    if (!fs.existsSync(newsletterFullPath)) {
      fs.mkdirSync(newsletterFullPath, { recursive: true });
    }

    // Handle file uploads
    if (req.files['newsletterCover']?.[0]) {
      const cover = req.files['newsletterCover'][0];
      const targetCoverPath = path.join(newsletterFullPath, cover.filename);
      fs.renameSync(cover.path, targetCoverPath);

      existingNewsletter.newsletterCoverPath = path.join(newsletterRelPath, cover.filename).replace(/\\/g, '/');
    }

    if (req.files['newsletterAttachment']?.[0]) {
      const attachment = req.files['newsletterAttachment'][0];
      const targetAttachmentPath = path.join(newsletterFullPath, attachment.filename);
      fs.renameSync(attachment.path, targetAttachmentPath);

      existingNewsletter.newsletterPath = path.join(newsletterRelPath, attachment.filename).replace(/\\/g, '/');
    }

    await existingNewsletter.save({ transaction });
    await transaction.commit();

    logger.info(`Successfully updated newsletter with ID ${announcementID} by user ${req.user.userID}`);
    res.status(200).json({ message: "Newsletter updated successfully" });

  } catch (err) {

    await transaction.rollback();

    // Cleanup uploaded files
    if (req.files) {
      Object.values(req.files).flat().forEach((file) => {
        if (file.path && fs.existsSync(file.path)) {
          fs.unlinkSync(file.path);
        }
      });
    }

    logger.error(`Error updating newsletter: ${err.message}`);
    res.status(400);
    throw new Error(`Error updating newsletter: ${err.message}`);
  }

});



//desc      delete newsletter
//access    Protected
//route     DELETE --> /api/newsletter/deleteNewsletter/:newsletterID
const deleteNewsletter = asyncHandler(async (req, res) => {

  const { newsletterID } = req.params;

  if (!newsletterID) {
    res.status(400);
    throw new Error("NewsletterID is required");
  }

  try {

    const existingNewsletter = await newsletter.findByPk(newsletterID);

    if (!existingNewsletter) {
      res.status(404);
      throw new Error(`Newsletter with ID ${newsletterID} not found`);
    }

    // Delete files
    const baseDir = path.join(__dirname, '..');
    const coverPath = existingNewsletter.newsletterCoverPath ? path.join(baseDir, existingNewsletter.newsletterCoverPath) : null;
    const attachmentPath = existingNewsletter.newsletterPath ? path.join(baseDir, existingNewsletter.newsletterPath) : null;

    if (coverPath && fs.existsSync(coverPath)) fs.unlinkSync(coverPath);
    if (attachmentPath && fs.existsSync(attachmentPath)) fs.unlinkSync(attachmentPath);

    // Delete folder if empty
    const folderPath = path.dirname(coverPath || attachmentPath || '');

    if (folderPath && fs.existsSync(folderPath) && fs.readdirSync(folderPath).length === 0) {
      fs.rmdirSync(folderPath);
    }

    await existingNewsletter.destroy();

    res.status(200).json({ message: "Newsletter deleted successfully" });

  } catch (err) {
    
    logger.error(`Error deleting newsletter: ${err.message}`);
    res.status(400);
    throw new Error(`Error deleting newsletter: ${err.message}`);
  }

});



export  { postNewsletter, getAllNewsletters, getNewsletter, updateNewsletter, deleteNewsletter  }