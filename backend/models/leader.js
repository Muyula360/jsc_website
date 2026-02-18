import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";



const leader = db_connection.define('leader', {

    leaderID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    UUID: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    userID: { type: DataTypes.INTEGER, allowNull: false },
    leadersTitleID: { type: DataTypes.INTEGER, allowNull: false },
    fname: { type: DataTypes.STRING(225), allowNull: false },
    midName: { type: DataTypes.STRING(225), allowNull: false },
    surname: { type: DataTypes.STRING(225), allowNull: false },
    prefix: { type: DataTypes.STRING(50), allowNull: false, defaultValue: "Not Attached"},
    email: { type: DataTypes.STRING(225), allowNull: false, defaultValue: "Not Attached" },
    profession: { type: DataTypes.STRING(225), allowNull: false },
    experienceYears: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 0 },
    phone: { type: DataTypes.STRING(50), allowNull: false, defaultValue: "Not Attached" },
    profile_pic_path: { type: DataTypes.STRING(225), allowNull: false, defaultValue: "Not Attached" },
    bio: { type: DataTypes.TEXT, allowNull: false, defaultValue: "Not Attached" },
    linkedin_acc: { type: DataTypes.STRING(225), allowNull: false, defaultValue: "Not Attached"},
    fb_acc: { type: DataTypes.STRING(225), allowNull: false, defaultValue: "Not Attached" },
    twitter_acc: { type: DataTypes.STRING(225), allowNull: false, defaultValue: "Not Attached" },
    instagram_acc: { type: DataTypes.STRING(225), allowNull: false, defaultValue: "Not Attached" },
    status: { type: DataTypes.STRING(30), allowNull: false, defaultValue: "Active" },
    createdAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW }

}, { tableName: 'leaders', createdAt: false, updatedAt: false });



//sync leader model (i.e., check leader table in database if matches, leader model)
leader.sync({ alter:true }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync leader model with leader table in database, ${err}`);
});

export default leader;