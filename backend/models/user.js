import { logger } from "../utils/logger.js";
import bcrypt from "bcryptjs"
import { DataTypes, Sequelize, Model } from "sequelize";
import { db_connection } from "../config/db_connection.js";

import newsupdates from "../models/newsupdates.js";
import announcement from "../models/announcement.js";
import newsletter from "../models/newsletter.js";
import leader from "../models/leader.js";


const user = db_connection.define('user', {

    userID:  { type: DataTypes.BIGINT, autoIncrement: true, primaryKey: true },
    UUID: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    worktStation: { type: DataTypes.STRING(225), allowNull: false},
    userEmail: { type: DataTypes.STRING(225), allowNull: false, unique: true },
    userfname: { type: DataTypes.STRING(225), allowNull: false },
    userMidname: { type: DataTypes.STRING(225), allowNull: false },
    userSurname: { type: DataTypes.STRING(225), allowNull: false },
    userPassword: { type: DataTypes.STRING(225), allowNull: false },
    userRole: { type: DataTypes.STRING(30), allowNull: false },
    userProfilePicPath: { type: DataTypes.STRING(225), allowNull: true, defaultValue: "Not Attached" },
    userVerfication: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 0 },
    userStatus: { type: DataTypes.STRING(30), allowNull: false, defaultValue: "Active" },
    userCreatedAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW } 

}, { tableName: 'user', createdAt: false, updatedAt: false });


// user associations (relationships)
user.hasMany(newsupdates, { foreignKey: 'userID' }); // user can post many newsupdatess
newsupdates.belongsTo(user, { foreignKey: 'userID' }); // newsupdates belongs/posted by user

user.hasMany(announcement, { foreignKey: 'userID' }); // user can post many announcements
announcement.belongsTo(user, { foreignKey: 'userID' }); // announcement belongs/posted by user

user.hasMany(newsletter, { foreignKey: 'userID' }); // user can post many newsletters
newsletter.belongsTo(user, { foreignKey: 'userID' }); // newsletter belongs/posted by user

user.hasMany(leader, { foreignKey: 'userID' }); // user can post many leaders
leader.belongsTo(user, { foreignKey: 'userID' }); // leader can be posted by user


//function to hash user password before inserting a new user
user.beforeCreate(async (user_data, options) => {

    const salt = await bcrypt.genSalt(10);
    const hashPassword = await bcrypt.hash(user_data.userPassword, salt);
    user_data.userPassword =  hashPassword;

});


//function to hash user password while updating user password
user.beforeUpdate(async (user_data, options) => {
  if (user_data.changed('userPassword')) {
    const salt = await bcrypt.genSalt(10);
    const hashPassword = await bcrypt.hash(user_data.userPassword, salt);
    user_data.userPassword = hashPassword;
  }
});

//function to compare loginpassword with the hashedpassword in db
user.prototype.comparePassword = async function (loginPassword) {
    return bcrypt.compare(loginPassword, this.userPassword);
};


//sync user model (i.e., check user table in database if matches, user  model)
user.sync({ alter:true }).then((data) => {

	logger.info(data);

}).catch((err) =>{

    logger.error(`Failed to sync user model with user table in database, ${err}`);
});

export default user;