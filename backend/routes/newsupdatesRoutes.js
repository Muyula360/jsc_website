import express from 'express';
import { authVerification } from '../middleware/authVerification.js';
import { uploadNews } from '../config/multer.js';


import { postNewsupdates, getAllNews, getNews, updateNews, deleteNews } from '../controllers/newsupdatesController.js';

const newsupdatesRouter = express.Router();


newsupdatesRouter.post('/postNewsupdates', authVerification, uploadNews.fields([{ name:"newsPhotos", maxCount: 5 }]), postNewsupdates);
newsupdatesRouter.get('/getAllNews', getAllNews);
newsupdatesRouter.get('/getNews/:newsID', getNews);
newsupdatesRouter.put('/updateNews/:newsID', authVerification, uploadNews.fields([{ name:"newsPhotos", maxCount: 5 }]), updateNews);
newsupdatesRouter.delete('/deleteNews/:newsID', authVerification, deleteNews);


export default newsupdatesRouter;