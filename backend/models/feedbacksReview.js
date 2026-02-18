import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";


const feedbacksReview = db_connection.define('feedbacksReview', {

    feedbackReviewID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    UUID: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    feedbackID: { type: DataTypes.INTEGER, allowNull: false },
    userID: { type: DataTypes.INTEGER, allowNull: false },
    comments: { type: DataTypes.TEXT, allowNull: false, defaultValue: "Nill", validate: { notEmpty:{}, len:{args: [10, 500000], msg: 'Review comments must be between 10 and 500000 characters'} }},
    createdAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW } 

}, { tableName: 'feedbacksReview', createdAt: false, updatedAt: false });


//sync feedbacksReview model (i.e., check feedbacksReview table in database if matches, feedbacksReview  model)
feedbacksReview.sync({ alter:true }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync feedbacksReview model with feedbacksReview table in database, ${err}`);
});


export default feedbacksReview;