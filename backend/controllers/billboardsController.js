import asyncHandler from 'express-async-handler';
import billboards from '../models/billboards.js';
import billboards_vw from '../models/billboards_vw.js';
import { db_connection } from '../config/db_connection.js';
import { logger } from "../utils/logger.js";
import { fileURLToPath } from 'url';
import { dirname } from 'path';
import path from 'path';
import fs from 'fs';


const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);



//desc      post/create billboard post
//access    Protected
//route     POST --> /api/billboard/postBillboard
const postBillboard = asyncHandler(async (req, res) => {

  const { billboardTitle, billboardBody, showOnCarouselDisplay } = req.body;


  const billboardPicture = req.file;


  if (!billboardTitle || !billboardBody || !showOnCarouselDisplay || !billboardPicture ) {

    logger.error(`Missing required fields or images`);
    res.status(400);
    throw new Error('Billboard title, body and at least one image are required.');

  }

  const transaction = await db_connection.transaction();

  try {

    const createBillboardPost = await billboards.create({ userID: req.user.userID, billboardTitle, billboardBody, showOnCarouselDisplay }, { transaction });

    // If billboard picture is uploaded correctly, move it to the storage location
    if( billboardPicture ){

        const year = new Date().getFullYear().toString();
        const billboardRelPath = path.join(`website-repository/billboards/${year}`, createBillboardPost.billboardID );
        const billboardFullPath = path.join(__dirname, '..', billboardRelPath); 

        if (!fs.existsSync(billboardFullPath)) {
        fs.mkdirSync(billboardFullPath, { recursive: true });
        }

        let billboardPicPath = null;
    
        const targetPath = path.join(billboardFullPath, billboardPicture.filename);
        fs.renameSync(billboardPicture.path, targetPath);

        billboardPicPath = path.join(billboardRelPath, billboardPicture.filename).replace(/\\/g, '/'); 


        // Update billboard Picture path
        createBillboardPost.billboardPhotoPath = billboardPicPath;

        await createBillboardPost.save({ transaction });
    }

    await transaction.commit();
    
    logger.info(`Successfully created billboard with ID ${ createBillboardPost.billboardID }`);
    res.status(201).json({ message: 'Billboard posted successfully', postId: createBillboardPost.billboardID });


  } catch (error) {

    await transaction.rollback();
    logger.error(`Error posting news: ${error.message}`);

    res.status(400);
    throw new Error(`Error posting news: ${error.message}`);

  }

});


//desc      retrieve all billboards
//access    Public
//route     GET --> /api/billboard/getAllBillboards
const getAllBillboards = asyncHandler(async (req, res) => {

  try {

    const billboardPosts = await billboards_vw.findAll({ attributes: ['billboardID', 'billboardTitle', 'billboardBody', 'showOnCarouselDisplay', 'postedBy', 'worktStation', 'postedAt', 'billboardPhotoPath' ], order: [['billboardID', 'DESC']] });

    res.status(200).json(billboardPosts);

  } catch (err) {

    logger.error(`Error fetching billboard posts: ${err.message}`);
    res.status(400);
    throw new Error(`Error fetching billboard posts: ${err.message}`);

  }

});
  
  
//desc      retrieve single billboard post
//access    Public
//route     GET --> /api/billboard/getBillboard/:billboardID
const getBillboard = asyncHandler(async (req, res) => {

  const { billboardID } = req.params;

  if (!billboardID) {
    res.status(400);
    throw new Error("Missing billboard ID");
  }

  try {

    const billboardPost = await billboards_vw.findOne({ attributes: ['billboardID', 'billboardTitle', 'billboardBody', 'showOnCarouselDisplay', 'postedBy', 'worktStation', 'postedAt', 'billboardPhotoPath' ], where: { billboardID: billboardID }, order: [['billboardID', 'DESC']] });

    if (!billboardPost) {
      res.status(404);
      throw new Error(`Billboard post with ID ${billboardID} not found`);
    }

    res.status(200).json(billboardPost);

  } catch (err) {

    logger.error(`Error fetching billboard Post: ${err.message}`);
    res.status(400);
    throw new Error(`Error fetching billboard Post: ${err.message}`);
  }

});



