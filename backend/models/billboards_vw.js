import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";


const billboards_vw = db_connection.define('billboards_vw', {

    billboardID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    billboardTitle: { type: DataTypes.STRING(225), allowNull: false},
    billboardBody: { type: DataTypes.TEXT, allowNull: false, validate: { notEmpty:{}, len:{args: [10, 500000], msg: 'Billboard body must be between 10 and 500000 characters'} }},
    showOnCarouselDisplay: { type: DataTypes.BOOLEAN, allowNull: false, defaultValue: false },
    worktStation: { type: DataTypes.STRING(225), allowNull: false},
    postedBy: { type: DataTypes.TEXT, allowNull: false },
    billboardPhotoPath: { type: DataTypes.STRING(225), allowNull: false, defaultValue: "Not Attached" },
    postedAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW } 

}, { tableName: 'billboards_vw', createdAt: false, updatedAt: false });


//sync billboards_vw model (i.e., check billboards_vw view in database if matches, billboards_vw model)
billboards_vw.sync({ alter:false }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync billboards_vw model with billboards_vw table in database, ${err}`);
});

export default billboards_vw;