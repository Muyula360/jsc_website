import winston from 'winston';

// severity levels.
const levels = {
  error: 0,
  warn: 1,
  info: 2,
  http: 3,
  debug: 4,
}

// set the current severity based on current running environment
const level = () => {
  const env = process.env.NODE_ENV || 'DEVELOPMENT'
  const isDevelopment = env === 'DEVELOPMENT'
  return isDevelopment ? 'debug' : 'warn'
}

// set colors for each level.
const colors = {
  error: 'red',
  warn: 'yellow',
  info: 'green',
  http: 'magenta',
  debug: 'white',
}

// add defined colors to winston logger
winston.addColors(colors)

// Customizing the log format.
const format = winston.format.combine(
  winston.format.timestamp({ format: 'YYYY-MM-DD HH:mm:ss:ms' }),
  winston.format.colorize({ all: true }),
  winston.format.printf(
    (info) => `${info.timestamp} ${info.level}: ${info.message}`,
  ),
)

// Transports which will be used by the logger to print out messages.
const transports = [
  new winston.transports.Console(),
  new winston.transports.File({
    filename: 'logs/server_err_logs.log',
    level: 'error',
  }),
  new winston.transports.File({ filename: 'logs/server_logs.log' }),
]

// Logger instance to be exported
const logger = winston.createLogger({
  level: level(),
  levels,
  format,
  transports,
})


export { logger }