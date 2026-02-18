import { useParams, Link } from 'react-router-dom';
import { useState, useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import PwdStrengthMeter from '../components/PwdStrengthMeter';

import { resetUserPassword } from '../features/resetPasswordSlice';


const ResetPassword = () => {

    const dispatch = useDispatch();

    const { resetPwdToken } = useParams(); 
    const [ passwordMatched, setPasswordMatched ] = useState(true);
    const [ passwordScore, setPasswordScore ] = useState(0);
 

    const [ isSubmitting, setIsSubmitting ] = useState(false);
    const [ newPassword, setNewPassword ] = useState(``);
    const [ confirmPassword, setConfirmPassword ] = useState(``);

    const { resetPassword, resetPasswordLoading, resetPasswordSuccess, resetPasswordError, resetPasswordMessage } = useSelector((state) => state.resetPassword);


    // handle reset password submit (when user clicks reset password button)
    const handleResetPwdSubmit = async (e) => {
        
        e.preventDefault();

        console.log('submit');

        if(newPassword === confirmPassword){
            
            setIsSubmitting(true);
            setPasswordMatched(true);

            try {

                dispatch(resetUserPassword({ resetPwdToken:resetPwdToken, newPassword:newPassword, confirmPassword:confirmPassword }));

            } finally {

                setIsSubmitting(false);
            }

        }else{

            setPasswordMatched(false);
        }
        
    };


    // a function to update password score from PwdStrengthMeter component
    const updatePwdScore = (pwdScore) => {

        setPasswordScore(pwdScore);

    }


    // useeffect when resetPassword success
    useEffect(() => {

        if(resetPasswordSuccess){ 

            setIsSubmitting(false);
            setNewPassword('');
            setConfirmPassword('');    
        }

    },[ resetPasswordSuccess ]);


    // reset password page UI
    return (
        <>
        <div className='page-banner mb-3'>
            <div className='container py-5'>
                <h2 className='text-white fw-bold'>Reset Password</h2>
                <nav  aria-label='breadcrumb'>
                    <ol className='breadcrumb'>
                        <li className='breadcrumb-item'><Link to='/'>Home</Link></li>
                        <li className='breadcrumb-item active' aria-current='page'>Reset Password</li>
                    </ol>
                </nav> 
            </div> 
        </div>

        <div className='container pb-5 mb-5'>
            <div className='d-flex justify-content-center py-5'>
                <div  style={{ width: '23rem' }}>
                    <form id='resetPasswordForm' onSubmit={ handleResetPwdSubmit }>

                        { resetPasswordError && (<div className="alert alert-danger py-2 mb-3 text-center fs-14" role="alert">{ resetPasswordMessage }</div>) }

                        { resetPasswordSuccess && (<div className="alert alert-success py-2 mb-3 text-center fs-14" role="alert">{ resetPassword.message }</div>) }

                        <div className='mb-3'>
                            <label htmlFor='newpassword' className='form-label'>New Password</label>
                            <input type='password' className='form-control rounded-1' aria-describedby='NewPassword' id='newPassword' name='newPassword' value={newPassword} onChange={(e) => setNewPassword(e.target.value)} autoComplete="current-password" required/>
                        </div>
                        <div className='mb-3'>
                            <label htmlFor='confirmPassword' className='form-label'>Confirm Password</label>
                            <input type='password' className='form-control rounded-1' aria-describedby='ConfrimPassword' id='confirmPassword' name='confirmPassword' value={confirmPassword} onChange={(e) => setConfirmPassword(e.target.value)} required/>
                        </div>
                        <div className='text-center'>
                            <PwdStrengthMeter createdPwd={ newPassword } updatePwdScore={ updatePwdScore } />

                            { newPassword.length > 0 && passwordScore < 3 && (

                                <small className='text-danger font-13'>Weak Password</small>

                            )}

                            { !passwordMatched && (

                                <small className='text-danger font-13'>Passwords don't match</small>

                            )}
                        </div>
                        
                        { passwordScore > 2 && (
                            <button type='submit' className='btn btn-accent rounded-1 w-100 mt-3'  disabled={ resetPasswordLoading }>
                            { resetPasswordLoading && (<span className='spinner-border spinner-border-sm me-2' aria-hidden='true'></span>) }            
                            <span role='loginbutton'> Reset Password </span>
                            </button>
                        )}
                    </form>             
                </div>
            </div>
        </div>
        </>
    )
}


export default ResetPassword