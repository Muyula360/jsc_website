import { logger } from "../utils/logger.js"


const notFound = (req, res, next) => {

    const error = new Error(`Not Found - ${req.originalUrl}`);
    res.status(404);
    next(error)
    
}

const errorHandler = (err, req, res, next) => {

    let statusCode = res.statusCode === 200 ? 500 : res.statusCode;

    logger.error({ message: err.message, stack: err.stack });

    res.status(statusCode).json({ 
        message: err.message, 
        stack: process.env.NODE_ENV  === 'Production' ? null : err.stack 
    });

}

export { notFound, errorHandler }