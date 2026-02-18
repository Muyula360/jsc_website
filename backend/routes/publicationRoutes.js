import express from 'express';
import { authVerification } from '../middleware/authVerification.js';
import { uploadPublicContent } from '../config/multer.js';


import { postPubliContent, getAllPubliContents, getPublicContent, updatePubliContent, deletePubliContent } from '../controllers/publicationsController.js';


const publicContentRouter = express.Router();


publicContentRouter.post('/postPublicContent', authVerification, uploadPublicContent.single('publicContentAttachment'), postPubliContent,);
publicContentRouter.get('/getPublicContent/:publicationID', getPublicContent);
publicContentRouter.get('/getAllPublicContents', getAllPubliContents);
publicContentRouter.put('/updatePublicContent/:publicationID', authVerification, uploadPublicContent.single('publicContentAttachment'), updatePubliContent);
publicContentRouter.delete('/deletePublicContent/:publicationID', authVerification, deletePubliContent);


export default publicContentRouter;