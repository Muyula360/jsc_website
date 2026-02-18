import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";



const faqs_vw = db_connection.define('faqs_vw', {

    faqsID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    question: { type: DataTypes.STRING(500), allowNull: false},
    answer: { type: DataTypes.TEXT, allowNull: false},
    postedBy: { type: DataTypes.STRING(225), allowNull: false },
    worktStation: { type: DataTypes.STRING(225), allowNull: false},
    postedAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW },
}, { tableName: 'faqs_vw', createdAt: false, updatedAt: false });





faqs_vw.sync({ alter:false }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync announcement model with announcement table in database, ${err}`);
});

export default faqs_vw;