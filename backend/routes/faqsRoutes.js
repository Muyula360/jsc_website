import express from 'express';
import { authVerification } from '../middleware/authVerification.js';

import {
  postFAQ,
  getAllFAQs,
  getFAQ,
  updateFAQ,
  deleteFAQ
} from '../controllers/faqsController.js';

const FAQRouter = express.Router();

// POST - Create new FAQ (Protected)
FAQRouter.post(
  '/postFAQ',
  authVerification,
  postFAQ
);
FAQRouter.get('/getFAQ/:faqsID', getFAQ);
FAQRouter.get('/getAllFAQs', getAllFAQs);
FAQRouter.put('/updateFAQ/:faqsID', authVerification, updateFAQ);
FAQRouter.delete('/deleteFAQ/:faqsID',authVerification, deleteFAQ);

export default FAQRouter;