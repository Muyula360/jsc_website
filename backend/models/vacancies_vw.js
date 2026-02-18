import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";


const vacancies_vw = db_connection.define('vacancies_vw', {

    vacancyID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    vacancyTitle: { type: DataTypes.STRING(225), allowNull: false },
    vacancyDesc: { type: DataTypes.TEXT, allowNull: false },
    vacantPositions: { type: DataTypes.INTEGER, allowNull: false },
    openDate: { type: DataTypes.DATE, allowNull: false },
    closeDate: { type: DataTypes.DATE, allowNull: false },
    postedBy: { type: DataTypes.TEXT, allowNull: false },
    worktStation: { type: DataTypes.STRING(225), allowNull: false },    
    hasAttachment: { type: DataTypes.INTEGER, allowNull: false },
    attachmentPath: { type: DataTypes.STRING(225), allowNull: false },
    link: { type: DataTypes.STRING(225), allowNull: false },
    postedAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW } 

}, { tableName: 'vacancies_vw', createdAt: false, updatedAt: false });



//sync vacancies_vw model (i.e., check vacancies_vw view in database if matches, vacancies_vw model)
vacancies_vw.sync({ alter:false }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync vacancies_vw model with vacancies_vw view in database, ${err}`);
});

export default vacancies_vw;