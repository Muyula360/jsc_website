import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";



const speeches = db_connection.define('speeches', {

    announcementID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    UUID: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    userID: { type: DataTypes.INTEGER, allowNull: false, references:{ model: 'user', key: 'userID' } },
    announcementTitle: { type: DataTypes.STRING(225), allowNull: false},
    announcementDesc: { type: DataTypes.TEXT, allowNull: false},
    hasAttachment: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 0 },
    attachmentPath: { type: DataTypes.STRING(225), allowNull: false, defaultValue: 'N/A' },
    postedAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW } 

}, { tableName: 'speeches', createdAt: false, updatedAt: false });




//sync speeches model (i.e., check speeches table in database if matches, speeches model)
speeches.sync({ alter:true }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync speeches model with speeches table in database, ${err}`);
});

export default speeches;