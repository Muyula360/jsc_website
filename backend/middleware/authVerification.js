import asyncHandler from "express-async-handler"
import jwt from "jsonwebtoken";
import user from '../models/user.js';

const authVerification = asyncHandler ( async (req, res, next) => {

    let authToken;

    // retrieve JoTWeb_AuthauthToken from cookies
    authToken = req.cookies.JoTWeb_AuthToken;

    if(authToken){

        try{
            //decode the authToken
            const decode = jwt.verify(authToken, process.env.SECRET_KEY);

            // retrieve use data from database (using extracted userID from decoded authToken)
            const userDetails = await user.findByPk( decode.userID, { attributes: ['userID', 'userEmail', 'userfname', 'userMidname', 'userSurname', 'userRole', 'userStatus', 'worktStation'] } );

            //attach userDetails to the request
            req.user = userDetails;

            next();

        }catch(err){

            res.status(400);
            throw new Error(`Not authorized, invalid authorization token. ${err}`);

        }

    }else{

        res.status(400);
        throw new Error('Not authorized, request has no authorization token');
    }

});

export { authVerification }