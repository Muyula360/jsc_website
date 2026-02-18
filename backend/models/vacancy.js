import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";


const vacancy = db_connection.define('vacancy', {

    vacancyID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    UUID: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    userID: { type: DataTypes.INTEGER, allowNull: false },
    vacancyTitle: { type: DataTypes.STRING(225), allowNull: false},
    vacancyDesc: { type: DataTypes.TEXT, allowNull: false, validate: { notEmpty:{}, len:{args: [10, 500000], msg: 'News body must be between 10 and 500000 characters'} }},
    vacantPositions: { type: DataTypes.INTEGER, allowNull: false },
    openDate: { type: DataTypes.DATE, allowNull: false},
    closeDate: { type: DataTypes.DATE, allowNull: false},
    hasAttachment: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 0 },
    attachmentPath: { type: DataTypes.STRING(225), allowNull: false, defaultValue: "Not Attached"},
    link: { type: DataTypes.STRING(225), allowNull: false, defaultValue: "Not Attached"},
    postedAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW } 

}, { tableName: 'vacancies', createdAt: false, updatedAt: false });



//sync vacancy model (i.e., check vacancy table in database if matches, vacancy model)
vacancy.sync({ alter:true }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync vacancy model with vacancies table in database, ${err}`);
});

export default vacancy;