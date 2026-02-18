import express from 'express';
import { authVerification } from '../middleware/authVerification.js';
import { uploadGalleryPhotos } from '../config/multer.js';


import { postAlbum, getAlbums, getAlbum } from '../controllers/galleryController.js';

const galleryRouter = express.Router();


galleryRouter.post('/postAlbum', authVerification, uploadGalleryPhotos.fields([{ name:"albumPhotos", maxCount: 5 }]), postAlbum);
galleryRouter.get('/getAlbums', getAlbums);
galleryRouter.get('/getAlbum/:galleryID', getAlbum);


export default galleryRouter;