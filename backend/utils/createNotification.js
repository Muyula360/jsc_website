import notification from '../models/notifications.js';
import { logger } from './logger.js';

/**
 * Sends a notification to a specific user or broadcast scope.
 * 
 * @param {Object} params
 * @param {string} params.userID - The target user ID (if personal).
 * @param {string} params.title - Notification title.
 * @param {string} params.desc - Notification description/body.
 * @param {string} params.scope - Notification scope: 'personal', 'department', or 'global'.
 */


const createNotification = async ({ userID = null, source, title, desc, scope = 'personal' }) => {

  try {

    await notification.create({ userID, notificationTitle: title, notificationSource: source, notificationDesc: desc, broadcastScope: scope, });

    logger.info(`Notification sent: [${scope}] ${title} ${userID ? `-> user ${userID}` : ''}`);
    
  } catch (err) {
    
    logger.error(`Failed to create notification: ${err.message}`);
    throw new Error('Notification failed');
  }

};

export default createNotification;