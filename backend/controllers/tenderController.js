
import asyncHandler from 'express-async-handler';
import tender from '../models/tender.js';
import tenders_vw from '../models/tenders_vw.js';
import { db_connection } from '../config/db_connection.js';
import { logger } from "../utils/logger.js";
import { fileURLToPath } from 'url';
import { dirname } from 'path';
import path from 'path';
import fs from 'fs';


const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);


//desc      add new Tender
//access    Protected
//route     POST --> /api/Tender/postTender
const postTender = asyncHandler( async (req, res) => {

  const { tenderNum, tenderer, tenderTitle, tenderOpenDate, tenderCloseDate, tenderLink } = req.body;

  if( !tenderNum || !tenderer || !tenderTitle || !tenderOpenDate || !tenderCloseDate || !tenderLink ){

      console.log(req.body)
      res.status(400);
      throw new Error('Tender Number, Tenderer, Tendertitle, TenderOpenDate, TenderCloseDate, TenderLink are all required fields');
      
  }

  const transaction = await db_connection.transaction();

  try {

      logger.info(`Attempting to create new Tender`);

      // Create Tender into db
      const newTender  = await tender.create({ userID:req.user.userID, tenderNum:tenderNum.trim(), tenderTitle:tenderTitle.trim(), tenderer:tenderer.trim(), openDate:tenderOpenDate, closeDate:tenderCloseDate, link:tenderLink.trim() }, { transaction });

      // move Tender attachment to the storage location and get new path
      let tenderAttachmentPath = null;


      // If tender attachment was uploaded, move it to the storage location
      if( req.file ){
        
        const year = new Date().getFullYear().toString(); 
        const attachmentRelPath = path.join(`website-repository/tenders/${year}`, newTender.tenderID );
        const attachmentFulPath = path.join(__dirname, '..', attachmentRelPath);

        if (!fs.existsSync(attachmentFulPath )) {
          fs.mkdirSync(attachmentFulPath , { recursive: true });
        }

        const targetPath = path.join(attachmentFulPath, req.file.filename);
        fs.renameSync(req.file.path, targetPath);

        tenderAttachmentPath = path.join(attachmentRelPath, req.file.filename).replace(/\\/g, '/'); // Convert Windows slashes to URL-friendly;

        // Update tender attachment path into db
        newTender.hasAttachment = 1;
        newTender.attachmentPath = tenderAttachmentPath;

        await newTender.save({ transaction });

      }

      await transaction.commit();
      
      logger.info(`Successfully created tender with ID ${ newTender.tenderID }`);
      res.status(201).json({ message: 'Tender posted successfully', tenderID: newTender.tenderID });

  } catch(error){

    await transaction.rollback();
  
    // Clean up uploaded file
    if (req.file && fs.existsSync(req.file.path)) {
      fs.unlinkSync(req.file.path);
    }

    res.status(400);
    throw new Error(`Failed to post tender: ${error.message}`);   

  }

});



//desc      retrieve all Tenders
//access    Public
//route     GET --> /api/tender/getAllTenders
const getAllTenders = asyncHandler( async (req, res) => {

  try {

    const tenders = await tenders_vw.findAll({ attributes: ['tenderID', 'tenderNum', 'tenderTitle', 'tenderer', 'openDate', 'closeDate', 'link', 'postedBy', 'worktStation', 'postedAt', 'hasAttachment', 'attachmentPath'], order: [['tenderID', 'DESC']], });
    res.status(200).send(JSON.stringify(tenders, null, 2));

  } catch (err) {

    logger.error(`Error fetching Tenders: ${err.message}`);

    res.status(400);
    throw new Error(`Error fetching Tenders: ${err.message}`);   
  }

});


//desc      retrieve single Tender
//access    Public
//route     GET --> /api/tender/getTender
const getTender = asyncHandler( async (req, res) => {

  if(!req.params || !req.params.tenderID){
    res.status(400);
    throw new Error(`Error fetching tender, no parameter provided`); 
  }

  try {

    const tenderDetails = await tenders_vw.findAll({ attributes: ['tenderID', 'tenderNum', 'tenderTitle', 'tenderer', 'openDate', 'closeDate', 'link', 'postedBy', 'worktStation', 'postedAt', 'hasAttachment', 'attachmentPath'], order: [['tenderID', 'DESC']], });
        
    if (!tenderDetails) {
      res.status(400);
      throw new Error(`Tender not found with ID: ${req.params.tenderID}`); 
    }

    res.status(200).send(JSON.stringify(tenderDetails, null, 2));

  } catch (err) {
 
    logger.error(`Error fetching Tender: ${err.message}`);

    res.status(400);
    throw new Error(`Error fetching Tender: ${err.message}`);   
  }

});



