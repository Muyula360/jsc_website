import { Sequelize } from "sequelize";
import { logger } from "../utils/logger.js";
import dotenv from "dotenv";

dotenv.config();

const db_connection = new Sequelize({
    dialect: process.env.DB_DIALECT,
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    database: process.env.DATABASE,
    username: process.env.DB_USER,
    password: process.env.DB_PWD
});

db_connection.authenticate().then(() => {

    logger.info(`Connection to PostgreSQL Server (${process.env.DATABASE}) is successfully established`);

}).catch((error) => {

    logger.error(`Couldn't establish connection to PostgreSQL Server (${process.env.DATABASE}), Message: ${error.message}, Stack: ${error.stack}`);

});

export{ db_connection }