import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";



const websiteVisitSummaryVw = db_connection.define('websiteVisit', {

    today_visits:  { type: DataTypes.BIGINT },
    this_week_visits: { type: DataTypes.BIGINT },
    this_month_visits: { type: DataTypes.BIGINT },
    this_year_visits: { type: DataTypes.BIGINT }, 

}, { tableName: 'website_visits_summary_vw', createdAt: false, updatedAt: false });



//sync websiteVisitSummary_view model (i.e., check wwebsiteVisitSummary_view model in database if matches, websiteVisitSummary_view model)
websiteVisitSummaryVw.sync({ alter:false }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync websitevisitSummary_view model with websitevisitSummary_view in database, ${err}`);
});

export default websiteVisitSummaryVw;