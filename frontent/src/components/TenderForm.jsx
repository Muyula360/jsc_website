
import { Link } from 'react-router-dom';
import { useDropzone } from 'react-dropzone';
import React, { useState, useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";


import { postTender, updateTender, postReset, updateReset } from '../features/tenderSlice';


const TenderForm = ({editingTender}) => {

    const dispatch = useDispatch();

    const { postLoading, updateLoading, postSuccess, updateSuccess, postError, updateError, message } = useSelector((state) => state.tenders);

    const [ step, setStep] = useState(1);
    
    const [ tenderDetails, setTenderDetails ] = useState({ tenderNum: '', tenderTitle: '', tenderer: '', tenderOpenDate: '', tenderCloseDate: '', tenderLink:'' });

    const totalFields = Object.keys(tenderDetails).length;
    const filledFields = Object.values(tenderDetails).filter((val) => val !== '').length;
    const progress = Math.floor((filledFields / totalFields) * 100);


    const handleChange = (e) => {
      setTenderDetails(prev => ({ ...prev, [e.target.name]: e.target.value }));
    };

    const [ errors, setErrors ] = useState('');
    const [ isSubmitting, setIsSubmitting ] = useState(false);

    // handle return back button
    const handleBack = () => {
      setStep(1);
    };


    // reset tender Form
    const resetTenderForm = () => {   
      setStep(1);
      setTenderDetails({ tenderNum: '', tenderTitle: '', tenderer: '', tenderOpenDate: '', tenderCloseDate: '', tenderLink:'' });
      dispatch(postReset());
      dispatch(updateReset());   
    }

    // Populate Tender data when editing
    useEffect(() => {

      if (editingTender) {
        setTenderDetails({
            tenderNum: editingTender.tenderNum || "",
            tenderTitle: editingTender.tenderTitle || "",
            tenderer: editingTender.tenderer || "",
            tenderOpenDate: editingTender.openDate ? editingTender.openDate.split('T')[0] : "",
            tenderCloseDate: editingTender.closeDate ? editingTender.closeDate.split('T')[0] : "",
            tenderLink: editingTender.link || ""
        });
      }

    }, [editingTender]);


    // handle submit when user clicks post tender or update tender
    const handleSubmit = (e) => {
        
      e.preventDefault();

      setStep(2);
      setIsSubmitting(true);

      if (editingTender) {
        dispatch(updateTender({ ...tenderDetails, tenderID: editingTender.tenderID }));
      } else {
        dispatch(postTender(tenderDetails));
      }

    };


    // Tender Form UI
    return (

        <>
        <div className="modal-dialog modal-lg">
            <div className="modal-content p-3">
            <div className="modal-header border-0">
                <h4 className="modal-title" id="staticBackdropLabel1">{ editingTender ? "Edit Tender" : "Post Tender" }</h4>
                <button type="button" className="btn-close" data-bs-dismiss="modal" aria-label="Close" onClick={ resetTenderForm }></button>
            </div>
            <div className="modal-body">
            <div className="card border-0">
              <form action="">

                {step === 1 && (
                <>
                    <div className=''>
                      <div className='row g-3 mb-3'>
                        <div className="col-md-6">
                          <label htmlFor="tenderOpenDate" className="form-label">Tender Open Date</label>
                          <input type="date" className="form-control rounded-1 fs-14" id="tenderOpenDate" name="tenderOpenDate" value={tenderDetails.tenderOpenDate} onChange={handleChange} required/>
                        </div>
                        <div className="col-md-6">
                          <label htmlFor="tenderCloseDate" className="form-label">Tender Close Date</label>
                          <input type="date" className="form-control rounded-1 fs-14" id="tenderCloseDate" name="tenderCloseDate" value={tenderDetails.tenderCloseDate} onChange={handleChange} required/>
                        </div>
                      </div>
                      <div className="mb-3">
                          <div className="form-floating mb-1">
                              <input type="text" minLength={10} className="form-control rounded-1 fs-14" placeholder='Tender No' id='tenderNum' name='tenderNum' value={tenderDetails.tenderNum} onChange={handleChange} required />
                              <label htmlFor="tenderNum">Tender Number</label>
                          </div>
                      </div>
                      <div className="mb-3">
                          <div className="form-floating mb-1">
                              <input type="text" minLength={10} className="form-control rounded-1 fs-14" placeholder='Tender Title' id='tenderTitle' name='tenderTitle' value={tenderDetails.tenderTitle} onChange={handleChange} required />
                              <label htmlFor="tenderTitle">Tender Title</label>
                          </div>
                      </div>
                      <div className="mb-4">
                          <div className="form-floating mb-1">
                              <input type="text" minLength={10} className="form-control rounded-1 fs-14" placeholder='Tenderer' id='tenderer' name='tenderer' value={tenderDetails.tenderer} onChange={handleChange} required />
                              <label htmlFor="tenderer">Tenderer/Procurement Entity</label>
                          </div>
                      </div>
                      <div className="mb-4">
                        <label htmlFor="URLlinktoNeST" className="fs-13"><i className="bi bi-link-45deg"></i> URL link to NeST </label>
                        <input type="text" className="form-control rounded-1 fs-13" id="URLlinktoNeST" name='tenderLink' value={tenderDetails.tenderLink} onChange={handleChange} required />
                      </div>
                    </div>


                    <div className="progress rounded-0 mb-5" style={{ height: '8px'}}>
                        <div className="progress-bar progress-bar-striped progress-bar-animated bg-danger" role="progressbar" style={{ width: `${progress}%` }} aria-valuenow={progress} aria-valuemin="0" aria-valuemax="100"> </div>
                    </div>

                    { progress === 100 && (

                        <div className="d-flex justify-content-end">
                            <Link onClick={handleSubmit} > <span> Post Tender <i className="bi bi-chevron-double-right"></i></span></Link>
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
                                  <p className="text-heading-secondary"> Posting tender is in-progress </p>
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
                            <p className="text-heading-secondary">Tender posted successfully.</p>
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

export default TenderForm