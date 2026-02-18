import express from 'express';
import { authVerification } from '../middleware/authVerification.js';

//import { protectRoute } from '../middlewares/authMiddleware.js';
import { postTender, getAllTenders, getTender, updateTender, deleteTender } from '../controllers/tenderController.js';

const tenderRouter = express.Router();


tenderRouter.post('/postTender', authVerification, postTender);
tenderRouter.get('/getAllTenders', getAllTenders);
tenderRouter.get('/getTender/:tenderID', getTender);
tenderRouter.put('/updateTender/:tenderID', authVerification, updateTender);
tenderRouter.delete('/deleteTender/:tenderID', authVerification, deleteTender);

export default tenderRouter;