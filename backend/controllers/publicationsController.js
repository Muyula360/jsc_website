
import asyncHandler from 'express-async-handler';
import { db_connection } from '../config/db_connection.js';
import { logger } from "../utils/logger.js";
import { fileURLToPath } from 'url';
import { dirname } from 'path';
import path from 'path';
import fs from 'fs';


import publications from '../models/publications.js';
import publications_vw from '../models/publications_vw.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);


//desc      add new public content
//access    Protected
//route     POST --> /api/publication/postPubliContent
const postPubliContent = asyncHandler( async (req, res) => {

  const { category, title } = req.body;

  if( !req.file || !category || !title ){

      console.log(req.body)
      res.status(400);
      throw new Error('Content category, title and attachment are all required fields');
      
  }

  const transaction = await db_connection.transaction();

  try {

      logger.info(`Attempting to post new publication`);

      // Create publication into db
      const newPublication  = await publications.create({ userID:req.user.userID, category:category.trim(), title:title.trim() }, { transaction });

      // move publication attachment to the storage location and get new path
      let publicationAttachmentPath = null;
      let publicationAttachmentSize = null;
      let publicationAttachmentType = null;


      // If public content attachment was uploaded, move it to the storage location
      if( req.file ){
        
        const year = new Date().getFullYear().toString(); 
        const attachmentRelPath = path.join(`website-repository/publications/${category}/${year}`, newPublication.publicationsID );
        const attachmentFulPath = path.join(__dirname, '..', attachmentRelPath);

        if (!fs.existsSync(attachmentFulPath )) {
          fs.mkdirSync(attachmentFulPath , { recursive: true });
        }

        const targetPath = path.join(attachmentFulPath, req.file.filename);
        fs.renameSync(req.file.path, targetPath);

        publicationAttachmentPath = path.join(attachmentRelPath, req.file.filename).replace(/\\/g, '/'); // Convert Windows slashes to URL-friendly;
        publicationAttachmentSize = req.file.size;
        publicationAttachmentType = req.file.mimetype;

        // Update the publication record with file info
        newPublication.contentPath = publicationAttachmentPath;
        newPublication.contentSize = publicationAttachmentSize;
        newPublication.contentType = publicationAttachmentType;

        await newPublication.save({ transaction });

      }

      await transaction.commit();
      
      logger.info(`Successfully posted public content with ID ${ newPublication.publicationsID }`);
      res.status(201).json({ message: 'Publication posted successfully' });

  } catch(error){

    await transaction.rollback();
  
    // Clean up uploaded file
    if (req.file && fs.existsSync(req.file.path)) {
      fs.unlinkSync(req.file.path);
    }

    res.status(400);
    throw new Error(`Error posting pulic content: ${error.message}`);   

  }

});



//desc      retrieve all publications
//access    Public
//route     POST --> /api/publication/getAllPubliContents
const getAllPubliContents = asyncHandler( async (req, res) => {

  try {

    const publications = await publications_vw.findAll({ attributes: ['publicationsID', 'category', 'title', 'contentType', 'postedBy', 'contentSize', 'contentPath', 'createdAt' ], order: [['publicationsID', 'DESC']], });
    res.status(200).send(JSON.stringify(publications, null, 2));

  } catch (err) {

    logger.error(`Error fetching publications: ${err.message}`);

    res.status(400);
    throw new Error(`Error fetching publications: ${err.message}`);   
  }

});



//desc      retrieve single public content
//access    Public
//route     GET --> /api/publication/getPublicContent
const getPublicContent = asyncHandler(async (req, res) => {

  const { publicationID } = req.params;

  if (!publicationID) {
    res.status(400);
    throw new Error("Missing publicationID parameter");
  }

  try {
    const publi = await publications.findOne({
      attributes: ['publicationsID', 'category', 'title', 'contentType', 'postedBy', 'contentSize', 'contentPath', 'createdAt'],
      where: { publicationsID: publicationID },
    });

    if (!publi) {
      res.status(404);
      throw new Error(`Publication with ID ${publicationID} not found`);
    }

    res.status(200).json(publi);
  } catch (err) {
    logger.error(`Error retrieving publication ID ${publicationID}: ${err.message}`);
    res.status(500);
    throw new Error(`Failed to fetch public content: ${err.message}`);
  }

});


//desc      update single public content
//access    Protected
//route     PUT --> /api/publication/updatePublicContent
const updatePubliContent = asyncHandler(async (req, res) => {

  const { publicationID, title, category } = req.body;

  if (!publicationID || !title || !category) {
    res.status(400);
    throw new Error("publicationID, title, and category are required");
  }

  const transaction = await db_connection.transaction();

  try {

    const existingPubli = await publications.findByPk(publicationID);
    
    if (!existingPubli) {
      res.status(404);
      throw new Error(`Publication with ID ${publicationID} not found`);
    }

    // Update basic fields
    existingPubli.title = title.trim();
    existingPubli.category = category.trim();

    // Handle new file upload if provided
    if (req.file) {
      const year = new Date().getFullYear().toString();
      const attachmentRelPath = path.join(`website-repository/publications/${category}/${year}`, publicationID);
      const attachmentFullPath = path.join(__dirname, '..', attachmentRelPath);

      if (!fs.existsSync(attachmentFullPath)) {
        fs.mkdirSync(attachmentFullPath, { recursive: true });
      }

      // Delete old file if exists
      if (existingPubli.contentPath) {
        const oldFilePath = path.join(__dirname, '..', existingPubli.contentPath);
        if (fs.existsSync(oldFilePath)) {
          fs.unlinkSync(oldFilePath);
        }
      }

      const targetPath = path.join(attachmentFullPath, req.file.filename);
      fs.renameSync(req.file.path, targetPath);

      existingPubli.contentPath = path.join(attachmentRelPath, req.file.filename).replace(/\\/g, '/');
      existingPubli.contentSize = req.file.size;
      existingPubli.contentType = req.file.mimetype;
    }

    await existingPubli.save({ transaction });
    await transaction.commit();

    logger.info(`Successfully updated publication ID ${publicationID} by user ${req.user.userID}`);
    res.status(200).json({ message: "Publication updated successfully" });

  } catch (err) {

    await transaction.rollback();
    logger.error(`Error updating publication ID ${publicationID}: ${err.message}`);
    res.status(500);
    throw new Error(`Failed to update publication: ${err.message}`);
  }

});


//desc      delete single public content
//access    Protected
//route     DELETE --> /api/publication/deletePublicContent
const deletePubliContent = asyncHandler(async (req, res) => {

  const { publicationID } = req.params;

  if (!publicationID) {
    res.status(400);
    throw new Error("Missing publicationID parameter");
  }

  try {

    const publi = await publications.findByPk(publicationID);

    if (!publi) {
      res.status(404);
      throw new Error(`Publication with ID ${publicationID} not found`);
    }

    // Delete file
    if (publi.contentPath) {
      const fullPath = path.join(__dirname, '..', publi.contentPath);
      if (fs.existsSync(fullPath)) {
        fs.unlinkSync(fullPath);
      }
    }

    await publi.destroy();

    logger.info(`Successfully deleted publication ID ${publicationID} by user ${req.user.userID}`);
    res.status(200).json({ message: "Publication deleted successfully" });

  } catch (err) {

    logger.error(`Error deleting publication ID ${publicationID}: ${err.message}`);
    res.status(500);
    throw new Error(`Failed to delete publication: ${err.message}`);
  }

});


export { postPubliContent, getAllPubliContents, getPublicContent, updatePubliContent, deletePubliContent }