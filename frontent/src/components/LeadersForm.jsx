import { Link } from 'react-router-dom';
import ReactQuill from 'react-quill';
import { useDropzone } from 'react-dropzone';
import React, { useState, useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";


import { postLeader } from "../features/leaderSlice";


const LeadersForm = ({ leaderDetails }) => {
  
  const dispatch = useDispatch();

  const { postLoading, postSuccess, postError, message } = useSelector((state) => state.leaders);


  // destructuring leaderDetails (leaderDetails is a prop from ContentsMgrLeader page)
  const { leadersTitleID, title, fname, mname, sname, profession, experienceYear, bio } = leaderDetails;


  const [step, setStep] = useState(1);

  const [firstName, setFirstname] = useState(``);
  const [middleName, setMiddlename] = useState(``);
  const [surname, setSurname] = useState(``);
  const [professions, setProfession] = useState(``);
  const [experienceYears, setExperienceYears] = useState(``);
  const [profilePicture, setProfilePicture] = useState(null);
  const [biography, setBiography] = useState(``);

  const [errors, setErrors] = useState('');
  const [ isSubmitting, setIsSubmitting ] = useState(false);


  const handleBack = () => setStep(1);


  const onDrop = (acceptedFiles) => {

    const newImage = Object.assign(acceptedFiles[0], {  preview: URL.createObjectURL(acceptedFiles[0]), });

    if (profilePicture) {
      URL.revokeObjectURL(profilePicture.preview);
    }

    setProfilePicture(newImage);
  };


  // reset leaders form
  const resetAnnouncementForm = () => {
    setStep(1);
    setFirstname("");
    setMiddlename("");
    setSurname("");
    setProfession("");
    setExperienceYears("");
    setBiography("");
    //dispatch(postReset());
  };


  // Display Picture Preview
  useEffect(() => {

    return () => {
      if (profilePicture) {
        URL.revokeObjectURL(profilePicture.preview);
      }
    };

  }, [profilePicture]);


  const { getRootProps, getInputProps } = useDropzone({ accept: { 'image/jpeg': ['.jpeg', '.jpg'], 'image/png': ['.png'] }, onDrop, multiple: false, });


  // Populate leaders data when updating profile
  useEffect(() => {
    if (leaderDetails) {
      setFirstname(leaderDetails.fname || "");
      setMiddlename(leaderDetails.midName || "");
      setSurname(leaderDetails.surname || "");
      setProfession(leaderDetails.profession || "");
      setExperienceYears(leaderDetails.experienceYears || "");
      setBiography(leaderDetails.bio || "");
    }
  }, [leaderDetails]);
  

  // handle submit when user clicks update leader profile
  const handleSubmit = (e) => {

    e.preventDefault();
  
    setStep(3);

    setIsSubmitting(true);

    if (!profilePicture) {
      alert("Please upload a profile picture.");
      return;
    }

    const leaderProfile = new FormData();

    leaderProfile.append('leaderTitleID', leadersTitleID);
    leaderProfile.append('fname', firstName);
    leaderProfile.append('midname', middleName);
    leaderProfile.append('surname', surname);
    leaderProfile.append('profession', professions);
    leaderProfile.append('experienceYears', experienceYears);
    leaderProfile.append('bio', biography);
    leaderProfile.append(`profilePic`, profilePicture);

    dispatch( postLeader(leaderProfile) );

  };


  // Leaders Form UI
  return (
    <>
      <div className="modal-dialog modal-lg">
        <div className="modal-content px-3 py-2">
          <div className="modal-header border-0">
            <h5 className="modal-title fw-semibold" id="staticBackdropLabel1">{ title }</h5>
            <button type="button" className="btn-close" onClick={handleBack} data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div className="modal-body">
            <div className="card border-0 custom-card">
              <form >
                {step === 1 && (
                  <>
                  <div className="d-flex align-items-start gap-4">
                    <div {...getRootProps()} className="dropzone border-1 rounded-1 text-center position-relative cover-photo bg-light" style={{ width: "175px", height: "205px", flexShrink: 0, display: "flex", alignItems: "center", justifyContent: "center", overflow: "hidden", border: "10px solid #ddd", }} >
                      <input className="rounded-0" {...getInputProps()} style={{ position: "absolute", opacity: 0, width: "100%", height: "100%", cursor: "pointer" }}  />

                      {!profilePicture ? (

                        <p className="text-muted text-center fs-14">Display Picture</p>

                      ) : (

                        <img src={profilePicture.preview} alt="Display Picture" style={{ width: "175px", height: "205px", objectFit: "cover", borderRadius: "5px" }} />

                      )}
                    </div>

                    <div className="flex-grow-2">
                      <div className="row justify-content-center">
                        <div className="col-md-6 mb-2">
                          <div className="form-floating">
                              <input type="text" className="form-control form-control-sm" id="firstName" name="firstName" value={firstName} placeholder="First Name" onChange={(e) => setFirstname(e.target.value)} required />
                              <label htmlFor="firstName" className="">First Name</label>
                          </div>
                        </div>
                        <div className="col-md-6 mb-3">
                          <div className="form-floating">
                            <input type="text" className="form-control form-control-sm mt-0" id="middleName"  name="middleName" value={middleName} placeholder="Middle Name" onChange={(e) => setMiddlename(e.target.value)} required />
                            <label htmlFor="middleName" className="">Middle Name</label>
                          </div>
                        </div>
                        <div className="col-md-12 mb-3">
                          <div className="form-floating">
                            <input type="text" className="form-control form-control-sm " id="surname" name="surname"  value={surname} placeholder="Surname" onChange={(e) => setSurname(e.target.value)} required />
                            <label htmlFor="surname" className="">Surname</label>
                          </div>
                        </div>
                        <div className="col-md-6 mb-3">
                          <div className="form-floating">
                            <input type="text" className="form-control form-control-sm" id="professions" name="professions" value={professions} placeholder="Profession" onChange={(e) => setProfession(e.target.value)} required />
                            <label htmlFor="profession" className="mb-1">Profession</label>
                          </div>     
                        </div>
                        <div className="col-md-6 mb-3">
                          <div className="form-floating">
                            <input type="number" className="form-control form-control-sm mt-0" id="experienceYears" name="experienceYears" value={experienceYears} placeholder="Experience (Years)" onChange={(e) => setExperienceYears(e.target.value)} required  />
                            <label htmlFor="years" className="mb-1">Experience (Years)</label>
                          </div>  
                        </div>
                      </div>
                    </div>
                  </div>

                  <div className="progress rounded-0 mt-3" style={{ height: '7px'}}>
                      <div className="progress-bar progress-bar-striped progress-bar-animated bg-danger" role="progressbar" style={{ width: `${step === 1 ? '50%' : '100%'}` }}> </div>
                  </div>

                  <div className="d-flex justify-content-end my-4">
                      <Link onClick={() => setStep(2)} ><span> Next <i className="bi bi-chevron-double-right"></i></span></Link>
                  </div>
                  </>
                )}

                {step === 2 && (
                  <>
                    <div className="col-md-12 p-0">
                      <div className="custom-quill">
                          <ReactQuill 
                              theme="snow" 
                              id="biography"
                              name="biography"
                              value={biography} 
                              onChange={setBiography} 
                              placeholder="Write leader biography here ..."
                              modules={{
                              toolbar: [
                                  [{ header: [1, 2, 3, false] }],
                                  ['bold', 'italic', 'underline', 'strike'],
                                  [{ list: 'ordered' }, { list: 'bullet' }],
                                  ['blockquote', 'code-block'],
                                  ['link', 'image'],
                                  ['clean'],
                              ],
                              }}
                          />
                      </div>                     
                    </div>

                    <div className="progress rounded-0 my-4" style={{ height: '7px'}}>
                        <div className="progress-bar progress-bar-striped progress-bar-animated bg-danger" role="progressbar" style={{ width: `${step === 1 ? '50%' : '100%'}` }}> </div>
                    </div>

                    <div className="d-flex justify-content-between mb-3">
                        <Link onClick={handleBack} ><span><i className="bi bi-chevron-double-left"></i> Return Back </span></Link>
                        <Link onClick={handleSubmit} > <span> Finish <i className="bi bi-chevron-double-right"></i></span></Link>
                    </div>
                  </>
                )}

                {step === 3 && (

                  <div className="card border-0 bg-light py-5">
                      { postLoading && (
                          <div className="d-flex flex-column justify-content-center align-items-center py-3">
                              <span className='spinner-border spinner-border-sm' style={{ width: '2rem', height: '2rem' }}></span>
                              <div className="text-center my-4">
                                  <h4 className="text-heading">Loading ...</h4>
                                  <p className="text-heading-secondary"> Updating leader profile is in-progress </p>
                              </div>
                          </div>
                      )}

                      { postSuccess && (
                        <>
                        <div className="success-animation">
                            <svg className="checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
                            <circle className="checkmark__circle" cx="26" cy="26" r="25" fill="none"/>
                            <path className="checkmark__check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"/>
                            </svg>
                        </div>
                        <div className="text-center my-4">
                            <h4 className="text-heading">Success!</h4>
                            <p className="text-heading-secondary">Leader profile updated successfully.</p>
                        </div>
                        </>
                      )}

                      { postError && (
                          <div className="d-flex flex-column justify-content-center align-items-center py-3">
                              <i className="bi bi-exclamation-circle fs-28"></i>
                              <div className="text-center my-4">
                                  <h4 className="text-heading">Failed!</h4>
                                  <p className="text-heading-secondary"> {message} </p>
                              </div>
                              <div className="d-flex justify-content-center w-100">
                                  <button className="btn btn-outline-secondary rounded-5 w-25" onClick={handleBack} > Return Back </button>
                              </div>
                          </div>
                      )}
                      
                  </div>

                )}

              </form>
            </div>
          </div>
        </div>
      </div>
    </>
  );
}


export default LeadersForm