import asyncHandler from 'express-async-handler';
import websiteVisit from '../models/websiteVisit.js';
import websiteVisitSummaryVw from '../models/websiteVisitSummary_vw.js';
import { db_connection } from '../config/db_connection.js';
import { logger } from "../utils/logger.js";
import geoip from 'geoip-lite';
import { UAParser } from 'ua-parser-js';


//desc      insert websit visit
//access    Public
//route     POST --> /api/websiteVisit/postVisit
const postVisit = asyncHandler( async (req, res) => {

    try {
        logger.info(`Attempting to capture new website visit`);

        let isbot = false
        let ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress;
        if (ip.includes('::ffff:')) ip = ip.split('::ffff:')[1];

        const userAgent = req.headers['user-agent'];
        const parser = new UAParser(userAgent);
        const ua = parser.getResult();

        const geo = geoip.lookup(ip) || {};

        if(ua.device.type === 'bot'){
            isbot = true
        }

        const newVisit = await websiteVisit.create({
            session_id: req.sessionID ,
            ip_address: ip,
            user_agent: userAgent,
            referrer: req.headers.referer,
            page_url: req.originalUrl,         
            country: geo.country,
            city: geo.city,
            device_type: ua.device.type || 'desktop',
            browser: ua.browser.name,
            os: ua.os.name,
            is_bot: isbot,
            screen_resolution: req.headers['viewport-width'] ? 
                `${req.headers['viewport-width']}x${req.headers['viewport-height']}` : '0x0',
            language: req.headers['accept-language']?.split(',')[0]
        });

        if(!newVisit){

            throw new Error(`Failed to insert website visit`);   

        }

        logger.info(`Successfully, website visit inserted with ID: ${ newVisit.visitID }`);
        res.status(200).send(JSON.stringify(newVisit, null, 2));

    } catch(error){

        res.status(400);
        throw new Error(`Error inserting website visit: ${error.message}`);   

    }

});


//desc      retrieve all website visits
//access    Public
//route     GET --> /api/websiteVisit/getVisitsStats
const getVisitsStats = asyncHandler( async (req, res) => {

    try {

        logger.info(`Attempting to retrieve website visits stats`);
  
        const allWebsiteVisits = await websiteVisitSummaryVw.findAll({ attributes: ['today_visits', 'this_week_visits', 'this_month_visits', 'this_year_visits'] });
        res.status(200).send(JSON.stringify(allWebsiteVisits, null, 2));
  
    } catch (err) {
 
        logger.error(`Error fetching websites visits stats: ${err.message}`);
    
        res.status(400);
        throw new Error(`Error fetching websites visits stats: ${err.message}`);   
    }
  
});



//desc      retrieve all website visits
//access    Public
//route     GET --> /api/websiteVisit/getAllVisits
const getAllVisits = asyncHandler( async (req, res) => {

    try {

        logger.info(`Attempting to fetch all website visits`);
  
        const allWebsiteVisits = await websiteVisit.findAll({ attributes: ['visitID', 'ip_address', 'user_agent', 'referrer', 'page_url', 'session_id', 'device_type', 'browser', 'os', 'screen_resolution', 'country', 'city', 'language', 'is_bot', 'visitedAt'], order: [['visitID', 'DESC']], });
        res.status(200).send(JSON.stringify(allWebsiteVisits, null, 2));
  
    } catch (err) {
 
        logger.error(`Error fetching websites visits: ${err.message}`);
    
        res.status(400);
        throw new Error(`Error fetching websites visits: ${err.message}`);   
    }
  
});
  
  
//desc      retrieve single website visits
//access    Public
//route     GET --> /api/websiteVisit/getVisit
const getVisit = asyncHandler( async (req, res) => {

    if(!req.params || !req.params.visitID){
        res.status(400);
        throw new Error(`Error fetching website visit, no parameter provided`); 
    }

    try {

        logger.info(`Attempting to fetch visit details for visitID: ${req.params.visitID}`);

        const visitDetails = await websiteVisit.findOne({ attributes: ['visitID', 'ip_address', 'user_agent', 'referrer', 'page_url', 'session_id', 'device_type', 'browser', 'os', 'screen_resolution', 'country', 'city', 'language', 'is_bot', 'visitedAt'], order: [['visitID', 'DESC']], where: { visitID: req.params.visitID } });
        
        if (!visitDetails) {
            res.status(400);
            throw new Error(`Could not find website visit with ID: ${req.params.visitID}`); 
        }

        res.status(200).send(JSON.stringify(visitDetails, null, 2));

    } catch (err) {

        logger.error(`Error fetching vacancy: ${err.message}`);

        res.status(400);
        throw new Error(`Error fetching vacancy: ${err.message}`);   
    }

});


export { postVisit, getVisitsStats, getAllVisits, getVisit }