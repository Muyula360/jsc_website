import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";



const speeches_vw = db_connection.define('speeches_vw', {

    announcementID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    announcementTitle: { type: DataTypes.STRING(225), allowNull: false},
    announcementDesc: { type: DataTypes.TEXT, allowNull: false},
    hasAttachment: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 0 },
    postedBy: { type: DataTypes.STRING(225), allowNull: false },
    worktStation: { type: DataTypes.STRING(225), allowNull: false},
    postedAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW },
    attachmentPath: { type: DataTypes.STRING(225), allowNull: false, defaultValue: 'N/A' }
    
}, { tableName: 'speeches_vw', createdAt: false, updatedAt: false });





speeches_vw.sync({ alter:false }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync announcement model with announcement table in database, ${err}`);
});

export default speeches_vw;