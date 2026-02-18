import { logger } from "../utils/logger.js";
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";


const contenthighlights_vw = db_connection.define('contenthighlights_vw', {

    news: { type: DataTypes.INTEGER, allowNull: false },
    announcements: { type: DataTypes.INTEGER, allowNull: false },
    newsletters: { type: DataTypes.INTEGER, allowNull: false },
    tenders: { type: DataTypes.INTEGER, allowNull: false },
    vacancies: { type: DataTypes.INTEGER, allowNull: false },
    feedbacks: { type: DataTypes.INTEGER, allowNull: false }    

}, { tableName: 'contenthighlights_vw', createdAt: false, updatedAt: false });


//sync contenthighlights_vw model (i.e., check contenthighlights_vw view in database if matches, contenthighlights_vw model)
contenthighlights_vw.sync({ alter:false }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync contenthighlights_vw model with contenthighlights_vw view in database, ${err}`);
});

export default contenthighlights_vw;