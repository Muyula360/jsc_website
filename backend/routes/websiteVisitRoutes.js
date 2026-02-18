import express from 'express';
import { authVerification } from '../middleware/authVerification.js';

import { postVisit, getVisitsStats, getAllVisits, getVisit } from '../controllers/websiteVisitController.js';

const websiteVisitRouter = express.Router();


websiteVisitRouter.post('/postVisit', postVisit);
websiteVisitRouter.get('/getVisitsStats', getVisitsStats);
websiteVisitRouter.get('/getAllVisits', getAllVisits);
websiteVisitRouter.get('/getVisit/:visitID', getVisit);


export default websiteVisitRouter;