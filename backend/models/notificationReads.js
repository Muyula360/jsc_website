import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";


const notificationReads = db_connection.define('notificationReads', {

    notificationReadID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    UUID: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    notificationID: { type: DataTypes.INTEGER, allowNull: false },
    userID: { type: DataTypes.INTEGER, allowNull: false },
    readAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW } 

}, { tableName: 'notificationReads', createdAt: false, updatedAt: false });


//sync notificationReads model (i.e., check notificationReads table in database if matches, notificationReads model)
notificationReads.sync({ alter:true }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync notificationReads model with notificationReads table in database, ${err}`);
});

export default notificationReads;