import express from 'express';
import { authVerification } from '../middleware/authVerification.js';
import { uploadAnnouncement } from '../config/multer.js';


import { postAnnouncement, getAllAnnouncements, getAnnouncement, updateAnnouncement, deleteAnnouncement } from '../controllers/announcementController.js';


const announcementRouter = express.Router();


announcementRouter.post('/postAnnouncement', authVerification, uploadAnnouncement.single('announcementAttachment'), postAnnouncement);
announcementRouter.get('/getAnnouncement/:announcementID', getAnnouncement);
announcementRouter.get('/getAllAnnouncements', getAllAnnouncements);
announcementRouter.put('/updateAnnouncement/:announcementID', authVerification, uploadAnnouncement.single('announcementAttachment'), updateAnnouncement);
announcementRouter.delete('/deleteAnnouncement/:announcementID', authVerification, deleteAnnouncement);


export default announcementRouter;