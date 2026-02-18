import asyncHandler from 'express-async-handler';
import gallery from '../models/gallery.js';
import gallery_vw from '../models/gallery_vw.js';
import { db_connection } from '../config/db_connection.js';
import { logger } from "../utils/logger.js";
import { fileURLToPath } from 'url';
import { dirname } from 'path';
import path from 'path';
import fs from 'fs';


const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);


//desc      post/create album
//access    Protected
//route     POST --> /api/gallery/postAlbum
const postAlbum = asyncHandler( async (req, res) => {

    const { albumTitle } = req.body;

    if( !albumTitle || !req.files['albumPhotos'] ){

        logger.error(`Error: Failed to publish album. Album title and album photos are required fields`);
        res.status(400);
        throw new Error('Album title and album photos are required fields');
        
    }


    const transaction = await db_connection.transaction();

    try {
        
        logger.info(`Attempting to publish gallery album`);
  
        // Create album into db
        const createAlbum  = await gallery.create({ userID:req.user.userID, albumTitle:albumTitle }, { transaction });

        // If album photos were uploaded, move them to the storage location
        if (req.files) {

            const year = new Date().getFullYear().toString();
            const albumRelPath = path.join(`website-repository/gallery/${year}`, createAlbum.galleryID );
            const albumFullPath = path.join(__dirname, '..', albumRelPath); 

            if (!fs.existsSync(albumFullPath)) {
            fs.mkdirSync(albumFullPath, { recursive: true });
            }

            let albumCoverPhotoPath = null;
            let albumPhotosPath = [];
            
          
            // Album photos
            if (req.files['albumPhotos']) {

                // album photos should not exceed 5 photos
                if (req.files['albumPhotos'].length > 5){
                    logger.error(`Error: Failed to publish album, user is attempting to post more than 5 album photos`);
                    res.status(400);
                    throw new Error('You cannt upload more than 5 photos in one album');
                }

                req.files['albumPhotos'].forEach((photo, index) => {

                    const targetPath = path.join(albumFullPath, photo.filename);
                    fs.renameSync(photo.path, targetPath);

                    const photoPath = path.join(albumRelPath, photo.filename).replace(/\\/g, '/'); // Convert Windows slashes to URL-friendly;


                    if (index === 0) {

                        albumCoverPhotoPath = photoPath;                                
                        
                    }else{

                        albumPhotosPath.push(photoPath);
                    }

                });
            }

            // Update album photos path into db
            createAlbum.albumPhotoCount = req.files['albumPhotos'].length;
            createAlbum.albumCoverPhotoPath = albumCoverPhotoPath;
            createAlbum.albumPhotosPaths = albumPhotosPath;

            await createAlbum.save({ transaction });
        }

        await transaction.commit();

        // retrieve all album
        const allAlbmus = await gallery_vw.findAll({ attributes: ['galleryID', 'albumTitle', 'albumPhotoCount', 'albumCoverPhotoPath', 'albumPhotosPaths', 'postedBy', 'worktStation', 'postedAt' ], order: [['galleryID', 'DESC']], });
      
        logger.info(`Successfully created album with ID ${ createAlbum.galleryID }`);

        res.status(201).send(JSON.stringify(allAlbmus, null, 2));


    }catch(error){

        await transaction.rollback();
        
        // Clean up uploaded file
        if (req.file && fs.existsSync(req.file.path)) {
            fs.unlinkSync(req.file.path);
        }

        res.status(400);
        throw new Error(`Failed to publish album: ${error.message}`);   

    }

});


//desc      retrieve all album
//access    Public
//route     GET --> /api/gallery/getAlbums
const getAlbums = asyncHandler( async (req, res) => {

    try {
  
        // retrieve all album
        const allAlbmus = await gallery_vw.findAll({ attributes: ['galleryID', 'albumTitle', 'albumPhotoCount', 'albumCoverPhotoPath', 'albumPhotosPaths', 'postedBy', 'worktStation', 'postedAt' ], order: [['galleryID', 'DESC']], });
        
        res.status(200).send(JSON.stringify(allAlbmus, null, 2));
  
    } catch (err) {
  
        logger.error(`Error fetching news & updates: ${err.message}`);
    
        res.status(400);
        throw new Error(`Error fetching news & updates: ${err.message}`);   
    }
  
  });
  
  
  //desc      retrieve single album
  //access    Public
  //route     GET --> /api/gallery/getAlbum/galleryID
  const getAlbum = asyncHandler( async (req, res) => {
  
    if(!req.params || !req.params.galleryID){
      res.status(400);
      throw new Error(`No parameter provided`); 
    }
  
    try {

        const albumDetails = await gallery_vw.findOne({ attributes: ['galleryID', 'albumTitle', 'albumPhotoCount', 'albumCoverPhotoPath', 'albumPhotosPaths', 'postedBy', 'worktStation', 'postedAt' ], where: { galleryID: req.params.galleryID } });
        
        res.status(200).send(JSON.stringify(albumDetails, null, 2));
  
    } catch (err) {
   
        logger.error(`Failed to retrieve album: ${err.message}`);
    
        res.status(400);
        throw new Error(`Failed to retrieve album: ${err.message}`);   
    }
  
  });



export { postAlbum, getAlbums, getAlbum }