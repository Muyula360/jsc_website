import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";


const gallery_vw = db_connection.define('gallery_vw', {

    galleryID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    userID: { type: DataTypes.INTEGER, allowNull: false },
    albumTitle: { type: DataTypes.STRING(225), allowNull: false},
    worktStation: { type: DataTypes.STRING(225), allowNull: false},
    postedBy: { type: DataTypes.TEXT, allowNull: false },
    albumPhotoCount: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 0 },
    albumCoverPhotoPath: { type: DataTypes.STRING(225), allowNull: false, defaultValue: "Not Attached" },
    albumPhotosPaths: { type: DataTypes.ARRAY(DataTypes.STRING), allowNull: true, defaultValue: []},
    postedAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW } 

}, { tableName: 'gallery_vw', createdAt: false, updatedAt: false });


//sync gallery_vw model (i.e., check gallery_vw view in database if matches, gallery_vw model)
gallery_vw.sync({ alter:false }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync gallery_vw model with gallery_vw view in database, ${err}`);
});

export default gallery_vw;