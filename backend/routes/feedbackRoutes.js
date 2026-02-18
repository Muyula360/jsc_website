import express from 'express';
import { authVerification } from '../middleware/authVerification.js';


import { postFeedback, getAllFeedbacks, getUserFeedbacks, getFeedBack, updateFeedback, updateFeedbackRead, deleteFeedback } from '../controllers/feedbacksController.js';

const feedbackRouter = express.Router();


feedbackRouter.post('/postFeedback', postFeedback);
feedbackRouter.get('/getAllFeedbacks', authVerification, getAllFeedbacks );
feedbackRouter.get('/getUserFeedbacks', authVerification, getUserFeedbacks );
feedbackRouter.get('/getFeedBack/:feedbackID', authVerification, getFeedBack );
feedbackRouter.put('/updateFeedback/:feedbackID', authVerification, updateFeedback);
feedbackRouter.post('/updateFeedbackRead/:feedbackID', authVerification, updateFeedbackRead);
feedbackRouter.delete('/deleteFeedback/:feedbackID', authVerification, deleteFeedback);


export default feedbackRouter;