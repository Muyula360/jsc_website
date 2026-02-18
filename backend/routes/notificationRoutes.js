import express from 'express';
import { authVerification } from '../middleware/authVerification.js';

//import { protectRoute } from '../middlewares/authMiddleware.js';
import { sendNotification, getAllNotifications, getUserNotifications, updateNotification, updateNotificationRead, deleteNotification } from '../controllers/notificationsController.js';

const notificationRouter = express.Router();


notificationRouter.post('/sendNotification', authVerification, sendNotification);
notificationRouter.get('/getAllNotifications', authVerification, getAllNotifications);
notificationRouter.get('/getUserNotifications', authVerification, getUserNotifications);
notificationRouter.put('/updateNotification/:notificationID', authVerification, updateNotification);
notificationRouter.post('/updateNotificationRead/:notificationID', authVerification, updateNotificationRead);
notificationRouter.delete('/deleteNotification/:notificationID', authVerification, deleteNotification);


export default notificationRouter;