import { Link } from 'react-router-dom';
import ReactQuill from 'react-quill';
import { useDropzone } from 'react-dropzone';
import React, { useState, useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";


import { postNewsletter } from "../features/newsLetterSlice";


const NewsletterForm = ({editingNewsletter}) => {
  
  const dispatch = useDispatch();
  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

  const { postLoading, postSuccess, postError, message } = useSelector((state) => state.newsletters);

  const [step, setStep] = useState(1);
  const [newsletterNo, setNewsletterNo] = useState(``);
  const [newsletterYear, setNewsletterYear] = useState(``);
  const [newsletterMonth, setNewsletterMonth] = useState(``);
  const [newsletterCoverPic, setNewsletterCoverPic] = useState(null);
  const [newsletterDocument, setNewsletterDocument] = useState([]);
  const [existingFileURL, setExistingFileURL] = useState(null);

  const [errors, setErrors] = useState('');
  const [ isSubmitting, setIsSubmitting ] = useState(false);


  // when user clicks 'return back' button this function is invoked
  const handleBack = () => setStep(1);


  // when user drop newsletter cover picture
  const onDropNewsletterCoverPic = (acceptedFiles) => {

    const newCoverPic = Object.assign(acceptedFiles[0], {  preview: URL.createObjectURL(acceptedFiles[0]), });

    if (newsletterCoverPic) {
      URL.revokeObjectURL(newsletterCoverPic.preview);
    }

    setNewsletterCoverPic(newCoverPic);
  };


  // when user drop newsletter PDF document
  const onDropNewsletterDocument = (acceptedFiles) => {
    if (acceptedFiles.length > 0) {
      setNewsletterDocument([acceptedFiles[0]]);
      setErrors('');
    }
  };


  // when user uploads/attach newsletter pdf document redirect to newsletter preview
  useEffect(() => {

    if(newsletterDocument.length > 0){
      setStep(2);
    }

  },[ newsletterDocument.length ]);


  // newsletter display when user upload coverPicture
  useEffect(() => {

    return () => {
      if (newsletterCoverPic) {
        URL.revokeObjectURL(newsletterCoverPic.preview);
      }
    };

  }, [newsletterCoverPic]);


  // drop zone for newsletter cover picture
  const { getRootProps: getCoverRootProps,  getInputProps: getCoverInputProps,  isDragActive: isCoverDragActive,} = useDropzone({ accept: { 'image/jpeg': ['.jpeg', '.jpg'], 'image/png': ['.png'] }, onDrop: onDropNewsletterCoverPic, multiple: false, });

  // drop zone for newsletter PDF document
  const { getRootProps: getPdfRootProps, getInputProps: getPdfInputProps, isDragActive: isPdfDragActive, } = useDropzone({ accept: { 'application/pdf': ['.pdf'] }, onDrop: onDropNewsletterDocument, multiple: false, });


  // Populate newsletter data when editing
  useEffect(() => {
      if (editingNewsletter) {
          setNewsletterNo(editingNewsletter.newsletterNo || "");
          setNewsletterMonth(editingNewsletter.newsletterMonth || "");
          setNewsletterYear(editingNewsletter.newsletterYear || "");;
          setExistingFileURL(`${webMediaURL}/${editingNewsletter.newsletterPath}` || null);
      }
  }, [editingNewsletter]);


  // when user clicks 'Finish' button this function is invokeds
  const handleSubmit = (e) => {

    e.preventDefault();

    if (!newsletterCoverPic || newsletterDocument.length === 0 || !newsletterNo || !newsletterYear || !newsletterMonth) {
      setErrors("All fields are required.");
      return;
    }
  
    setStep(3);

    setIsSubmitting(true);

    const newsletterDetails = new FormData();

    newsletterDetails.append('newsletterNo', newsletterNo);
    newsletterDetails.append('newsletterYear', newsletterYear);
    newsletterDetails.append('newsletterMonth', newsletterMonth);
    newsletterDetails.append(`newsletterCover`, newsletterCoverPic);
    newsletterDocument.forEach((file) => newsletterDetails.append('newsletterAttachment', file));

    dispatch(postNewsletter(newsletterDetails));

  };


  // Newsletter Form UI
  return (
    <>
      <div className="modal-dialog modal-lg col-7">
        <div className="modal-content px-3 py-2">
          <div className="modal-header border-0">
            <h4 className="modal-title" id="staticBackdropLabel1"> { editingNewsletter ? "Newsletter" : "Post Newsletter" } </h4>
            <button type="button" className="btn-close" onClick={handleBack} data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div className="modal-body">
            <div className="card border-0 custom-card">
              <form >
                {step === 1 && (
                  <>
                  <div className="d-flex align-items-start gap-4">
                    <div 
                      {...getCoverRootProps()} 
                      className="dropzone border-1 rounded-1 text-center position-relative cover-photo bg-light"
                      style={{ width: "210px", height: "275px", flexShrink: 0, display: "flex", alignItems: "center", justifyContent: "center", overflow: "hidden", border: "10px solid #ddd", }} >
                      <input className="rounded-1" {...getCoverInputProps()} style={{ position: "absolute", opacity: 0, width: "100%", height: "100%", cursor: "pointer" }}  />

                      {!newsletterCoverPic ? (

                        <p className="text-muted text-center fs-14">Newsletter Cover</p>

                      ) : (

                        <img src={newsletterCoverPic.preview} alt="Uploaded Preview" style={{ width: "100%", height: "100%", objectFit: "cover" }} />

                      )}
                    </div>

                    <div className="flex-grow-2">

                      



                      <div className="row justify-content-center">

                        <div className="mb-3">
                          <div className="form-floating">
                            <input type="number" className="form-control rounded-1 fs-14" placeholder='Newsletter No.' id="newsletterNo" name="newsletterNo" value={newsletterNo} onChange={(e) => setNewsletterNo(e.target.value)} required />
                            <label htmlFor="newsletterNo" className="form-label fs-15">Newsletter No.</label>
                          </div>
                        </div>

                        <div className="col-md-6 mb-2">
                          <div className="form-floating">
                            <input type="number" className="form-control rounded-1 fs-14" placeholder='Issued Year' id="newsletterYear" name="newsletterYear" value={newsletterYear} onChange={(e) => setNewsletterYear(e.target.value)} required />
                            <label htmlFor="newsletterYear" className="form-label fs-15">Issued Year</label>
                          </div>
                        </div>

                        <div className="col-md-6 mb-3">
                          <div className="form-floating">                        
                            <select className="form-select rounded-1 fs-14" aria-label="Period (Months)" id="newsletterMonth" name="newsletterMonth" value={newsletterMonth} onChange={(e) => setNewsletterMonth(e.target.value)} required>
                                <option></option>
                                <option value="January - March">January - March</option>
                                <option value="April - June">April - June</option>
                                <option value="July - September">July - September</option>
                                <option value="October - December">October - December</option>
                            </select>
                            <label htmlFor="newsletterMonth" className="form-label">Period (Months)</label>
                          </div>
                        </div>



                        <div className="col-md-12">
                          <div {...getPdfRootProps({ className: 'border py-4 px-3 text-center rounded' })}>
                          <input {...getPdfInputProps()} />
                          {isPdfDragActive ? (

                              <p>Drop newsletter document here ...</p>
                              
                          ) : (
                              <div>
                                  <h4 className='text-secondary'><i className="bi bi-collection"></i> </h4>
                                  <p className='fs-14'> Drop newsletter document here (PDF), or click to browse </p>
                              </div>
                          )}
                          </div>
                        </div>

                      </div>

                    </div>
                  </div>

                  <div className="progress rounded-0 mt-4" style={{ height: '7px'}}>
                      <div className="progress-bar progress-bar-striped progress-bar-animated bg-danger" role="progressbar" style={{ width: `${step === 1 ? '50%' : '100%'}` }}> </div>
                  </div>

                  <div className="d-flex justify-content-end my-4">
                      <Link onClick={() => setStep(2)} ><span> Next <i className="bi bi-chevron-double-right"></i></span></Link>
                  </div>

                  
                  </>
                )}

                {step === 2 && (
                    <>
                    <div>
                    {newsletterDocument.length > 0 && (
                        <div className="">
                            <h6 className="text-heading-secondary mb-3">Newsletter Preview:</h6>
                            <object
                                data={URL.createObjectURL(newsletterDocument[0])}
                                type="application/pdf"
                                width="100%"
                                height="350px"
                            >
                            <p className="text-heading-secondary">Newsletter Preview is not available.</p>
                            </object>
                        </div>
                    )}
                    </div>

                    <div className="progress rounded-0 mt-3 mb-4" style={{ height: '7px'}}>
                        <div className="progress-bar progress-bar-striped progress-bar-animated bg-danger" role="progressbar" style={{ width: `${step === 1 ? '50%' : '100%'}` }}> </div>
                    </div>
                    <div className="d-flex justify-content-between mb-3">
                        <Link onClick={ handleBack } ><span><i className="bi bi-chevron-double-left"></i> Return Back </span></Link>
                        <Link onClick={ handleSubmit } > <span> Finish <i className="bi bi-chevron-double-right"></i></span></Link>
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
                                  <p className="text-heading-secondary"> Posting newsletter is in-progress </p>
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
                            <p className="text-heading-secondary"> Newsletter posted successfully.</p>
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

export default NewsletterForm