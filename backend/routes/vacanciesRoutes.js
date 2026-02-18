import express from 'express';
import { authVerification } from '../middleware/authVerification.js';

//import { protectRoute } from '../middlewares/authMiddleware.js';
import { postVacancy, getAllVacancies, getVacancy, updateVacancy, deleteVacancy } from '../controllers/vacanciesController.js';

const vacanciesRouter = express.Router();


vacanciesRouter.post('/postVacancy', authVerification, postVacancy);
vacanciesRouter.get('/getAllVacancies', getAllVacancies);
vacanciesRouter.get('/getVacancy/:vacancyID', getVacancy);
vacanciesRouter.put('/updateVacancy/:vacancyID', authVerification, updateVacancy);
vacanciesRouter.delete('/deleteVacancy/:vacancyID', authVerification, deleteVacancy);


export default vacanciesRouter;