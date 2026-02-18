import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";



const websiteVisit = db_connection.define('websiteVisit', {

    visitID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    UUID: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    ip_address: { type: DataTypes.STRING(255) },
    user_agent: { type: DataTypes.STRING(255) },
    referrer: { type: DataTypes.STRING(500) },
    page_url: { type: DataTypes.STRING(255) },
    session_id: { type: DataTypes.STRING(255) },
    device_type: { type: DataTypes.STRING(225) },
    browser: { type: DataTypes.STRING(225), defaultValue: 'unknown' },
    os: { type: DataTypes.STRING(225), defaultValue: 'unknown' },
    screen_resolution: { type: DataTypes.STRING(225),  defaultValue: '0x0' },
    country: { type: DataTypes.STRING(225), defaultValue: 'unknown' },
    city: { type: DataTypes.STRING(255), defaultValue: 'unknown' },
    language: { type: DataTypes.STRING(255), defaultValue: 'unknown' },
    is_bot: { type: DataTypes.STRING(255) },
    visitedAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW } 

}, { tableName: 'websiteVisit', createdAt: false, updatedAt: false });




//sync websiteVisit model (i.e., check websiteVisit table in database if matches, websiteVisit model)
websiteVisit.sync({ alter:true }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync websitevisits model with websiteVisit table in database, ${err}`);
});

export default websiteVisit;