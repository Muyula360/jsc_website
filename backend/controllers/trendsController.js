
import asyncHandler from 'express-async-handler';
import contenthighlights_vw from '../models/contenthighlights_vw.js';
import weeklyVisitsTrends_vw from '../models/weeklyVisitsTrends_vw.js';
import { db_connection } from '../config/db_connection.js';
import { logger } from "../utils/logger.js";


//desc      retrieve WeeklyVisitsTrends
//access    Protected
//route     GET --> /api/tender/weeklyVisitsTrends
const getWeeklyVisitsTrends = asyncHandler( async (req, res) => {

  try {

    const weeklyVisitsTrends = await weeklyVisitsTrends_vw.findAll({ attributes: ['visit_date', 'total_visits'] });
    res.status(200).send(JSON.stringify(weeklyVisitsTrends, null, 2));

  } catch (err) {

    logger.error(`Error fetching weeklyVisitsTrends: ${err.message}`);

    res.status(400);
    throw new Error(`Error fetching weeklyVisitsTrends: ${err.message}`);   
  }

});


//desc      retrieve Contenthighlights
//access    Protected
//route     GET --> /api/tender/contenthighlights
const getContenthighlights = asyncHandler( async (req, res) => {

  try {

    const contenthighlights = await contenthighlights_vw.findAll({ attributes: ['news', 'announcements', 'newsletters', 'tenders', 'vacancies', 'feedbacks'] });
    res.status(200).send(JSON.stringify(contenthighlights, null, 2));

  } catch (err) {

    logger.error(`Error fetching Contenthighlights: ${err.message}`);

    res.status(400);
    throw new Error(`Error fetching Contenthighlights: ${err.message}`);   
  }

});



export { getWeeklyVisitsTrends, getContenthighlights }