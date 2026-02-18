import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";



const leaders_vw = db_connection.define('leaders_vw', {

    leaderID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    UUID: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    userID: { type: DataTypes.INTEGER, allowNull: false },
    leadersTitleID: { type: DataTypes.INTEGER, allowNull: false },
    title: { type: DataTypes.STRING(225), allowNull: false },
    titleDesc: { type: DataTypes.TEXT, allowNull: false, defaultValue: "Not Attached" },
    level: { type: DataTypes.INTEGER, allowNull: false },
    fname: { type: DataTypes.STRING(225), allowNull: false },
    midName: { type: DataTypes.STRING(225), allowNull: false },
    surname: { type: DataTypes.STRING(225), allowNull: false },
    fullname: { type: DataTypes.STRING(225), allowNull: false },
    prefix: { type: DataTypes.STRING(50), allowNull: false },
    email: { type: DataTypes.STRING(225), allowNull: false, defaultValue: "Not Attached" },
    phone: { type: DataTypes.STRING(50), allowNull: false, defaultValue: "Not Attached" },
    profession: { type: DataTypes.STRING(225), allowNull: false },
    experienceYears: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 0 },
    profile_pic_path: { type: DataTypes.STRING(225), allowNull: false, defaultValue: "Not Attached" },
    bio: { type: DataTypes.TEXT, allowNull: false, defaultValue: "Not Attached" },
    linkedin_acc: { type: DataTypes.STRING(225), allowNull: false, defaultValue: "Not Attached"},
    fb_acc: { type: DataTypes.STRING(225), allowNull: false, defaultValue: "Not Attached" },
    twitter_acc: { type: DataTypes.STRING(225), allowNull: false, defaultValue: "Not Attached" },
    instagram_acc: { type: DataTypes.STRING(225), allowNull: false, defaultValue: "Not Attached" },
    status: { type: DataTypes.STRING(30), allowNull: false, defaultValue: "Active" },
    createdAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW }

}, { tableName: 'leaders_vw', createdAt: false, updatedAt: false });



//sync leaders_vw model (i.e., check leaders_vw view in database if matches, leaders_vw model)
leaders_vw.sync({ alter:false }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync leaders_vw model with leaders_vw view in database, ${err}`);
});

export default leaders_vw;