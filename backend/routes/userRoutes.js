import express from 'express';
import { uploadUserDP } from '../config/multer.js';
import { authVerification } from '../middleware/authVerification.js';
import { createAccount, getUsersList, getUserByID, getMyDetails, updateUser, deleteUser } from '../controllers/userController.js';

const userRouter = express.Router();


userRouter.post('/createAccount', authVerification, uploadUserDP.single('userProfilePic'), createAccount);
userRouter.get('/getUsersList', authVerification, getUsersList);
// userRouter.get('/getUser', authVerification, getUser);
userRouter.get('/getMyDetails', authVerification, getMyDetails);
userRouter.put('/updateUser/:userID', authVerification, uploadUserDP.single('userProfilePic'), updateUser);
userRouter.delete('/deleteUser/:userID', authVerification, deleteUser);

export default userRouter;