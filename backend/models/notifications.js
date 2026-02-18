import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";
import notificationReads from "./notificationReads.js";



const notification = db_connection.define('notification', {

    notificationID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    UUID: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    userID: { type: DataTypes.INTEGER, allowNull: false },
    notificationSource: { type: DataTypes.STRING(225), allowNull: false},
    notificationTitle: { type: DataTypes.STRING(225), allowNull: false},
    notificationDesc: { type: DataTypes.TEXT, allowNull: false},
    broadcastScope: { type: DataTypes.STRING(225), allowNull: false},
    createdAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW } 

}, { tableName: 'notifications', createdAt: false, updatedAt: false });


// notification associations (relationships)
notification.hasMany(notificationReads, { foreignKey: 'notificationID' }); // notification can have many reads
notificationReads.belongsTo(notification, { foreignKey: 'notificationID' }); // notificationReads belongs to notification


//sync notification model (i.e., check notifications table in database if matches, notification model)
notification.sync({ alter:true }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync notification model with notifications table in database, ${err}`);
});

export default notification;