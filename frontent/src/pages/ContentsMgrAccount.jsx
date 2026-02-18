import React, { useState, useEffect } from "react";
import { useDropzone } from "react-dropzone";
import { Link, useNavigate } from 'react-router-dom';
import { useDispatch, useSelector } from "react-redux";

import PwdStrengthMeter from '../components/PwdStrengthMeter';

import { postUser, postReset } from '../features/userSlice';
import { resetUserPassword } from '../features/resetPasswordSlice';


const ContentsMgrAccount = () => { 

  const dispatch = useDispatch();

  const { validatedUser } = useSelector((state) => state.authValidation);

  const { postLoading, postSuccess, postError, message } = useSelector((state) => state.users);
  const { resetPassword, resetPasswordLoading, resetPasswordSuccess, resetPasswordError, resetPasswordMessage } = useSelector((state) => state.resetPassword);

  const { resetPwdToken } = '';
  const [ passwordMatched, setPasswordMatched ] = useState(true);
  const [ passwordScore, setPasswordScore ] = useState(0);
  const [ newPassword, setNewPassword ] = useState(``);
  const [ confirmPassword, setConfirmPassword ] = useState(``);

  const [ userDetails, setUserDetails ] = useState({ userFirstname: '', userMidname: '', userSurname:'', userOfficeEmail:'', userWorkstation:'', userRole:'' });
  const [fileName, setFileName] = useState("Browse user profile picture");
  const [image, setImage] = useState(null);

  const [ isSubmitting, setIsSubmitting ] = useState(false); 


  // handle input changes (user details form)
  const handleInputChange = (e) => {
      const { name, value } = e.target;
      setUserDetails(prev => ({ ...prev, [name]: value }));
  };

  // handle file changes (when user uploads profile picture)
  const handleFileChange = (event) => {
      const selectedFile = event.target.files[0];
      setFileName(selectedFile ? selectedFile.name : "Browse user profile picture");
  };

  // handle on drop (when user drag and drop profile picture)
  const onDrop = (acceptedFiles) => {
    const newImage = Object.assign(acceptedFiles[0], { preview: URL.createObjectURL(acceptedFiles[0]), });

    if (image) {
        URL.revokeObjectURL(image.preview);
    }

    setImage(newImage);
  };


  // handle update password (when user clicks update password button)
  const handleResetPwdSubmit = async (e) => {
      
    e.preventDefault();

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

  // handle create user (when create user/update user button is clicked)
  const handleCreateUser = async (e) => {
      
    e.preventDefault();

    setIsSubmitting(true);
    
    try {
        dispatch( postUser(userDetails) );
        
    } finally {

        setIsSubmitting(true);
    }
  };


  // reset user details form
  const resetFormSubmission = () => {

    setIsSubmitting(false);
    setUserDetails({ userFirstname: '', userMidname: '', userSurname:'', userOfficeEmail:'', userWorkstation:'', userRole:'' });
    setImage(null);
    setFileName("Browse user profile picture");

    dispatch( postReset() );

  };

  // A function to update password score from PwdStrengthMeter component
  const updatePwdScore = (pwdScore) => {
    setPasswordScore(pwdScore);
  }

  // Image preview
  useEffect(() => {
    return () => {
      if (image) {
          URL.revokeObjectURL(image.preview);
      }
    };

  }, [image]);


  const { getRootProps, getInputProps } = useDropzone({ accept: { 'image/jpeg': ['.jpeg', '.jpg'], 'image/png': ['.png'] }, onDrop, multiple: false, });


  // when user is validated (user validation successed) get validated user details, and assign to user details form
  useEffect(() => {
    if (validatedUser) {
      setUserDetails({
        userFirstname: validatedUser.userfname || '',
        userMidname: validatedUser.userMidname || '',
        userSurname: validatedUser.userSurname || '',
        userOfficeEmail: validatedUser.userEmail || '',
        userWorkstation: validatedUser.worktStation || '',
        userRole: validatedUser.userRole || ''
      });
    }
  }, [validatedUser]);


  return (
    <>
      <div className="container-fluid">
        <div className="d-flex justify-content-between align-items-center mb-3">
          <h5 className=""><i className="bi bi-person-lines-fill"></i> My Account </h5>
        </div>

        <div className="card bg-white border-0 p-5">        

          <div className="d-flex align-items-start gap-5">

            <div className="nav flex-column nav-pills p-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
              <div className="mb-4">
                <div className="text-center mb-2">
                  <img src="/userProfilePic.png" className='rounded-5' width='60' alt="Profile" />
                </div>
                <div className="text-center">
                  <h6 className="text-heading fw-semibold mb-1">{ userDetails.userRole }</h6>
                  <span className="text-heading-secondary">{ userDetails.userOfficeEmail }</span>
                </div>
              </div>
              <button className="nav-link rounded-0 my-1 active" id="personal-profile-tab" data-bs-toggle="pill" data-bs-target="#personal-profile" type="button" role="tab" aria-controls="personal-profile" aria-selected="true"> <i className="bi bi-person me-1"></i> User Information</button>
              <button className="nav-link rounded-0 my-1" id="change-password-tab" data-bs-toggle="pill" data-bs-target="#change-password" type="button" role="tab" aria-controls="change-password" aria-selected="false"> <i className="bi bi-shield-lock me-1"></i> Change Password</button>
            </div>

            <div className="tab-content w-50 p-3" id="v-pills-tabContent">

              {/* User Details Form Starts */}
              <div className="tab-pane fade show active" id="personal-profile" role="tabpanel" aria-labelledby="personal-profile-tab" tabIndex="0">                                               
                <div className="row g-3 fs-15">
                    <div className="col-md-4">
                        <label htmlFor="userFirstname" className="form-label">First Name</label>
                        <input type="text" className="form-control form-control-sm text-secondary fs-14" id="userFirstname" name="userFirstname"  value={userDetails.userFirstname} onChange={handleInputChange} autoComplete="userFirstname" disabled/>
                    </div>
                    <div className="col-md-4">
                        <label htmlFor="userMidname" className="form-label">Middle Name</label>
                        <input type="text" className="form-control form-control-sm text-secondary fs-14" id="userMidname" name="userMidname" value={userDetails.userMidname} onChange={handleInputChange} autoComplete="userMidname" disabled/>
                    </div>
                    <div className="col-md-4">
                        <label htmlFor="userSurname" className="form-label">Surname</label>
                        <input type="text" className="form-control form-control-sm text-secondary fs-14" id="userSurname" name="userSurname" value={userDetails.userSurname} onChange={handleInputChange} autoComplete="userSurname" disabled/>
                    </div>
                    <div className="col-12">
                        <label htmlFor="userOfficeEmail" className="form-label">Office Email</label>
                        <input type="email" className="form-control form-control-sm text-secondary fs-14" id="userOfficeEmail" name="userOfficeEmail" value={userDetails.userOfficeEmail} onChange={handleInputChange} autoComplete="userOfficeEmail" disabled/>
                    </div>
                    <div className="col-12">
                        <label htmlFor="userWorkstation" className="form-label">Workstation</label>
                        <select className="form-control form-control-sm text-secondary fs-14" aria-label="Workstation" id="userWorkstation" name="userWorkstation" value={userDetails.userWorkstation} onChange={handleInputChange} disabled>
                            <option defaultValue ></option>
                            <option value="Headquarters">Headquarters</option>
                            <option value="Dar Es Salaam">Dar Es Salaam</option>
                            <option value="Bukoba">Bukoba</option>
                            <option value="Tanga">Tanga</option>
                        </select>
                    </div>

                    <div className="col-12 mb-3">
                        <label htmlFor="userRole" className="form-label">User role</label>
                        <select className="form-control form-control-sm text-secondary fs-14" aria-label="Assign role" id="userRole" name="userRole" value={userDetails.userRole} onChange={handleInputChange} disabled>
                            <option defaultValue ></option>
                            <option value="Admin">Admin</option>
                            <option value="Content Manager">Content Manager</option>
                        </select>
                    </div>
                    <div className="col-12">                              
                    </div>          
                </div>
              </div>
              {/* User Details Form ends */}


              {/* Change Password Form Starts */}
              <div className="tab-pane fade" id="change-password" role="tabpanel" aria-labelledby="change-password-tab" tabIndex="0">
                <div className='d-flex justify-content-center py-5'>
                  <div  style={{ width: '23rem' }}>
                    <form id='resetPasswordForm' onSubmit={ handleResetPwdSubmit }>

                        { resetPasswordError && (<div className="alert alert-danger py-2 mb-3 text-center fs-14" role="alert">{ resetPasswordMessage }</div>) }

                        { resetPasswordSuccess && (<div className="alert alert-success py-2 mb-3 text-center fs-14" role="alert">{ resetPassword.message }</div>) }

                        <div className='mb-3'>
                            <label htmlFor='newpassword' className='form-label'>New Password</label>
                            <input type='password' className='form-control form-control-sm rounded-1' aria-describedby='NewPassword' id='newPassword' name='newPassword' value={newPassword} onChange={(e) => setNewPassword(e.target.value)} autoComplete="current-password" required/>
                        </div>
                        <div className='mb-3'>
                            <label htmlFor='confirmPassword' className='form-label'>Confirm Password</label>
                            <input type='password' className='form-control form-control-sm rounded-1' aria-describedby='ConfrimPassword' id='confirmPassword' name='confirmPassword' value={confirmPassword} onChange={(e) => setConfirmPassword(e.target.value)} required/>
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

                          <div className="text-center mt-4">
                              <Link type='submit' className="icon-link icon-link-hover" > Update Password <i className="bi bi-arrow-right"></i></Link> 
                          </div>

                        )}
                    </form>             
                </div>
                </div>
              </div>
              {/* Change Password Form ends */}

            </div>
          </div>
          
        </div>
      </div>
        
    </>
  );
}


export default ContentsMgrAccount