import express from 'express';
import { authVerification } from '../middleware/authVerification.js';
import { uploadLeaderProfilePic} from '../config/multer.js';

import { postLeader, getAllLeaders, getLeader } from '../controllers/leaderController.js';

const leadersRouter = express.Router();


leadersRouter.post('/postLeader', authVerification, uploadLeaderProfilePic.single("profilePic"), postLeader);
leadersRouter.get('/getAllLeaders', getAllLeaders );
leadersRouter.get('/getLeader/:leaderID', getLeader );


export default leadersRouter;