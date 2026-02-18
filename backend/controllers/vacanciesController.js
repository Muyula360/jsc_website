import asyncHandler from 'express-async-handler';
import { db_connection } from '../config/db_connection.js';
import { logger } from "../utils/logger.js";
import { fileURLToPath } from 'url';
import { dirname } from 'path';
import path from 'path';
import fs from 'fs';

import vacancy from '../models/vacancy.js';
import vacancies_vw from '../models/vacancies_vw.js';


const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);


//desc      add new vacancy
//access    Protected
//route     POST --> /api/vacancy/postVacancy
const postVacancy = asyncHandler( async (req, res) => {

    const { vacancyTitle, vacancyDesc, vacantPositions, openDate, closeDate, link } = req.body;

    if( !vacancyTitle || !vacancyDesc || !vacantPositions || !openDate || !closeDate || !link ){

        console.log(req.body)
        res.status(400);
        throw new Error('Failed to post vacancy, vacancy title, Description, Positions, openDate, closeDate and link are required fields');
    }

    const transaction = await db_connection.transaction();
    
    try {

      logger.info(`Attempting to create new vacancy`);

      // Create vacancy into db
      const newVacancy = await vacancy.create({ userID:req.user.userID, vacancyTitle, vacancyDesc, vacantPositions, openDate, closeDate, link }, { transaction });

      // move vacancy attachment to the storage location and get new path
      let vacancyAttachmentPath = null;


      // If vacancy attachment was uploaded, move it to the storage location
      if( req.file ){
        
        const year = new Date().getFullYear().toString(); 
        const attachmentRelPath = path.join(`website-repository/vacancies/${year}`, newVacancy.vacancyID );
        const attachmentFulPath = path.join(__dirname, '..', attachmentRelPath);

        if (!fs.existsSync(attachmentFulPath )) {
          fs.mkdirSync(attachmentFulPath , { recursive: true });
        }

        const targetPath = path.join(attachmentFulPath, req.file.filename);
        fs.renameSync(req.file.path, targetPath);

        vacancyAttachmentPath = path.join(attachmentRelPath, req.file.filename).replace(/\\/g, '/'); // Convert Windows slashes to URL-friendly;

        // Update vacancy attachment path into db
        newVacancy.hasAttachment = 1;
        newVacancy.attachmentPath = vacancyAttachmentPath;

        await newVacancy.save({ transaction });

      }

      await transaction.commit();
      
      logger.info(`Successfully created vacancy with ID ${ newVacancy.vacancyID }`);

      // retrieve all vacancies
      const allVacancies = await vacancies_vw.findAll({ attributes: ['vacancyID', 'vacancyTitle', 'vacancyDesc', 'vacantPositions', 'openDate', 'closeDate', 'postedBy', 'worktStation', 'hasAttachment', 'attachmentPath', 'postedAt'], order: [['vacancyID', 'DESC']], });
      
      if(allVacancies){

        res.status(200).send(JSON.stringify(allVacancies, null, 2));

      }

      res.status(200).send(JSON.stringify(newVacancy, null, 2));

    } catch(error){

      await transaction.rollback();
      
      // Clean up uploaded file
      if (req.file && fs.existsSync(req.file.path)) {
          fs.unlinkSync(req.file.path);
      }

      res.status(400);
      throw new Error(`Failed to post vacancy: ${error.message}`);   

    }

});



//desc      retrieve all vacancies
//access    Public
//route     GET --> /api/vacancy/getAllVacancies
const getAllVacancies = asyncHandler( async (req, res) => {

    try {
  
      const allVacancies = await vacancies_vw.findAll({ attributes: ['vacancyID', 'vacancyTitle', 'vacancyDesc', 'vacantPositions', 'openDate', 'closeDate', 'postedBy', 'worktStation', 'hasAttachment', 'attachmentPath', 'link', 'postedAt'], order: [['vacancyID', 'DESC']], });
      res.status(200).send(JSON.stringify(allVacancies, null, 2));
  
    } catch (err) {
  
      logger.error(`Failed to fetch vacancies: ${err.message}`);
  
      res.status(400);
      throw new Error(`Failed to fetch vacancies: ${err.message}`);   
    }
  
  });
  
  
//desc      retrieve single vacancy
//access    Public
//route     GET --> /api/vacancy/getVacancy/ID
const getVacancy = asyncHandler( async (req, res) => {

  if(!req.params || !req.params.vacancyID){
    res.status(400);
    throw new Error(`Error fetching vacancy, no parameter provided`); 
  }

  try {
      
      const vacancyDetails = await vacancies_vw.findOne({ attributes: ['vacancyID', 'vacancyTitle', 'vacancyDesc', 'vacantPositions', 'openDate', 'closeDate', 'postedBy', 'worktStation', 'hasAttachment', 'attachmentPath', 'link', 'postedAt'], where: { vacancyID: req.params.vacancyID } });
      
      if (!vacancyDetails) {
          res.status(400);
          throw new Error(`Could not find vacancy with ID: ${req.params.vacancyID}`); 
      }
  
      res.status(200).send(JSON.stringify(vacancyDetails, null, 2));

  } catch (err) {
  
      logger.error(`Error fetching vacancy: ${err.message}`);
  
      res.status(400);
      throw new Error(`Error fetching vacancy: ${err.message}`);   
  }

});


