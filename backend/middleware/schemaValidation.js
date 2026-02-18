import userSchema from '../schemas/userSchema.js'

const validateUser = (req, res, next) => {

  const { error } = userSchema.validate( req.body, { abortEarly: false, allowUnknown: false } ); 

  if (error) {
    const errorMessages = error.details.map(detail => detail.message);    
    throw new Error(`User validation failed: ${errorMessages.join(', ')}`); 
    return res.status(400);
  } 

  next();

};


export { validateUser }