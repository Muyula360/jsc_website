
import { Link } from 'react-router-dom';
import ReactQuill from 'react-quill';
import { useDropzone } from 'react-dropzone';
import React, { useState, useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";

import 'react-quill/dist/quill.snow.css';
import { postVacancy, updateVacancy, postReset } from '../features/vacanciesSlice';
import { updateReset } from '../features/newsUpdateSlice';


const VacancyForm = ({editingVacancy}) => {

    const dispatch = useDispatch();

    const { postLoading, updateLoading, postSuccess, updateSuccess, postError, updateError, message } = useSelector((state) => state.vacancies);

    const [ step, setStep] = useState(1);

    const [ errors, setErrors ] = useState('');
    const [ isSubmitting, setIsSubmitting ] = useState(false);  
    const [ vacancyDetails, setVacancyDetails ] = useState({ vacancyTitle: '', vacantPositions: '', vacancyDesc: '', openDate: '', closeDate: '', link:'' });

    const totalFields = Object.keys(vacancyDetails).length;
    const filledFields = Object.values(vacancyDetails).filter((val) => val !== '').length;
    const progress = Math.floor((filledFields / totalFields) * 100);


    // handle form inputs changes
    const handleChange = (e) => {
      setVacancyDetails(prev => ({ ...prev, [e.target.name]: e.target.value }));
    };

    // handle text editor changes
    const handleTextEditorChange = (value) => {
        setVacancyDetails(prev => ({ ...prev, vacancyDesc: value }));
    };

    // handle return back button
    const handleBack = () => {
      setStep(1);
      dispatch(postReset());
      dispatch(updateReset());
    };

    // handle reset vacancy form
    const resetVacancyForm = () => {   
      setStep(1);
      setVacancyDetails({ vacancyTitle: '', vacantPositions: '', vacancyDesc: '', openDate: '', closeDate: '', link:'' });
      dispatch(postReset());
      dispatch(updateReset());   
    }


    // Populate vacancy data when editing
    useEffect(() => {

        if (editingVacancy) {
            setVacancyDetails({
                vacancyTitle: editingVacancy.vacancyTitle || "",
                vacantPositions: editingVacancy.vacantPositions || "",
                vacancyDesc: editingVacancy.vacancyDesc || "",
                openDate: editingVacancy.openDate ? editingVacancy.openDate.split('T')[0] : "",
                closeDate: editingVacancy.closeDate ? editingVacancy.closeDate.split('T')[0] : "",
                link: editingVacancy.link || ""
            });
        }

    }, [editingVacancy]);


    // handle vacancy form submission
    const handleSubmit = (e) => {
        
        e.preventDefault();

        setStep(2);
        setIsSubmitting(true);

        if (editingVacancy) {
            dispatch(updateVacancy({ ...vacancyDetails, vacancyID: editingVacancy.vacancyID }));
        } else {
            dispatch(postVacancy(vacancyDetails));
        }
    };


    // Vacancy Form UI
    return (

        <>
        <div className="modal-dialog modal-lg">
            <div className="modal-content p-3 pb-3">
            <div className="modal-header border-0">
                <h4 className="modal-title" id="staticBackdropLabel1">{ editingVacancy ? "Edit Vacancy" : "Post Vacancy" }</h4>
                <button type="button" className="btn-close" data-bs-dismiss="modal" aria-label="Close" onClick={ resetVacancyForm }></button>
            </div>
            <div className="modal-body">
            <div className="card border-0">
              <form action="">

                {step === 1 && (
                <>
                    <div className=''>
                        <div className='row g-3 mb-3'>
                            <div className="col-md-6">
                            <label htmlFor="openDate" className="form-label">Application Open Date</label>
                            <input type="date" className="form-control rounded-1 fs-14" id="openDate" name="openDate" value={vacancyDetails.openDate} onChange={handleChange} required/>
                            </div>
                            <div className="col-md-6">
                            <label htmlFor="closeDate" className="form-label">Application Close Date</label>
                            <input type="date" className="form-control rounded-1 fs-14" id="closeDate" name="closeDate" value={vacancyDetails.closeDate} onChange={handleChange} required/>
                            </div>
                        </div>
                        <div className="mb-3">
                            <div className="form-floating mb-1">
                                <input type="text" minLength={10} className="form-control rounded-1 fs-14" placeholder='Tender Title' id='vacancyTitle' name='vacancyTitle' value={vacancyDetails.vacancyTitle} onChange={handleChange} required />
                                <label htmlFor="vacancyTitle">Vancancy Title</label>
                            </div>
                        </div>
                        <div className="mb-3">
                            <div className="form-floating mb-1">
                                <input type="number" minLength={10} className="form-control rounded-1 fs-14" placeholder='vacantPositions' id='vacantPositions' name='vacantPositions' value={vacancyDetails.vacantPositions} onChange={handleChange} required />
                                <label htmlFor="vacantPositions">Vacant Positions</label>
                            </div>
                        </div>
                        <div className="custom-quill rounded-1 fs-14 mb-3">
                            <ReactQuill 
                                theme="snow" 
                                value={vacancyDetails.vacancyDesc} 
                                onChange={handleTextEditorChange}
                                placeholder="Write Job Description ..."
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
                        <div className="mb-3">
                            <label htmlFor="link" className="fs-13"><i className="bi bi-link-45deg"></i> Appication Link </label>
                            <input type="text" className="form-control rounded-1 fs-13" id="link" name='link' value={vacancyDetails.link} onChange={handleChange} required />
                        </div>
                    </div>

                    <div className="progress rounded-0 mb-4" style={{ height: '8px'}}>
                        <div className="progress-bar progress-bar-striped progress-bar-animated bg-danger" role="progressbar" style={{ width: `${progress}%` }} aria-valuenow={progress} aria-valuemin="0" aria-valuemax="100"> </div>
                    </div>

                    { progress === 100 && (

                        <div className="d-flex justify-content-end">
                            <Link onClick={handleSubmit} > <span> Post Vacancy <i className="bi bi-chevron-double-right"></i></span></Link>
                        </div>

                      )
                    }
                    
                </>
                )}

                {step === 2 && (

                    <div className="card border-0 bg-light py-5">

                      { (postLoading || updateLoading) && (
                          <div className="d-flex flex-column justify-content-center align-items-center py-3">
                              <span className='spinner-border spinner-border-sm' style={{ width: '2rem', height: '2rem' }}></span>
                              <div className="text-center my-4">
                                  <h4 className="text-heading">Loading ...</h4>
                                  <p className="text-heading-secondary"> Posting vacancy is in-progress </p>
                              </div>
                          </div>
                      )}

                      { (postSuccess || updateSuccess) && (
                        <>
                        <div className="success-animation">
                            <svg className="checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
                            <circle className="checkmark__circle" cx="26" cy="26" r="25" fill="none"/>
                            <path className="checkmark__check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"/>
                            </svg>
                        </div>
                        <div className="text-center my-4">
                            <h4 className="text-heading">Success!</h4>
                            <p className="text-heading-secondary">Vacancy posted successfully.</p>
                        </div>
                        </>
                      )}

                      { (postError || updateError) && (
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

export default VacancyForm