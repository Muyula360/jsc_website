import express from 'express';
import { authVerification } from '../middleware/authVerification.js';

//import { protectRoute } from '../middlewares/authMiddleware.js';
import { getContenthighlights, getWeeklyVisitsTrends } from '../controllers/trendsController.js';

const trendsRouter = express.Router();


trendsRouter.get('/contenthighlights', authVerification, getContenthighlights);
trendsRouter.get('/weeklyVisitsTrends', authVerification, getWeeklyVisitsTrends);


export default trendsRouter;