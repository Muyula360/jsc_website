import asyncHandler from 'express-async-handler';
import faqs from '../models/faqs.js';
import faqs_vw from '../models/faqs_vw.js';
import { db_connection } from '../config/db_connection.js';
import { logger } from "../utils/logger.js";
import { fileURLToPath } from 'url';
import { dirname } from 'path';
import path from 'path';

import createNotification from '../utils/createNotification.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);


//desc      add new FAQ
//access    Protected
//route     POST --> /api/faq/postFAQ
const postFAQ = asyncHandler(async (req, res) => {

  const { question, answer } = req.body;

  if (!question || !answer) {
    console.log(req.body);
    res.status(400);
    throw new Error('Question and answer are required fields');
  }

  const transaction = await db_connection.transaction();

  try {

    logger.info(`Attempting to create new FAQ`);

    // Create FAQ into db - match your faqs model fields
    const newFAQ = await faqs.create({
      userID: req.user.userID,
      question: question.trim(),
      answer: answer.trim(),
      UUID: req.body.UUID || null // Optional, will use default if not provided
    }, { transaction });

    await transaction.commit();

    // Create FAQ notification - posted
    await createNotification({
      userID: req.user.userID,
      source: 'FAQ',
      title: 'New FAQ Alert',
      desc: `A new FAQ titled "${newFAQ.question}" has been added to the knowledge base.`,
      scope: 'global',
    });

    logger.info(`Successfully created FAQ with ID ${newFAQ.faqsID}`);
    res.status(201).json({
      message: 'FAQ created successfully',
      faqId: newFAQ.faqsID
    });

  } catch (error) {

    await transaction.rollback();
    res.status(400);
    throw new Error(`Error creating FAQ: ${error.message}`);

  }

});


//desc      retrieve all FAQs
//access    Public
//route     GET --> /api/faq/getAllFAQs
const getAllFAQs = asyncHandler(async (req, res) => {

  try {

    const faqList = await faqs_vw.findAll({
      attributes: [
        'faqsID',
        'question',
        'answer',
        'postedBy',
        'worktStation',
        'postedAt'
      ],
      order: [['faqsID', 'DESC']],
    });

    res.status(200).json(faqList);

  } catch (err) {

    logger.error(`Error fetching FAQs: ${err.message}`);
    res.status(400);
    throw new Error(`Error fetching FAQs: ${err.message}`);
  }

});


//desc      retrieve single FAQ
//access    Public
//route     GET --> /api/faq/getFAQ/:faqsID
const getFAQ = asyncHandler(async (req, res) => {

  if (!req.params || !req.params.faqsID) {
    res.status(400);
    throw new Error(`Error fetching FAQ, no parameter provided`);
  }

  try {

    const faqDetails = await faqs.findOne({
      attributes: ['faqsID', 'question', 'answer', 'postedAt'],
      where: { faqsID: req.params.faqsID }
    });

    if (!faqDetails) {
      res.status(404);
      throw new Error(`FAQ not found with ID: ${req.params.faqsID}`);
    }

    res.status(200).json(faqDetails);

  } catch (err) {

    logger.error(`Error fetching FAQ: ${err.message}`);
    res.status(400);
    throw new Error(`Error fetching FAQ: ${err.message}`);
  }

});


//desc      update existing FAQ
//access    Protected
//route     PUT --> /api/faq/updateFAQ/:faqsID
const updateFAQ = asyncHandler(async (req, res) => {

  const faqsID = req.params.faqsID;
  const { question, answer } = req.body;

  if (!question || !answer) {
    res.status(400);
    throw new Error('Question and answer are required.');
  }

  const transaction = await db_connection.transaction();

  try {

    const existingFAQ = await faqs.findByPk(faqsID);

    if (!existingFAQ) {
      res.status(404);
      throw new Error(`FAQ not found with ID: ${faqsID}`);
    }

    existingFAQ.question = question.trim();
    existingFAQ.answer = answer.trim();

    await existingFAQ.save({ transaction });
    await transaction.commit();

    // Create FAQ notification - modified
    await createNotification({
      userID: req.user.userID,
      source: 'FAQ',
      title: 'FAQ Update Alert',
      desc: `FAQ titled "${existingFAQ.question}" has been modified.`,
      scope: 'global',
    });

    logger.info(`Successfully updated FAQ with ID ${faqsID} by user ${req.user.userID}`);
    res.status(200).json({ message: 'FAQ updated successfully' });

  } catch (error) {
    await transaction.rollback();
    res.status(400);
    throw new Error(`Error updating FAQ: ${error.message}`);
  }

});


//desc      delete existing FAQ
//access    Protected
//route     DELETE --> /api/faq/deleteFAQ/:faqsID
const deleteFAQ = asyncHandler(async (req, res) => {

  const faqsID = req.params.faqsID;
  const transaction = await db_connection.transaction();

  try {

    let questionText;

    const existingFAQ = await faqs.findByPk(faqsID);

    if (!existingFAQ) {
      res.status(404);
      throw new Error(`FAQ not found with ID: ${faqsID}`);
    }

    // Store question for notification
    questionText = existingFAQ.question;

    await existingFAQ.destroy({ transaction });
    await transaction.commit();

    // Create FAQ notification - deleted
    await createNotification({
      userID: req.user.userID,
      source: 'FAQ',
      title: 'FAQ Delete Alert',
      desc: `FAQ titled "${questionText}" has been deleted from the knowledge base.`,
      scope: 'global',
    });

    logger.info(`FAQ with ID ${faqsID} deleted by user ${req.user.userID}`);
    res.status(200).json({ message: 'FAQ deleted successfully' });

  } catch (error) {
    await transaction.rollback();
    res.status(400);
    throw new Error(`Error deleting FAQ: ${error.message}`);
  }

});


export {
  postFAQ,
  getAllFAQs,
  getFAQ,
  updateFAQ,
  deleteFAQ
};