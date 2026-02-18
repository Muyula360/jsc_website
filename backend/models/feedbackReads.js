import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";


const feedbackReads = db_connection.define('feedbackReads', {

    feedbackReadID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    UUID: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    feedbackID: { type: DataTypes.INTEGER, allowNull: false },
    userID: { type: DataTypes.INTEGER, allowNull: false },
    readAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW } 

}, { tableName: 'feedbackReads', createdAt: false, updatedAt: false });


//sync feedbackReads model (i.e., check feedbackReads table in database if matches, feedbackReads  model)
feedbackReads.sync({ alter:true }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync feedbackReads model with feedbackReads table in database, ${err}`);
});


export default feedbackReads;