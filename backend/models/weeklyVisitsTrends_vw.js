import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";


const weeklyvisittrend_vw = db_connection.define('weeklyvisittrend_vw', {

    visit_date: { type: DataTypes.DATE, allowNull: false},
    total_visits: { type: DataTypes.INTEGER, allowNull: false }

}, { tableName: 'weeklyvisittrend_vw', createdAt: false, updatedAt: false });


//sync weeklyvisittrend_vw model (i.e., check weeklyvisittrend_vw view in database if matches, weeklyvisittrend_vw model)
weeklyvisittrend_vw.sync({ alter:false }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync weeklyvisittrend_vw model with weeklyvisittrend_vw view in database, ${err}`);
});

export default weeklyvisittrend_vw;