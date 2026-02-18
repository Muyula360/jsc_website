
import csrf from 'csurf';

// CSRF protection configuration
const csrfProtection = csrf({
  cookie: {
    httpOnly: false, // set to 'false', for frontend to read it
    secure: process.env.NODE_ENV === 'production', // set true in production with HTTPS
    sameSite: 'strict',
    maxAge: 24 * 60 * 60 // 24 hours
  }
});


export { csrfProtection };