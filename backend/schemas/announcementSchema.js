import Joi from 'joi';

const announcementSchema = Joi.object({

  userId: Joi.number().integer().positive().required()
    .messages({
      'number.base': 'User ID must be a number',
      'number.integer': 'User ID must be an integer',
      'number.positive': 'User ID must be positive',
      'any.required': 'User ID is required'
    }),
  postTitle: Joi.string().trim().min(1).max(255).required()
    .messages({
      'string.empty': 'Post title cannot be empty',
      'string.min': 'Post title must be at least 1 character',
      'string.max': 'Post title cannot exceed 255 characters',
      'any.required': 'Post title is required'
    }),
  postBody: Joi.string().trim().min(1).required()
    .messages({
      'string.empty': 'Post body cannot be empty',
      'string.min': 'Post body must be at least 1 character',
      'any.required': 'Post body is required'
    })
    
});

export default announcementSchema;