//desc      update Tender
//access    Protected
//route     PUT --> /api/tender/updateTender/:tenderID
const updateTender = asyncHandler(async (req, res) => {

  const { tenderID } = req.params;

  const { tenderNum, tenderer, tenderTitle, tenderOpenDate, tenderCloseDate, tenderLink } = req.body;

  if (!tenderID) {
    res.status(400);
    throw new Error('Tender ID is required for update');
  }

  const transaction = await db_connection.transaction();

  try {

    const tenderRecord = await tender.findByPk(tenderID);

    if (!tenderRecord) {
      res.status(404);
      throw new Error(`Tender not found with ID: ${tenderID}`);
    }

    tenderRecord.tenderNum = tenderNum || tenderRecord.tenderNum;
    tenderRecord.tenderer = tenderer || tenderRecord.tenderer;
    tenderRecord.tenderTitle = tenderTitle || tenderRecord.tenderTitle;
    tenderRecord.openDate = tenderOpenDate || tenderRecord.openDate;
    tenderRecord.closeDate = tenderCloseDate || tenderRecord.closeDate;
    tenderRecord.link = tenderLink || tenderRecord.link;

    // Handle file replacement
    if (req.file) {

      const year = new Date().getFullYear().toString();
      const attachmentRelPath = path.join(`website-repository/tenders/${year}`, tenderID);
      const attachmentFullPath = path.join(__dirname, '..', attachmentRelPath);

      if (!fs.existsSync(attachmentFullPath)) {
        fs.mkdirSync(attachmentFullPath, { recursive: true });
      }

      const targetPath = path.join(attachmentFullPath, req.file.filename);
      fs.renameSync(req.file.path, targetPath);

      // Delete old attachment
      if (tenderRecord.attachmentPath && fs.existsSync(path.join(__dirname, '..', tenderRecord.attachmentPath))) {
        fs.unlinkSync(path.join(__dirname, '..', tenderRecord.attachmentPath));
      }

      tenderRecord.hasAttachment = 1;
      tenderRecord.attachmentPath = path.join(attachmentRelPath, req.file.filename).replace(/\\/g, '/');
    }

    await tenderRecord.save({ transaction });
    await transaction.commit();

    logger.info(`Tender ID ${tenderID} updated successfully by user ${req.user.userID}`);
    res.status(200).json({ message: 'Tender updated successfully', updated: tenderID });

  } catch (error) {

    await transaction.rollback();
    logger.error(`Error updating tender: ${error.message}`);
    res.status(400);
    throw new Error(`Error updating tender: ${error.message}`);
  }

});



//desc      delete Tender
//access    Protected
//route     DELETE --> /api/tender/deleteTender/:tenderID
const deleteTender = asyncHandler(async (req, res) => {

  const { tenderID } = req.params;

  if (!tenderID) {
    res.status(400);
    throw new Error('Tender ID is required for deletion');
  }

  const transaction = await db_connection.transaction();

  try {
    const tenderRecord = await tender.findByPk(tenderID);

    if (!tenderRecord) {
      res.status(404);
      throw new Error(`Tender not found with ID: ${tenderID}`);
    }

    // Delete attachment if it exists
    if (tenderRecord.attachmentPath) {
      const attachmentFullPath = path.join(__dirname, '..', tenderRecord.attachmentPath);
      if (fs.existsSync(attachmentFullPath)) {
        fs.unlinkSync(attachmentFullPath);
      }
    }

    await tenderRecord.destroy({ transaction });
    await transaction.commit();

    logger.info(`Tender ID ${tenderID} deleted successfully by user ${req.user.userID}`);
    res.status(200).json({ message: 'Tender deleted successfully', deleted: tenderID });

  } catch (error) {

    await transaction.rollback();
    logger.error(`Error deleting tender: ${error.message}`);
    res.status(400);
    throw new Error(`Error deleting tender: ${error.message}`);

  }

});



export { postTender, getAllTenders, getTender, updateTender, deleteTender }