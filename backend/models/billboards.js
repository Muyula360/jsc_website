import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";


const billboards = db_connection.define('billboards', {

    billboardID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    UUID: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    userID: { type: DataTypes.INTEGER, allowNull: false },
    billboardTitle: { type: DataTypes.STRING(225), allowNull: false},
    billboardBody: { type: DataTypes.TEXT, allowNull: false, validate: { notEmpty:{}, len:{args: [10, 500000], msg: 'Billboard body must be between 10 and 500000 characters'} }},
    showOnCarouselDisplay: { type: DataTypes.BOOLEAN, allowNull: false, defaultValue: true },
    billboardPhotoPath: { type: DataTypes.STRING(225), allowNull: false, defaultValue: "Not Attached" },
    postedAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW } 

}, { tableName: 'billboards', createdAt: false, updatedAt: false });


//sync billboards model (i.e., check billboards table in database if matches, billboards model)
billboards.sync({ alter:true }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync billboards model with billboards table in database, ${err}`);
});

export default billboards;