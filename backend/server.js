import express from "express";
import dotenv, {config} from "dotenv";
import cookieParser from "cookie-parser"
import { fileURLToPath } from "url";
import { dirname } from "path";
import path from "path";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);


import { csrfProtection } from './middleware/csrfMiddleware.js';
import { logger } from "./utils/logger.js";
import { notFound, errorHandler } from "./middleware/errorHandlerMiddleware.js";
import authRouter from "./routes/authRoutes.js";
import userRouter from "./routes/userRoutes.js";
import feedbackRouter from "./routes/feedbackRoutes.js";
import websiteVisitRouter from "./routes/websiteVisitRoutes.js";
import announcementRouter from "./routes/announcementRoutes.js";
import newsupdatesRouter from "./routes/newsupdatesRoutes.js";
import billboardRouter from "./routes/billboardRoutes.js";
import newsletterRouter from "./routes/newsletterRouters.js";
import vacanciesRouter from "./routes/vacanciesRoutes.js";
import tenderRouter from "./routes/tenderRoutes.js";
import publicationRouter from "./routes/publicationRoutes.js";
import galleryRouter from "./routes/galleryRoutes.js";
import leadersRouter from "./routes/leaderRouter.js";
import notificationRouter from "./routes/notificationRoutes.js";
import trendsRouter from "./routes/trendsRoutes.js";
import SpeechRouter from "./routes/speechRoutes.js";
import FAQRouter from "./routes/faqsRoutes.js";

// initiate dotenv
dotenv.config();

// initiate express app
const app = express();
const PORT = process.env.PORT;

// Middlewaree
app.use(cookieParser());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(csrfProtection);

// Serve static files
app.use('/website-repository', express.static(path.join(__dirname, 'website-repository')));

// API routers
app.use('/api/auth', authRouter);
app.use('/api/user', userRouter);
app.use('/api/announcement', announcementRouter);
app.use('/api/speech', SpeechRouter);
app.use('/api/faq', FAQRouter); 
app.use('/api/billboard', billboardRouter);
app.use('/api/newsupdates', newsupdatesRouter);
// app.use('/api/project', projectRouter);
app.use('/api/tender', tenderRouter);
app.use('/api/leader', leadersRouter);
app.use('/api/newsletter', newsletterRouter);
app.use('/api/vacancy', vacanciesRouter);
app.use('/api/publication', publicationRouter);
app.use('/api/gallery', galleryRouter);
app.use('/api/feedback', feedbackRouter);
app.use('/api/trends', trendsRouter);
app.use('/api/notification', notificationRouter);
app.use('/api/websiteVisit', websiteVisitRouter);
app.get('/api/csrf-token', (req, res) => { 
    logger.info(`CSRF Token issued`); 
    res.json({ csrfToken: req.csrfToken() }); 
});


// website storage dir (repository)
app.use('/website-repository', express.static(path.join(__dirname, '../website-repository')));


// Error handling middleware
app.use(notFound);
app.use(errorHandler);

app.listen(PORT, () => {
    logger.info(`Express server is listening on ${PORT}`)
    console.log(`Express server is listening on ${PORT}`);
    
});