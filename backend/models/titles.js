import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";



const titles = db_connection.define('titles', {

    titlesID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    UUID: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    title: { type: DataTypes.STRING(50), allowNull: false },
    level: { type: DataTypes.INTEGER, allowNull: false },
    createdAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW }

}, { tableName: 'titles', createdAt: false, updatedAt: false });



//sync titles model (i.e., check titles table in database if matches, titles model)
titles.sync({ alter:true }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync titles model with titles table in database, ${err}`);
});

export default titles;