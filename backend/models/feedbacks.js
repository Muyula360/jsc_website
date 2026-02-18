import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";
import feedbacksReview from "./feedbacksReview.js";
import feedbacksReads from "./feedbackReads.js";


const feedbacks = db_connection.define('feedbacks', {

    feedbackID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    UUID: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    submitterEmail: { type: DataTypes.STRING(225), allowNull: false },
    submitterName: { type: DataTypes.STRING(225), allowNull: false },
    feedbackSubject: { type: DataTypes.STRING(225), allowNull: false },
    feedbackBody: { type: DataTypes.TEXT, allowNull: false, validate: { notEmpty:{}, len:{args: [10, 500000], msg: 'Feedback body must be between 10 and 500000 characters'} }},
    createdAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW } 

}, { tableName: 'feedbacks', createdAt: false, updatedAt: false });


// feedbacks associations (relationships)
feedbacks.hasMany(feedbacksReview, { foreignKey: 'feedbackID' }); // feedback can have many reviews
feedbacksReview.belongsTo(feedbacks, { foreignKey: 'feedbackID' }); // feedbackReview belongs to feedback

feedbacks.hasMany(feedbacksReads, { foreignKey: 'feedbackID' }); // feedback can have many reads
feedbacksReads.belongsTo(feedbacks, { foreignKey: 'feedbackID' }); // feedbackReads belongs to feedback


//sync feedbacks model (i.e., check feedbacks table in database if matches, feedbacks  model)
feedbacks.sync({ alter:true }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync feedbacks model with feedbacks table in database, ${err}`);
});


export default feedbacks;