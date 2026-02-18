import asyncHandler from 'express-async-handler';
import newsupdates from '../models/newsupdates.js';
import newsupdates_vw from '../models/newsupdates_vw.js';
import { db_connection } from '../config/db_connection.js';
import { logger } from "../utils/logger.js";
import { fileURLToPath } from 'url';
import { dirname } from 'path';
import path from 'path';
import fs from 'fs';

import createNotification from '../utils/createNotification.js';


const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);


// move uploaded photo/images
const moveNewsPhotos = (files, basePath, relativePath) => {

  if (!fs.existsSync(basePath)) {
    fs.mkdirSync(basePath, { recursive: true });
  }

  let coverPhotoPath = null;
  const supportingPhotosPaths = [];

  files.forEach((photo, index) => {
    const targetPath = path.join(basePath, photo.filename);
    fs.renameSync(photo.path, targetPath);

    const normalizedPath = path.join(relativePath, photo.filename).replace(/\\/g, '/');

    if (index === 0) {
      coverPhotoPath = normalizedPath;
    }

    supportingPhotosPaths.push(normalizedPath);

  });

  return { coverPhotoPath, supportingPhotosPaths };
};



//desc      post/create news/updates
//access    Protected
//route     POST --> /api/newsupdates/postNewsupdates
const postNewsupdates = asyncHandler(async (req, res) => {

  const { newsTitle, newsBody, showOnCarouselDisplay } = req.body;

  const files = req.files?.['newsPhotos'];

  if (!newsTitle || !newsBody || !showOnCarouselDisplay || !files || files.length === 0) {

    logger.error(`Missing required fields or images`);
    res.status(400);
    throw new Error('News title, body and at least one image are required.');

  }

  if (files.length > 5) {
    res.status(400);
    throw new Error('You cannot upload more than 5 photos');
  }

  const transaction = await db_connection.transaction();

  try {

    const createdNews = await newsupdates.create({
      userID: req.user.userID,
      newsTitle,
      newsDesc: newsBody,
      showOnCarouselDisplay,
    }, { transaction });

    const year = new Date().getFullYear().toString();
    const relativePath = path.join('website-repository/newsupdates', year, createdNews.newsupdatesID.toString());
    const fullPath = path.join(__dirname, '..', relativePath);

    const { coverPhotoPath, supportingPhotosPaths } = moveNewsPhotos(files, fullPath, relativePath);

    createdNews.coverPhotoPath = coverPhotoPath;
    createdNews.supportingPhotosPaths = supportingPhotosPaths;

    await createdNews.save({ transaction });
    await transaction.commit();

    // create news notification - posted
    await createNotification({ 
      userID: req.user.userID,
      source: 'News Updates', 
      title: 'News Post Alert', 
      desc: `News post has just been published on the website. Please review the content and ensure it is aligned with the current editorial guidelines.`,
      scope: 'global',
    });

    const allNews = await newsupdates_vw.findAll({ attributes: ['newsupdatesID', 'newsTitle', 'newsDesc', 'postedBy', 'worktStation', 'postedAt', 'coverPhotoPath', 'supportingPhotosPaths'], order: [['newsupdatesID', 'DESC']], });

    res.status(201).json(allNews);

  } catch (error) {

    await transaction.rollback();
    logger.error(`Error posting news: ${error.message}`);

    res.status(400);
    throw new Error(`Error posting news: ${error.message}`);

  }

});


//desc      retrieve all news
//access    Public
//route     GET --> /api/newsupdates/getAllNews
const getAllNews = asyncHandler(async (req, res) => {

  try {

    const allNews = await newsupdates_vw.findAll({
      attributes: ['newsupdatesID', 'newsTitle', 'newsDesc', 'postedBy', 'worktStation', 'postedAt', 'coverPhotoPath', 'supportingPhotosPaths'],
      order: [['newsupdatesID', 'DESC']],
    });

    res.status(200).json(allNews);

  } catch (err) {

    logger.error(`Error fetching news & updates: ${err.message}`);
    res.status(400);
    throw new Error(`Error fetching news & updates: ${err.message}`);

  }
});
  
  
//desc      retrieve single news
//access    Public
//route     GET --> /api/newsupdates/getNews
const getNews = asyncHandler(async (req, res) => {

  const { newsID } = req.params;

  if (!newsID) {
    res.status(400);
    throw new Error("Missing news ID");
  }

  try {

    const news = await newsupdates_vw.findOne({
      attributes: ['newsupdatesID', 'newsTitle', 'newsDesc', 'postedBy', 'worktStation', 'postedAt', 'coverPhotoPath', 'supportingPhotosPaths'],
      where: { newsupdatesID: newsID },
    });

    if (!news) {
      res.status(404);
      throw new Error(`News with ID ${newsID} not found`);
    }

    res.status(200).json(news);

  } catch (err) {

    logger.error(`Error fetching news: ${err.message}`);
    res.status(400);
    throw new Error(`Error fetching news: ${err.message}`);
  }

});



