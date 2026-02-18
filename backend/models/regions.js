import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";



const regions = db_connection.define('regions', {

    regionID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    UUID: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    regionName: { type: DataTypes.STRING(225), allowNull: false },
    regionCode: { type: DataTypes.STRING(50), allowNull: false },
    createdAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW }

}, { tableName: 'regions', createdAt: false, updatedAt: false });



//sync regions model (i.e., check regions table in database if matches, regions model)
regions.sync({ alter:true }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync regions model with regions table in database, ${err}`);
});

export default regions;