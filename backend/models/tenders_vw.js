import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";



const tenders_vw = db_connection.define('tenders_vw', {

    tenderID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    UUID: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    tenderTitle: { type: DataTypes.STRING(225), allowNull: false},
    tenderDesc: { type: DataTypes.TEXT, allowNull: false, defaultValue: "N/A"},
    tenderer: { type: DataTypes.STRING(225), allowNull: false},
    openDate: { type: DataTypes.DATE, allowNull: false},
    closeDate: { type: DataTypes.DATE, allowNull: false},
    worktStation: { type: DataTypes.STRING(225), allowNull: false},
    postedBy: { type: DataTypes.TEXT, allowNull: false },
    hasAttachment: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 0 },
    attachmentPath: { type: DataTypes.STRING(225), allowNull: false, defaultValue: "Not Attached"},
    link: { type: DataTypes.STRING(225), allowNull: false, defaultValue: "Not Attached"},
    postedAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW } 

}, { tableName: 'tenders_vw', createdAt: false, updatedAt: false });




//sync tenders_vw model (i.e., check tenders_vw view in database if matches, tenders_vw model)
tenders_vw.sync({ alter:false }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync tenders_vw model with tenders_vw view in database, ${err}`);
});

export default tenders_vw;