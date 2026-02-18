import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";



const newsletter_vw = db_connection.define('newsletter_vw', {
    speechID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    UUID: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    userID: { type: DataTypes.INTEGER, allowNull: false },
    // newsletterNo: { type: DataTypes.INTEGER, allowNull: false },
    // newsletterYear: { type: DataTypes.INTEGER, allowNull: false },
    // newsletterMonth:
    worktStation: { type: DataTypes.STRING(225), allowNull: false},
    speechTitle: { type: DataTypes.STRING(225), allowNull: false},
    speechLocation: { type: DataTypes.STRING(60), allowNull: false},
    // newsletterCoverPath: { type: DataTypes.STRING(225), allowNull: false, defaultValue: 'Not Attached' },
    speechPdfPath: { type: DataTypes.STRING(225), allowNull: false, defaultValue: 'Not Attached' },
    // downloads: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 0 },
    // reads: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 0 },
    postedAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW } 

}, { tableName: 'newsletter_vw', createdAt: false, updatedAt: false });


//sync newsletter_vw model (i.e., check newsletter_vw view in database if matches, newsletter_vw model)
newsletter_vw.sync({ alter:false }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync newsletter model with newsletter table in database, ${err}`);
});

export default newsletter_vw;