//desc      update single news
//access    Protected
//route     PUT --> /api/newsupdates/updateNews/:newsID
const updateNews = asyncHandler(async (req, res) => {

  const { newsID } = req.params;

  const { newsTitle, newsBody, showOnCarouselDisplay } = req.body;
  const existingPhotos = req.body.existingPhotos || [];
  const files = req.files?.['newsPhotos'];

  if (!newsID || !newsTitle || !newsBody || !showOnCarouselDisplay) {
    res.status(400);
    throw new Error("Missing required fields for updating news");
  }

  const newsToUpdate = await newsupdates.findByPk(newsID);
  if (!newsToUpdate) {
    res.status(404);
    throw new Error(`News with ID ${newsID} not found`);
  }

  const transaction = await db_connection.transaction();

  try {

    newsToUpdate.newsTitle = newsTitle;
    newsToUpdate.newsDesc = newsBody;
    newsToUpdate.showOnCarouselDisplay = showOnCarouselDisplay;

    const year = new Date(newsToUpdate.createdAt).getFullYear().toString();
    const relativePath = path.join('website-repository/newsupdates', year, newsID);
    const fullPath = path.join(__dirname, '..', relativePath);

    let uploadedPaths = [];

    // Handle new files
    if (files && files.length > 0) {
      if (files.length > 5) {
        res.status(400);
        throw new Error("You cannot upload more than 5 supporting photos");
      }

      if (!fs.existsSync(fullPath)) {
        fs.mkdirSync(fullPath, { recursive: true });
      }

      const { supportingPhotosPaths } = moveNewsPhotos(files, fullPath, relativePath);
      uploadedPaths = supportingPhotosPaths;

    }

    // Combine kept existing images and newly uploaded ones
    const existingArray = Array.isArray(existingPhotos) ? existingPhotos : [existingPhotos];
    const finalSupportingPhotos = [...existingArray, ...uploadedPaths];

    // Clean up removed old photos from folder
    if (fs.existsSync(fullPath)) {
      const currentFiles = fs.readdirSync(fullPath);
      currentFiles.forEach(file => {
        const filePath = path.join(relativePath, file).replace(/\\/g, '/');
        if (!finalSupportingPhotos.includes(filePath)) {
          fs.unlinkSync(path.join(fullPath, file));
        }
      });
    }

    // Set photos
    newsToUpdate.supportingPhotosPaths = finalSupportingPhotos;
    newsToUpdate.coverPhotoPath = finalSupportingPhotos[0] || null;

    await newsToUpdate.save({ transaction });
    await transaction.commit();

    // create news notification - modified
    await createNotification({ 
      userID: req.user.userID,
      source: 'News Updates', 
      title: 'News Post Updated', 
      desc: `News post titled "${newsToUpdate.newsTitle}" has been modified. Please review the content and ensure it is aligned with the current editorial guidelines.`,
      scope: 'global',
    });


    logger.info(`Successfully updated news with ID ${newsID} by user ${req.user.userID}`);
    res.status(200).json({ message: `News with ID ${newsID} updated successfully.` });

  } catch (error) {
    await transaction.rollback();
    logger.error(`Failed to update news with ID ${newsID}: ${error.message}`);
    res.status(400);
    throw new Error(`Error updating news: ${error.message}`);
  }
});


//desc      delete single news
//access    Protected
//route     DELETE --> /api/newsupdates/deleteNews/:newsID
const deleteNews = asyncHandler(async (req, res) => {

  const { newsID } = req.params;

  if (!newsID) {
    res.status(400);
    throw new Error("News ID is required");
  }

  const news = await newsupdates.findByPk(newsID);
  if (!news) {
    res.status(404);
    throw new Error(`No news found with ID ${newsID}`);
  }

  const transaction = await db_connection.transaction();

  try {
    const year = new Date(news.createdAt).getFullYear().toString();
    const folderPath = path.join(__dirname, '..', `website-repository/newsupdates/${year}/${newsID}`);

    if (fs.existsSync(folderPath)) {
      fs.rmSync(folderPath, { recursive: true, force: true });
    }

    await newsupdates.destroy({ where: { newsupdatesID: newsID }, transaction });
    await transaction.commit();

    // create news notification - modified
    await createNotification({ 
      userID: req.user.userID,
      source: 'News Updates', 
      title: 'News Post Deleted', 
      desc: `News post titled "${news.newsTitle}" has been deleted from the website.`,
      scope: 'global',
    });

    logger.info(`News with ID ${newsID} deleted by user ${req.user.userID}`);
    res.status(200).json({ message: `News with ID ${newsID} deleted successfully.` });

  } catch (error) {

    await transaction.rollback();
    logger.error(`Error deleting news: ${error.message}`);
    res.status(400);
    throw new Error(`Error deleting news: ${error.message}`);
  }

});



export { postNewsupdates, getAllNews, getNews, updateNews, deleteNews }