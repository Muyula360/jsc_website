import express from 'express';
import { authVerification } from '../middleware/authVerification.js';
import { uploadBillboard } from '../config/multer.js';


import { postBillboard, getAllBillboards, getBillboard, updateBillboard, toggleBillboardDisplay, deleteBillboard } from '../controllers/billboardsController.js';


const billboardRouter = express.Router();


billboardRouter.post('/postBillboard', authVerification, uploadBillboard.single('billboardPicture'), postBillboard);
billboardRouter.get('/getBillboard/:billboardID', getBillboard);
billboardRouter.get('/getAllBillboards', getAllBillboards);
billboardRouter.put('/updateBillboard/:billboardID', authVerification, uploadBillboard.single('billboardPicture'), updateBillboard);
billboardRouter.put('/toggleDisplay/:billboardID', authVerification, toggleBillboardDisplay);
billboardRouter.delete('/deleteBillboard/:billboardID', authVerification, deleteBillboard);


export default billboardRouter;