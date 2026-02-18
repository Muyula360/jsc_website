import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";



const workingStation = db_connection.define('workingStation', {

    workingStationID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    UUID: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    workingStation: { type: DataTypes.STRING(225), allowNull: false},
    category: { type: DataTypes.STRING(225), allowNull: false},
    createdAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW } 

}, { tableName: 'workingStation', createdAt: false, updatedAt: false });




//sync workingStation model (i.e., check workingStation table in database if matches, workingStation model)
workingStation.sync({ alter:true }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync workingStation model with workingStation table in database, ${err}`);
});

export default workingStation;