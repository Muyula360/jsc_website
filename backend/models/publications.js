import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";



const publications = db_connection.define('publications', {

    publicationsID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    UUID: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    userID: { type: DataTypes.INTEGER, allowNull: false },
    category: { type: DataTypes.STRING(30), allowNull: false},
    title: { type: DataTypes.STRING(225), allowNull: false},
    contentType: { type: DataTypes.STRING(30), allowNull: true},
    contentSize: { type: DataTypes.INTEGER, allowNull: true},
    contentPath: { type: DataTypes.STRING(225), allowNull: true},
    createdAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW } 

}, { tableName: 'publications', createdAt: false, updatedAt: false });




//sync publications model (i.e., check publications table in database if matches, publications model)
publications.sync({ alter:true }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync publications model with publicationss table in database, ${err}`);
});

export default publications;