//desc      update existing vacancy
//access    Protected
//route     PUT --> /api/vacancy/updateVacancy
const updateVacancy = asyncHandler(async (req, res) => {

  const { vacancyID } = req.params;

  if (!vacancyID) {
    res.status(400);
    throw new Error("Missing vacancyID parameter");
  }

  const { vacancyTitle, vacancyDesc, vacantPositions, openDate, closeDate, link } = req.body;

  if (!vacancyTitle || !vacancyDesc || !vacantPositions || !openDate || !closeDate || !link ) {
    res.status(400);
    throw new Error("vacancyID, title, description, positions, openDate, closeDate, and vacancylink are required");
  }

  const transaction = await db_connection.transaction();

  try {

    const existingVacancy = await vacancy.findByPk(vacancyID);

    if (!existingVacancy) {
      res.status(404);
      throw new Error(`Vacancy not found with ID: ${vacancyID}`);
    }

    existingVacancy.vacancyTitle = vacancyTitle.trim();
    existingVacancy.vacancyDesc = vacancyDesc.trim();
    existingVacancy.vacantPositions = vacantPositions;
    existingVacancy.openDate = openDate;
    existingVacancy.closeDate = closeDate;
    existingVacancy.link = link;

    // If a new file is uploaded
    if (req.file) {
      // Delete old file if exists
      if (existingVacancy.attachmentPath) {
        const oldFilePath = path.join(__dirname, '..', existingVacancy.attachmentPath);
        if (fs.existsSync(oldFilePath)) fs.unlinkSync(oldFilePath);
      }

      const year = new Date().getFullYear().toString();
      const attachmentRelPath = path.join(`website-repository/vacancies/${year}`, vacancyID);
      const attachmentFullPath = path.join(__dirname, '..', attachmentRelPath);

      if (!fs.existsSync(attachmentFullPath)) {
        fs.mkdirSync(attachmentFullPath, { recursive: true });
      }

      const targetPath = path.join(attachmentFullPath, req.file.filename);
      fs.renameSync(req.file.path, targetPath);

      existingVacancy.hasAttachment = 1;
      existingVacancy.attachmentPath = path.join(attachmentRelPath, req.file.filename).replace(/\\/g, '/');
    }

    await existingVacancy.save({ transaction });
    await transaction.commit();

    logger.info(`Successfully updated vacancy with ID ${vacancyID} by user ${req.user.userID}`);

    res.status(200).json({ message: "Vacancy updated successfully", vacancyID });

  } catch (err) {

    await transaction.rollback();

    if (req.file && fs.existsSync(req.file.path)) {
      fs.unlinkSync(req.file.path);
    }

    logger.error(`Failed to update vacancy: ${err.message}`);
    res.status(400);
    throw new Error(`Failed to update vacancy: ${err.message}`);
  }

});



//desc      delete existing vacancy
//access    Protected
//route     DELETE --> /api/vacancy/deleteVacancy/:vacancyID
const deleteVacancy = asyncHandler(async (req, res) => {

  const { vacancyID } = req.params;

  if (!vacancyID) {
    res.status(400);
    throw new Error("Vacancy ID is required for deletion");
  }

  const transaction = await db_connection.transaction();

  try {

    const existingVacancy = await vacancy.findByPk(vacancyID);

    if (!existingVacancy) {
      res.status(404);
      throw new Error(`Vacancy not found with ID: ${vacancyID}`);
    }

    // Delete attached file if exists
    if (existingVacancy.attachmentPath) {
      const filePath = path.join(__dirname, '..', existingVacancy.attachmentPath);
      if (fs.existsSync(filePath)) fs.unlinkSync(filePath);
    }

    await existingVacancy.destroy({ transaction });
    await transaction.commit();

    logger.info(`Successfully deleted vacancy with ID ${vacancyID} by user ${req.user.userID}`);
    res.status(200).json({ message: "Vacancy deleted successfully", vacancyID });

  } catch (err) {

    await transaction.rollback();
    logger.error(`Failed to delete vacancy: ${err.message}`);
    res.status(400);
    throw new Error(`Failed to delete vacancy: ${err.message}`);
  }

});

export { postVacancy, getAllVacancies, getVacancy, updateVacancy, deleteVacancy}