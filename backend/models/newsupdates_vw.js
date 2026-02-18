import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";


const newsupdates_vw = db_connection.define('newsupdates_vw', {

    newsupdatesID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    newsTitle: { type: DataTypes.STRING(225), allowNull: false},
    newsDesc: { type: DataTypes.TEXT, allowNull: false },
    worktStation: { type: DataTypes.STRING(225), allowNull: false},
    postedBy: { type: DataTypes.TEXT, allowNull: false },
    showOnCarouselDisplay: { type: DataTypes.BOOLEAN, allowNull: false, defaultValue: false },
    coverPhotoPath: { type: DataTypes.STRING(225), allowNull: false, defaultValue: "Not Attached" },
    supportingPhotosPaths: { type: DataTypes.ARRAY(DataTypes.STRING), allowNull: true, defaultValue: []},
    postedAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW } 

}, { tableName: 'newsupdates_vw', createdAt: false, updatedAt: false });


//sync newsupdates_vw model (i.e., check newsupdates_vw view in database if matches, newsupdates_vw model)
newsupdates_vw.sync({ alter:false }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync newsupdates_vw model with newsupdates_vw view in database, ${err}`);
});

export default newsupdates_vw;