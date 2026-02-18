import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";



const publications_vw = db_connection.define('publications_vw', {

    publicationsID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    UUID: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    userID: { type: DataTypes.INTEGER, allowNull: false },
    category: { type: DataTypes.STRING(30), allowNull: false},
    title: { type: DataTypes.STRING(225), allowNull: false},
    worktStation: { type: DataTypes.STRING(225), allowNull: false},
    postedBy: { type: DataTypes.TEXT, allowNull: false },
    contentType: { type: DataTypes.STRING(30), allowNull: true},
    contentSize: { type: DataTypes.INTEGER, allowNull: true},
    contentPath: { type: DataTypes.STRING(225), allowNull: true},
    createdAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW } 

}, { tableName: 'publications_vw', createdAt: false, updatedAt: false });



//sync publications_vw model (i.e., check publications_vw view in database if matches, publications_vw model)
publications_vw.sync({ alter:false }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync publications_vw model with publications_vws table in database, ${err}`);
});

export default publications_vw;