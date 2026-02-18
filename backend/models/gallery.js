import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";


const gallery = db_connection.define('gallery', {

    galleryID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    UUID: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    userID: { type: DataTypes.INTEGER, allowNull: false },
    albumTitle: { type: DataTypes.STRING(225), allowNull: false},
    albumPhotoCount: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 0 },
    albumCoverPhotoPath: { type: DataTypes.STRING(225), allowNull: false, defaultValue: "Not Attached" },
    albumPhotosPaths: { type: DataTypes.ARRAY(DataTypes.STRING), allowNull: true, defaultValue: []},
    postedAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW } 

}, { tableName: 'gallery', createdAt: false, updatedAt: false });


//sync gallery model (i.e., check gallery table in database if matches, gallery model)
gallery.sync({ alter:true }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync gallery model with gallery table in database, ${err}`);
});

export default gallery;