//desc      update single billboard
//access    Protected
//route     PUT --> /api/billboard/updateBillboard/:billboardID
const updateBillboard = asyncHandler(async (req, res) => {

  const { billboardID } = req.params;

  const { billboardTitle, billboardBody, showOnCarouselDisplay } = req.body;
  const billboardPicture = req.file;

  if (!billboardID || !billboardTitle || !billboardBody || !showOnCarouselDisplay) {
    res.status(400);
    throw new Error('Missing required fields');
  }

  const billboardPost = await billboards.findByPk(billboardID);

  if (!billboardPost) {
    res.status(404);
    throw new Error('Billboard post not found');
  }

  const transaction = await db_connection.transaction();

  try {

    billboardPost.billboardTitle = billboardTitle;
    billboardPost.billboardBody = billboardBody;
    billboardPost.showOnCarouselDisplay = showOnCarouselDisplay;

    // If new image uploaded
    if (billboardPicture) {
      const year = new Date().getFullYear().toString();
      const billboardRelPath = path.join(`website-repository/billboards/${year}`, billboardPost.billboardID);
      const billboardFullPath = path.join(__dirname, '..', billboardRelPath);

      if (!fs.existsSync(billboardFullPath)) {
        fs.mkdirSync(billboardFullPath, { recursive: true });
      }

      // Remove old image
      if (billboardPost.billboardPhotoPath) {
        const oldFullPath = path.join(__dirname, '..', billboardPost.billboardPhotoPath);
        if (fs.existsSync(oldFullPath)) fs.unlinkSync(oldFullPath);
      }

      // Save new image
      const targetPath = path.join(billboardFullPath, billboardPicture.filename);
      fs.renameSync(billboardPicture.path, targetPath);

      const newRelPath = path.join(billboardRelPath, billboardPicture.filename).replace(/\\/g, '/');
      billboardPost.billboardPhotoPath = newRelPath;
    }

    await billboardPost.save({ transaction });
    await transaction.commit();

    logger.info(`Billboard with ID ${billboardID} updated successfully by user ${req.user.userID}`);
    res.status(200).json({ message: 'Billboard post updated successfully' });

  } catch (err) {

    await transaction.rollback();
    logger.error(`Error updating billboard: ${err.message}`);
    res.status(500);
    throw new Error(`Error updating billboard: ${err.message}`);
  }

});



//desc      Toggle billboard display on carousel
//access    Protected
//route     PUT --> /api/billboard/toggleDisplay/:billboardID
const toggleBillboardDisplay = asyncHandler(async (req, res) => {

  const { billboardID } = req.params;
  const { showOnCarouselDisplay } = req.body;

  if (typeof showOnCarouselDisplay === 'undefined') {
    res.status(400);
    throw new Error('Missing showOnCarouselDisplay value');
  }

  try {

    const billboardPost = await billboards.findByPk(billboardID);

    if (!billboardPost) {
      res.status(404);
      throw new Error(`Billboard post with ID ${billboardID} not found`);
    }

    // Update the boolean value
    billboardPost.showOnCarouselDisplay = showOnCarouselDisplay === true || showOnCarouselDisplay === 'true';

    await billboardPost.save();

    logger.info(`Updated carousel display for billboard ID ${billboardID} to ${billboardPost.showOnCarouselDisplay} by user ${req.user.userID}`);

    res.status(200).json({ message: 'Billboard display setting updated successfully' });

  } catch (err) {

    logger.error(`Error toggling billboard display: ${err.message}`);
    res.status(500);
    throw new Error(`Server error: ${err.message}`);
  }

});


//desc      delete single news
//access    Protected
//route     DELETE --> /api/billboard/deleteBillboard/:billboardID
const deleteBillboard = asyncHandler(async (req, res) => {
    
  const { billboardID } = req.params;

  if (!billboardID) {
    res.status(400);
    throw new Error('Missing billboard ID');
  }

  const billbordPost = await billboards.findByPk(billboardID);

  if (!billbordPost) {
    res.status(404);
    throw new Error(`Billboard post with ID ${billboardID} not found`);
  }

  const transaction = await db_connection.transaction();

  try {

    if (billbordPost.billboardPhotoPath) {
      const imagePath = path.join(__dirname, '..', billbordPost.billboardPhotoPath);
      if (fs.existsSync(imagePath)) fs.unlinkSync(imagePath);
    }

    await billbordPost.destroy({ transaction });
    await transaction.commit();

    logger.info(`Billboard with ID ${billboardID} deleted successfully by user ${req.user.userID}`);
    res.status(200).json({ message: 'Billboard post deleted successfully' });

  } catch (err) {
    await transaction.rollback();
    logger.error(`Error deleting billboard: ${err.message}`);
    
    res.status(500);
    throw new Error(`Error deleting billboard: ${err.message}`);
  }

});


export { postBillboard, getAllBillboards, getBillboard, updateBillboard, toggleBillboardDisplay, deleteBillboard }