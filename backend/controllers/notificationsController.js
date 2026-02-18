import asyncHandler from 'express-async-handler';
import { db_connection } from '../config/db_connection.js';
import { Op, and } from 'sequelize';
import { logger } from "../utils/logger.js";
import axios from "axios";

import notification from '../models/notifications.js';
import notificationReads from '../models/notificationReads.js';
import createNotification from '../utils/createNotification.js';


//desc      send email notification to user
//access    Protected
//route     POST --> /api/notification/sendEmail
const sendNotification = asyncHandler( async (req, res) => {

    const { recepientEmail, recepientName, emailSubject, emailMessage } = req.body;

    if( !recepientName || !recepientEmail || !emailSubject || !emailMessage ){

        res.status(400);
        throw new Error('Submitter email, name, subject and message are all required fields');      
    }


    try {

        logger.info(`Attempting to send email notification`);

        const response = axios({
            method: "POST",
            url: process.env.MAIL_HOST,
            data: {
              email: recepientEmail,
              fullname: recepientName,
              subject:'Account create',
              mail: 'Your account with the e-mail address: ' + recepientEmail + ' has been created.',
            }
        });

        res.status(201).json(response);
   
    } catch (error) {
        
        console.error("Error sending email:", error);
        logger.error(`Error sending email: ${error.message}`);

        res.status(400);
        throw new Error(`Error sending email, ${error.message}`);  
    }


});


//desc      retrieve Notifications
//access    Protected
//route     GET --> /api/notification/getAllNotifications
const getAllNotifications = asyncHandler(async (req, res) => {

  try {

    const userID = req.user?.userID;

    if (!userID) {
      logger.error(`Unauthorized attempt to retrieve notifications`);
      res.status(401);
      throw new Error('User authentication required');
    }

    logger.info(`User ${userID} is retrieving notifications`);

    const notificationsList = await notification.findAll({ where: { [Op.or]: [{ broadcastScope: 'global' }, { [Op.and]: [{ broadcastScope: 'personal' },{ userID: userID }] }] }, order: [['createdAt', 'DESC']] });

    logger.info(`User ${userID} retrieved ${notificationsList.length} notifications`);
    res.status(200).json(notificationsList);

  } catch (error) {

    logger.error(`Failed to retrieve notifications for user ${req.user?.userID}: ${error.message}`);
    res.status(500);
    throw new Error(`Error retrieving notifications: ${error.message}`);
  }

});



//desc    Get all notifications for the logged-in user with readStatus
//route   GET /api/notification/getUserNotifications
//access  Protected
const getUserNotifications = asyncHandler(async (req, res) => {

  const userID = req.user.userID;

  try {

    // fetch all notifications
    const allNotifications = await notification.findAll({ attributes: ['notificationID', 'notificationTitle', 'notificationDesc', 'createdAt'], where: { [Op.or]: [{ broadcastScope: 'global' }, { [Op.and]: [{ broadcastScope: 'personal' },{ userID: userID }] }] }, order: [['createdAt', 'DESC']], raw: true });


    // get notificationIDs that this user has read
    const readRecords = await notificationReads.findAll({ attributes: ['notificationID'], where: { userID: userID }, raw: true });

    const readIDs = new Set(readRecords.map(r => String(r.notificationID)));

    const notificationsWithStatus = allNotifications.map(n => ({ ...n, readStatus: readIDs.has(String(n.notificationID)) ? 1 : 0 }));

    res.status(200).json(notificationsWithStatus);
    
  } catch (error) {

    console.error(`Error fetching user notifications: ${error.message}`);
    res.status(500);
    throw new Error('Failed to load user notifications');
  }

});



//desc      Update Notification read (insert into notificationReads)
//access    Protected
//route     POST --> /api/notification/updateNotificationRead/:notificationID
const updateNotificationRead = asyncHandler(async (req, res) => {

  const { notificationID } = req.params;

  if (!notificationID) {
    res.status(400);
    throw new Error("Notification ID not provided.");
  }

  const transaction = await db_connection.transaction();

  try {

    logger.info(`Attempting to update notification ID: ${notificationID} as read`);

    const existingNotification = await notification.findByPk(notificationID);

    if (!existingNotification) {
      res.status(404);
      throw new Error(`Notification not found with ID: ${notificationID}`);
    }

    // checking if notification is read
    const isNotificationRead = await notificationReads.findOne({ where: { notificationID: notificationID, userID: req.user.userID }, transaction });

    // if notification isnt read update notification read records
    if (!isNotificationRead) {
      await notificationReads.create({ notificationID: notificationID, userID: req.user.userID }, { transaction });
      logger.info(`Notification ${notificationID} marked as read by user ${req.user.userID}`);
    } else {
      logger.info(`Notification ${notificationID} already marked as read by user ${req.user.userID}`);
    }

    await transaction.commit();

    res.status(200).json({ message: "Notification read recorded." });

  } catch (error) {

    await transaction.rollback();
    logger.error(`Error updating notification read: ${error.message}`);
    res.status(500);
    throw new Error(`Failed to update notification read: ${error.message}`);

  }
});


//desc      update Notification
//access    Protected
//route     PUT --> /api/notification/updateNotification/:notificationID
const updateNotification = asyncHandler( async (req, res) => {



});


//desc      delete Notification
//access    Protected
//route     DELETE --> /api/notification/deleteNotification/:notificationID
const deleteNotification = asyncHandler( async (req, res) => {



});



export  { sendNotification, getAllNotifications, getUserNotifications, updateNotification, updateNotificationRead, deleteNotification } 