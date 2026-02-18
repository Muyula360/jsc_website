import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";



const faqs = db_connection.define('faqs', {

    faqsID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    UUID: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    userID: { type: DataTypes.INTEGER, allowNull: false, references:{ model: 'user', key: 'userID' } },
    question: { type: DataTypes.STRING(500), allowNull: false},
    answer: { type: DataTypes.TEXT, allowNull: false},
    postedAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW } 

}, { tableName: 'faqs', createdAt: false, updatedAt: false });




//sync faqs model (i.e., check faqs table in database if matches, faqs model)
faqs.sync({ alter:true }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync faqs model with faqs table in database, ${err}`);
});

export default faqs;