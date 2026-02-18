
import asyncHandler from 'express-async-handler';
import { db_connection } from '../config/db_connection.js';
import { logger } from "../utils/logger.js";

import feedback from '../models/feedbacks.js';
import feedbackReads from '../models/feedbackReads.js';


//desc      add new feedBack
//access    Public
//route     POST --> /api/feedback/postFeedback
const postFeedback = asyncHandler( async (req, res) => {

  const { submitterFullname, submitterEmail, feedbackSubject, feedbackBody } = req.body;

  if( !submitterFullname || !submitterEmail || !feedbackSubject || !feedbackBody ){

    console.log(req.body)
    res.status(400);
    throw new Error('Submitter name, email and feedback subject and body are all required fields');
      
  }

  try {

    logger.info(`Attempting to create user feedback`);

    // Create feedback into db
    const newFeedback = await feedback.create({ submitterName:submitterFullname.trim(), submitterEmail:submitterEmail.trim(), feedbackSubject:feedbackSubject.trim(), feedbackBody:feedbackBody.trim() });
  
    logger.info(`Successfully created feedback with ID ${ newFeedback.feedbackID }`);
    res.status(201).json({ message: 'Feedback submitted successfully', feedbackID: `${ newFeedback.feedbackID}` });

  } catch(error){

    res.status(400);
    throw new Error(`Failed to submit feedback, ${error.message}`);   
  }

});



//desc      retrieve all feedbacks
//access    Protected
//route     GET --> /api/feeback/getAllFeedbacks
const getAllFeedbacks = asyncHandler( async (req, res) => {

  try {

    const allFeedbacks = await feedback.findAll({ attributes: ['feedbackID', 'submitterEmail', 'submitterName', 'feedbackSubject', 'feedbackBody', 'createdAt'], order: [['feedbackID', 'DESC']], });
    res.status(200).send(JSON.stringify(allFeedbacks, null, 2));

  } catch (err) {

    logger.error(`Error fetching feedBacks: ${err.message}`);

    res.status(400);
    throw new Error(`Error fetching feedBacks: ${err.message}`);   
  }

});


//desc      retrieve single feedBack
//access    Protected
//route     GET --> /api/feedback/getFeedback/:feedbackID
const getFeedBack = asyncHandler( async (req, res) => {

  if(!req.params || !req.params.feedbackID){
    res.status(400);
    throw new Error(`Error fetching feedBack, no parameter provided`); 
  }

  try {

    const feedBackDetails = await feedback.findOne({ attributes: ['feedbackID', 'submitterEmail', 'submitterName', 'feedbackSubject', 'feedbackBody', 'createdAt'], where: { feedbackID: req.params.feedbackID } });
    
    if (!feedBackDetails) {
      res.status(400);
      throw new Error(`feedBack not found with ID: ${req.params.feedbackID}`); 
    }

    res.status(200).send(JSON.stringify(feedBackDetails, null, 2));

  } catch (err) {
 
    logger.error(`Error fetching feedBack: ${err.message}`);

    res.status(400);
    throw new Error(`Error fetching feedBack: ${err.message}`);   
  }

});



//desc    Get all feedbacks for the logged-in user with readStatus
//route   GET /api/feedback/getUserFeedbacks 
//access  Protected
const getUserFeedbacks = asyncHandler(async (req, res) => {

  const userID = req.user.userID;

  try {

    // fetch all feedbacks
    const allFeedbacks = await feedback.findAll({ attributes: ['feedbackID', 'submitterEmail', 'submitterName', 'feedbackSubject', 'feedbackBody', 'createdAt'], order: [['feedbackID', 'DESC']], raw: true });


    // get feedbackIDs that this user has read
    const readRecords = await feedbackReads.findAll({ attributes: ['feedbackID'], where: { userID: userID }, raw: true });

    const readIDs = new Set(readRecords.map(r => String(r.feedbackID)));

    // Get read counts for all feedbacks
    const readCountRecords = await feedbackReads.findAll({ attributes: ['feedbackID', [db_connection.fn('COUNT', db_connection.col('userID')), 'readCount'] ], group: ['feedbackID'], raw: true });

    // Map feedbackID => readCount
    const readCountMap = {};
    readCountRecords.forEach(r => { readCountMap[String(r.feedbackID)] = parseInt(r.readCount, 10); });

    // Attach readStatus and readCount
    const feedbacksWithStatus = allFeedbacks.map(n => ({ ...n, readStatus: readIDs.has(String(n.feedbackID)) ? 1 : 0, readCount: readCountMap[String(n.feedbackID)] || 0 }));

    logger.info(`Successfully retrieved feedbacks for user ${userID}`);
    res.status(200).json(feedbacksWithStatus);
    
  } catch (error) {

    logger.error(`Error fetching user feedbacks: ${error.message}`);
    res.status(500);
    throw new Error('Failed to load user Feedbacks');
  }

});



//desc      Update feedback read (insert into feedbackReads)
//access    Protected
//route     POST --> /api/feedback/updateFeedbackRead/:feedbackID
const updateFeedbackRead = asyncHandler(async (req, res) => {

  const { feedbackID } = req.params;

  if (!feedbackID) {
    res.status(400);
    throw new Error("FeedbackID not provided.");
  }

  const transaction = await db_connection.transaction();

  try {

    logger.info(`Attempting to update feedback with ID: ${feedbackID} as read`);

    const existingFeedback = await feedback.findByPk(feedbackID);

    if (!existingFeedback) {
      res.status(404);
      throw new Error(`Feedback not found with ID: ${feedbackID}`);
    }

    // checking if feedback is read
    const isFeedbackRead = await feedbackReads.findOne({ where: { feedbackID: feedbackID, userID: req.user.userID }, transaction });

    // if feedback isnt read update feedback read records
    if (!isFeedbackRead) {
      await feedbackReads.create({ feedbackID: feedbackID, userID: req.user.userID }, { transaction });
      logger.info(`Feedback ${feedbackID} marked as read by user ${req.user.userID}`);
    } else {
      logger.info(`Feedback ${feedbackID} already marked as read by user ${req.user.userID}`);
    }

    await transaction.commit();

    res.status(200).json({ message: "Feedback read recorded." });

  } catch (error) {

    await transaction.rollback();
    logger.error(`Error updating Feedback read: ${error.message}`);
    res.status(500);
    throw new Error(`Failed to update Feedback read: ${error.message}`);

  }
});



//desc      updating feedBack
//access    Protected
//route     PUT --> /api/feedback/updateFeedback
const updateFeedback = asyncHandler( async (req, res) => {



});



//desc      delete feedBack
//access    Protected
//route     DELETE --> /api/feedback/deleteFeedback/:feedbackID
const deleteFeedback = asyncHandler( async (req, res) => {



});



export { postFeedback, getAllFeedbacks, getUserFeedbacks, getFeedBack, updateFeedback, updateFeedbackRead, deleteFeedback }