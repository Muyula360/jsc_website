import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";

import leader from "../models/leader.js";


const leadersTitle = db_connection.define('leadersTitle', {

    leadersTitleID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    UUID: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    title: { type: DataTypes.STRING(50), allowNull: false },
    level: { type: DataTypes.INTEGER, allowNull: false },
    titleDesc: { type: DataTypes.TEXT, allowNull: false, defaultValue: "Not Attached" },
    createdAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW }

}, { tableName: 'leadersTitle', createdAt: false, updatedAt: false });


leadersTitle.hasOne(leader, { foreignKey: 'leadersTitleID' }); // title can only be assign to one leader
leader.belongsTo(leadersTitle, { foreignKey: 'leadersTitleID' }); // leader belongs to title

//sync leadersTitle model (i.e., check leadersTitle table in database if matches, leadersTitle model)
leadersTitle.sync({ alter:true }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync leadersTitle model with leadersTitle table in database, ${err}`);
});

export default leadersTitle;