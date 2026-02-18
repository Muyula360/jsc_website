import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";



const announcement = db_connection.define('announcement', {

    announcementID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    UUID: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    userID: { type: DataTypes.INTEGER, allowNull: false, references:{ model: 'user', key: 'userID' } },
    announcementTitle: { type: DataTypes.STRING(225), allowNull: false},
    announcementDesc: { type: DataTypes.TEXT, allowNull: false},
    hasAttachment: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 0 },
    attachmentPath: { type: DataTypes.STRING(225), allowNull: false, defaultValue: 'N/A' },
    postedAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW } 

}, { tableName: 'announcements', createdAt: false, updatedAt: false });




//sync announcement model (i.e., check announcement table in database if matches, announcement model)
announcement.sync({ alter:true }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync announcement model with announcement table in database, ${err}`);
});

export default announcement;