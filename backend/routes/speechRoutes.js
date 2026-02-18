import express from 'express';
import { authVerification } from '../middleware/authVerification.js';
import { uploadAnnouncement } from '../config/multer.js';

import {
  postSpeech,
  getAllSpeeches,
  getSpeech,
  updateSpeech,
  deleteSpeech
} from '../controllers/speechesController.js';

const SpeechRouter = express.Router();

SpeechRouter.post(
  '/postSpeech',
  authVerification,
  uploadAnnouncement.single('announcementAttachment'),
  postSpeech
);

SpeechRouter.get('/getSpeech/:announcementID', getSpeech);
SpeechRouter.get('/getAllSpeeches', getAllSpeeches);
SpeechRouter.put('/updateSpeech/:announcementID',authVerification, uploadAnnouncement.single('announcementAttachment'), updateSpeech);
SpeechRouter.delete('/deleteSpeech/:announcementID', authVerification, deleteSpeech );

export default SpeechRouter;
