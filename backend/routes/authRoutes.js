import express from 'express';
import { authVerification } from '../middleware/authVerification.js';
import { login, authValidation, forgotPassword, resetPassword, logout } from '../controllers/authController.js';

const authRouter = express.Router();


authRouter.post('/login', login);
authRouter.get('/authValidation', authVerification, authValidation);
authRouter.post('/forgotPassword', forgotPassword);
authRouter.post('/resetPassword', resetPassword);
authRouter.get('/logout', logout);


export default authRouter;