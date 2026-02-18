import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";


const newsupdates = db_connection.define('newsupdates', {

    newsupdatesID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    UUID: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    userID: { type: DataTypes.INTEGER, allowNull: false },
    newsTitle: { type: DataTypes.STRING(225), allowNull: false},
    newsDesc: { type: DataTypes.TEXT, allowNull: false, validate: { notEmpty:{}, len:{args: [10, 500000], msg: 'News body must be between 10 and 500000 characters'} }},
    showOnCarouselDisplay: { type: DataTypes.BOOLEAN, allowNull: false, defaultValue: false },
    coverPhotoPath: { type: DataTypes.STRING(225), allowNull: false, defaultValue: "Not Attached" },
    supportingPhotosPaths: { type: DataTypes.ARRAY(DataTypes.STRING), allowNull: true, defaultValue: []},
    postedAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW } 

}, { tableName: 'newsupdates', createdAt: false, updatedAt: false });


//sync newsupdates model (i.e., check newsupdates table in database if matches, newsupdates model)
newsupdates.sync({ alter:true }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync newsupdates model with newsupdates table in database, ${err}`);
});

export default newsupdates;