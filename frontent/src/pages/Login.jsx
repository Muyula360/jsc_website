import { Link, useNavigate } from 'react-router-dom';
import { useState, useEffect, useContext } from 'react';
import { useDispatch, useSelector } from "react-redux";

import { getCSRFToken } from "../features/csrfSlice";
import { userAuthentication } from '../features/authSlice';
import { generateResetPasswordLink, resetForgotPassword } from '../features/forgotPasswordSlice';
import { LanguageContext } from '../context/Language';

const Login = () => {
    const dispatch = useDispatch();
    const navigate = useNavigate();
    const { language } = useContext(LanguageContext);

    // Translations
    const translations = {
        sw: {
            welcome: "Karibu Tena",
            signInToContinue: "Weka akaunti yako ili kuendelea",
            emailAddress: "Barua Pepe",
            emailPlaceholder: "Weka barua pepe yako",
            password: "Nenosiri",
            passwordPlaceholder: "Weka nenosiri lako",
            signIn: "Ingia",
            signingIn: "Inaingia...",
            forgotPassword: "Umesahau nenosiri?",
            backToLogin: "Rudi kwenye Kuingia",
            resetPassword: "Weka Upya Nenosiri",
            resetPasswordInstructions: "Weka barua pepe yako ili kutuma kiungo cha kuweka upya nenosiri",
            sendResetLink: "Tuma Kiungo cha Kurekebisha",
            sending: "Inatuma...",
            needHelp: "Unahitaji usaidizi?",
            contactSupport: "Wasiliana na Usaidizi",
            dataSecure: "Data yako imesimbwa kwa usalama",
            loginError: "Hitilafu ya kuingia: ",
            resetError: "Hitilafu ya kutuma kiungo: ",
            resetSuccess: "Kiungo cha kurekebisha nenosiri kimetumwa kwenye barua pepe yako. Tafadhali angalia inbox yako.",
            emailRequired: "Barua pepe inahitajika",
            passwordRequired: "Nenosiri linahitajika"
        },
        en: {
            welcome: "Welcome Back",
            signInToContinue: "Sign in to your account to continue",
            emailAddress: "Email Address",
            emailPlaceholder: "Enter your email",
            password: "Password",
            passwordPlaceholder: "Enter your password",
            signIn: "Sign In",
            signingIn: "Signing In...",
            forgotPassword: "Forgot your password?",
            backToLogin: "Back to Login",
            resetPassword: "Reset Password",
            resetPasswordInstructions: "Enter your email to send a password reset link",
            sendResetLink: "Send Reset Link",
            sending: "Sending...",
            needHelp: "Need help?",
            contactSupport: "Contact Support",
            dataSecure: "Your data is securely encrypted",
            loginError: "Login error: ",
            resetError: "Reset link error: ",
            resetSuccess: "Password reset link has been sent to your email. Please check your inbox.",
            emailRequired: "Email is required",
            passwordRequired: "Password is required"
        }
    };

    const t = translations[language] || translations.sw;

    const [isSubmitting, setIsSubmitting] = useState(false);
    const [resetPasswordEmail, setResetPasswordEmail] = useState('');
    const [credentials, setCredentials] = useState({ userEmail: '', userPassword: '' });
    const [activeTab, setActiveTab] = useState('login');

    const { authToken, isLoading, isSuccess, isError, message } = useSelector((state) => state.userAuth);
    const { resetLink, resetLinkLoading, resetLinkSuccess, resetLinkError, resetLinkMessage } = useSelector((state) => state.resetPasswordLink);

    const handleChange = (e) => {
        const { name, value } = e.target;
        setCredentials(prev => ({ ...prev, [name]: value }));
    };

    // Handle login submit
    const handleLoginSubmit = async (e) => {
        e.preventDefault();
        setIsSubmitting(true);
        
        try {
            // Validate inputs
            if (!credentials.userEmail.trim()) {
                alert(t.emailRequired);
                setIsSubmitting(false);
                return;
            }
            if (!credentials.userPassword.trim()) {
                alert(t.passwordRequired);
                setIsSubmitting(false);
                return;
            }
            
            dispatch(userAuthentication(credentials));
        } catch (error) {
            setIsSubmitting(false);
        }
    };

    // Handle reset password submit
    const handleResetPasswordSubmit = async (e) => {
        e.preventDefault();
        setIsSubmitting(true);
        
        try {
            if (!resetPasswordEmail.trim()) {
                alert(t.emailRequired);
                setIsSubmitting(false);
                return;
            }
            
            dispatch(generateResetPasswordLink({ resetPasswordEmail: resetPasswordEmail }));
        } catch (error) {
            setIsSubmitting(false);
        }
    };

    const handleTabChange = (tab) => {
        setActiveTab(tab);
        if (tab === 'login') {
            dispatch(resetForgotPassword());
        }
    };

    // Effect for login success redirect
    useEffect(() => {
        if (isSuccess && authToken) {
            navigate('/webcontentsmgr/');
        }
    }, [isSuccess, authToken, navigate]);

    // Effect when reset password link is generated successfully
    useEffect(() => {
        if (resetLinkSuccess) {
            setIsSubmitting(false);
            setResetPasswordEmail('');
        }
    }, [resetLinkSuccess]);

    // Format error message for display
    const getErrorMessage = (message) => {
        if (!message) return '';
        if (message.includes('Invalid credentials') || message.includes('User not found')) {
            return language === 'sw' 
                ? 'Barua pepe au nenosiri si sahihi'
                : 'Invalid email or password';
        }
        if (message.includes('Email not found')) {
            return language === 'sw'
                ? 'Barua pepe haijapatikana'
                : 'Email address not found';
        }
        return message;
    };

    return (
        <div className="d-flex flex-column my-5">
            {/* Main Content */}
            <div className="flex-grow-1 d-flex align-items-center justify-content-center">
                <div className="container">
                    <div className="row justify-content-center">
                        <div className="col-md-8 col-lg-6 col-xl-5">
                            {/* Card Container */}
                            <div className="card border-0 shadow-lg rounded-3 overflow-hidden">
                                {/* Card Header with Tabs */}
                                <div className="card-header bg-white border-0 pt-5 pb-1">
                                    <div className="text-center mb-3">
                                        <h3 className="fw-bold text-dark mb-0">{t.welcome}</h3>
                                        <p className="text-danger small mb-0">{t.signInToContinue}</p>
                                    </div>
                                </div>

                                {/* Card Body */}
                                <div className="card-body px-4 py-2">
                                    {/* Login Form */}
                                    {activeTab === 'login' && (
                                        <div className="tab-content">
                                            <form id='loginForm' onSubmit={handleLoginSubmit}>
                                                {isError && (
                                                    <div className="alert alert-danger py-2 mb-3 text-center rounded-2" role="alert" style={{ fontSize: '0.875rem' }}>
                                                        <i className="bi bi-exclamation-triangle-fill me-2"></i>
                                                        {t.loginError}{getErrorMessage(message)}
                                                    </div>
                                                )}
                                                
                                                <div className="mb-3">
                                                    <label htmlFor='userEmail' className='form-label fw-medium text-dark mb-1 small'>
                                                        {t.emailAddress}
                                                    </label>
                                                    <div className="input-group">
                                                        <span className="input-group-text bg-light border-end-0">
                                                            <i className="bi bi-envelope text-muted"></i>
                                                        </span>
                                                        <input 
                                                            type='email' 
                                                            className='form-control border-start-0 py-2' 
                                                            id='userEmail' 
                                                            name='userEmail' 
                                                            value={credentials.userEmail} 
                                                            placeholder={t.emailPlaceholder}
                                                            onChange={handleChange} 
                                                            autoComplete="email" 
                                                            required
                                                        />
                                                    </div>
                                                </div>
                                                
                                                <div className="mb-4">
                                                    <label htmlFor='userPassword' className='form-label fw-medium text-dark mb-1 small'>
                                                        {t.password}
                                                    </label>
                                                    <div className="input-group">
                                                        <span className="input-group-text bg-light border-end-0">
                                                            <i className="bi bi-lock text-muted"></i>
                                                        </span>
                                                        <input 
                                                            type='password' 
                                                            className='form-control border-start-0 py-2' 
                                                            id='userPassword' 
                                                            name='userPassword' 
                                                            value={credentials.userPassword} 
                                                            placeholder={t.passwordPlaceholder}
                                                            onChange={handleChange} 
                                                            autoComplete="current-password" 
                                                            required
                                                        />
                                                    </div>
                                                </div>
                                                
                                                <div className="d-grid mb-3">
                                                    <button 
                                                        type='submit' 
                                                        className='btn btn-accent py-2 fw-semibold border-0' 
                                                        disabled={isSubmitting || isLoading}
                                                    >
                                                        {isSubmitting || isLoading ? (
                                                            <>
                                                                <span className='spinner-border spinner-border-sm me-2' aria-hidden='true'></span>
                                                                {t.signingIn}
                                                            </>
                                                        ) : (
                                                            <>
                                                                <i className="bi bi-box-arrow-in-right me-2"></i>
                                                                {t.signIn}
                                                            </>
                                                        )}
                                                    </button>
                                                </div>
                                                
                                                <div className="text-center">
                                                    <button 
                                                        type="button"
                                                        className="btn btn-link text-decoration-none text-accent fw-medium small"
                                                        onClick={() => handleTabChange('reset')}
                                                    >
                                                        <i className="bi bi-key me-1"></i>
                                                        {t.forgotPassword}
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    )}
                                    {activeTab === 'reset' && (
                                        <div className="tab-content">
                                            <form id='resetPasswordForm' onSubmit={handleResetPasswordSubmit}>
                                                {resetLinkError && (
                                                    <div className="alert alert-danger py-2 mb-3 text-center rounded-2" role="alert" style={{ fontSize: '0.875rem' }}>
                                                        <i className="bi bi-exclamation-triangle-fill me-2"></i>
                                                        {t.resetError}{getErrorMessage(resetLinkMessage)}
                                                    </div>
                                                )}

                                                {resetLinkSuccess && (
                                                    <div className="alert alert-success py-2 mb-3 text-center rounded-2" role="alert" style={{ fontSize: '0.875rem' }}>
                                                        <i className="bi bi-check-circle-fill me-2"></i>
                                                        {t.resetSuccess}
                                                    </div>
                                                )}
                                                
                                                <div className="mb-4">
                                                    <p className="text-muted small mb-3 text-center">
                                                        {t.resetPasswordInstructions}
                                                    </p>
                                                    <label htmlFor='resetPasswordEmail' className='form-label fw-medium text-dark mb-1 small'>
                                                        {t.emailAddress}
                                                    </label>
                                                    <div className="input-group">
                                                        <span className="input-group-text bg-light border-end-0">
                                                            <i className="bi bi-envelope text-muted"></i>
                                                        </span>
                                                        <input 
                                                            type='email' 
                                                            className='form-control border-start-0 py-2' 
                                                            id='resetPasswordEmail' 
                                                            name='resetPasswordEmail' 
                                                            value={resetPasswordEmail} 
                                                            placeholder={t.emailPlaceholder}
                                                            onChange={(e) => setResetPasswordEmail(e.target.value)} 
                                                            autoComplete="email" 
                                                            required
                                                        />
                                                    </div>
                                                </div>
                                                
                                                <div className="d-grid mb-2">
                                                    <button 
                                                        type='submit' 
                                                        className='btn btn-accent py-2 fw-semibold border-0' 
                                                        disabled={resetLinkLoading}
                                                    >
                                                        {resetLinkLoading ? (
                                                            <>
                                                                <span className='spinner-border spinner-border-sm me-2' aria-hidden='true'></span>
                                                                {t.sending}
                                                            </>
                                                        ) : (
                                                            <>
                                                                <i className="bi bi-send me-2"></i>
                                                                {t.sendResetLink}
                                                            </>
                                                        )}
                                                    </button>
                                                </div>
                                                
                                                <div className="text-center">
                                                    <button 
                                                        type="button"
                                                        className="btn btn-link text-decoration-none text-dark fw-medium small"
                                                        onClick={() => handleTabChange('login')}
                                                    >
                                                        <i className="bi bi-arrow-left me-1"></i>
                                                        {t.backToLogin}
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    )}
                                </div>
                                <div className="card-footer bg-white border-0 text-center pt-1 pb-4">
                                    <p className="text-muted small mb-0">
                                        {t.needHelp} <Link to="/contact" className="text-accent fw-medium text-decoration-none">{t.contactSupport}</Link>
                                    </p>
                                </div>
                            </div>

                            {/* Footer Note */}
                            <div className="text-center mt-3">
                                <p className="text-muted small">
                                    <i className="bi bi-shield-check me-1"></i>
                                    {t.dataSecure}
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default Login;