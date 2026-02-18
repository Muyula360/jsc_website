import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";



const tender = db_connection.define('tender', {

    tenderID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    UUID: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    userID: { type: DataTypes.INTEGER, allowNull: false },
    tenderNum: { type: DataTypes.STRING(225), allowNull: false},
    tenderTitle: { type: DataTypes.STRING(225), allowNull: false},
    tenderDesc: { type: DataTypes.TEXT, allowNull: false, defaultValue: "N/A"},
    tenderer: { type: DataTypes.STRING(225), allowNull: false},
    openDate: { type: DataTypes.DATE, allowNull: false},
    closeDate: { type: DataTypes.DATE, allowNull: false},
    hasAttachment: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 0 },
    attachmentPath: { type: DataTypes.STRING(225), allowNull: false, defaultValue: "Not Attached"},
    link: { type: DataTypes.STRING(225), allowNull: false, defaultValue: "Not Attached"},
    postedAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW } 

}, { tableName: 'tenders', createdAt: false, updatedAt: false });




//sync tender model (i.e., check tender table in database if matches, tender model)
tender.sync({ alter:true }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync tender model with tenders table in database, ${err}`);
});

export default tender;