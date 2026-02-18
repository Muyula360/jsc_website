import express from 'express';
import { authVerification } from '../middleware/authVerification.js';
import { uploadNewsletter } from '../config/multer.js';

//import { protectRoute } from '../middlewares/authMiddleware.js';
import { postNewsletter, getAllNewsletters, getNewsletter, updateNewsletter, deleteNewsletter } from '../controllers/newsletterController.js';

const newsletterRouter = express.Router();


newsletterRouter.post('/postNewsletter', authVerification, uploadNewsletter.fields([{ name:"newsletterCover", maxCount: 1 },{ name:"newsletterAttachment", maxCount: 1 }]), postNewsletter);
newsletterRouter.get('/getAllNewsletters', getAllNewsletters );
newsletterRouter.get('/getNewsletter/:newsletterID', getNewsletter );
newsletterRouter.put('/updateNewsletter/:newsletterID', authVerification, uploadNewsletter.fields([{ name:"newsletterCover", maxCount: 1 },{ name:"newsletterAttachment", maxCount: 1 }]), updateNewsletter);
newsletterRouter.delete('/deleteNewsletter/:newsletterID', authVerification, deleteNewsletter);



export default newsletterRouter;