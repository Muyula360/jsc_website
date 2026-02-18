import Joi from 'joi';

const userSchema = Joi.object({

    userWorkstation: Joi.string().trim().min(1).max(255).required()
    .messages({
      'string.empty': 'Workstation cannot be empty',
      'string.min': 'Workstation must be at least 1 character',
      'string.max': 'Workstation cannot exceed 255 characters',
      'any.required': 'Workstation is required'
    }),
    userOfficeEmail: Joi.string().trim().min(1).max(255).required()
    .messages({
      'string.empty': 'User email cannot be empty',
      'string.min': 'User email must be at least 1 character',
      'string.max': 'User email cannot exceed 255 characters',
      'any.required': 'User email is required'
    }),
    userFirstname: Joi.string().trim().min(1).max(255).required()
    .messages({
      'string.empty': 'First name cannot be empty',
      'string.min': 'First name must be at least 1 character',
      'string.max': 'First name cannot exceed 255 characters',
      'any.required': 'First name is required'
    }),
    userMidname: Joi.string().trim().min(1).max(255).required()
    .messages({
      'string.empty': 'Middle name cannot be empty',
      'string.min': 'Middle name must be at least 1 character',
      'string.max': 'Middle name cannot exceed 255 characters',
      'any.required': 'Middle name is required'
    }),
    userSurname: Joi.string().trim().min(1).max(255).required()
    .messages({
      'string.empty': 'Surname cannot be empty',
      'string.min': 'Surname must be at least 1 character',
      'string.max': 'Surname cannot exceed 255 characters',
      'any.required': 'Surname is required'
    }),
    userRole: Joi.string().trim().min(1).max(255).required()
    .messages({
      'string.empty': 'User role cannot be empty',
      'string.min': 'User role must be at least 1 character',
      'string.max': 'User role cannot exceed 255 characters',
      'any.required': 'User role is required'
    })

});

export default userSchema;

