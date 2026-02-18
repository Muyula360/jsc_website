import dotenv, {config} from "dotenv";
import nodemailer from "nodemailer";
import { logger } from "../utils/logger.js";

dotenv.config();

const sendEmail = async( to, recepientName, subject, body ) => {

    // Create transporter
    let transporter = nodemailer.createTransport({

        host: process.env.MAIL_HOST,
        //port: process.env.MAIL_POST,
        // host: "smtp.mailtrap.io",
        // port: 2525,
        auth: {
            // user: process.env.Mail_User,
            // pass: process.env.Mail_Pass
            // user: "34d0c2cee1b7c8",
            // pass: "ffbbc1120843a6"
        },
        tls: {
            rejectUnauthorized: false,
        },
        logger: true, // log to console
        debug: true // include SMTP traffic in the logs
    });

    // Email options
    let mailOptions = {

        email: to,
        fullname: recepientName,
        subject: subject,
        mail: body,
    };

    console.log('body email', mailOptions);

    // Send email
    try {

        let info = await transporter.sendMail(mailOptions);
        console.log(`Email sent: ${info.response}, ${mailOptions.to}`);

        logger.info(`Email to ${to} is successfully sent`);
        return info.response;

    } catch (error) {

        console.error(`Error sending email: ${error.message}`);
        throw error;
    }

}

export default sendEmail;