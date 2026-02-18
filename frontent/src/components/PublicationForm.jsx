
import { Link } from 'react-router-dom';
import { useDropzone } from 'react-dropzone';
import React, { useState, useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";


import { postPublication, updatePublication, postReset, updateReset } from '../features/publicationSlice';


const PublicationForm = ({editingPublication}) => {

    const dispatch = useDispatch();
    const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

    const { postLoading, postSuccess, postError, message } = useSelector((state) => state.publications);

    const [step, setStep] = useState(1);
    const [category, setCategory] = useState('');
    const [title, setTitle] = useState('');
    const [files, setFiles] = useState([]);
    const [existingFileURL, setExistingFileURL] = useState(null);

    const [errors, setErrors] = useState('');
    const [ isSubmitting, setIsSubmitting ] = useState(false);

    // handle file drop
    const onDrop = (acceptedFiles) => {
        if (acceptedFiles.length > 0) {
            setFiles([acceptedFiles[0]]); // Only one file allowed
            setErrors('');
        }
    };

    const { getRootProps, getInputProps, isDragActive } = useDropzone({ onDrop, multiple: false, accept: { 'application/pdf': ['.pdf'] }, maxFiles: 1, });

    // handle return back button
    const handleBack = () => {
        setStep(1);
    };


    // reset publication form
    const resetPublicationForm = () => {   

        setStep(1);
        setTitle("");
        setCategory("");
        setFiles([]);
        setExistingFileURL(null);

        dispatch(postReset());
        dispatch(updateReset());
    };

    
    // Populate publication data when editing
    useEffect(() => {
        if (editingPublication) {
            setTitle(editingPublication.title || "");
            setCategory(editingPublication.category || "");
            setExistingFileURL(`${webMediaURL}/${editingPublication.contentPath}` || null);
        }
    }, [editingPublication]);
    

    // handle submit when user clicks finish button this function is envoked
    const handleSubmit = (e) => {

        e.preventDefault();

        if (files.length < 1) {
            setErrors('At least one file is required.');
            return;
        }

        setStep(3);
        setIsSubmitting(true);

        const publicationDetails = new FormData();
        publicationDetails.append('title', title);
        publicationDetails.append('category', category);

        if (files.length > 0) {
            publicationDetails.append("publicContentAttachment", files[0]);
        }
    
        if (editingPublication) {
            publicationDetails.append("publicationID", editingPublication.publicationID);
            dispatch(updatePublication(publicationDetails));
    
        } else {

            dispatch(postPublication(publicationDetails));
        }
       
    };


    // when file is uploaded go to doc preview
    useEffect(() => {
        if (files.length > 0) {
            setStep(2);
        }
    }, [files.length]);


    // publication Form UI
    return (

        <>
        <div className="modal-dialog modal-lg col-7">
            <div className="modal-content p-2 pb-3">
            <div className="modal-header border-0">
                <h4 className="modal-title" id="staticBackdropLabel1">{ editingPublication ? "Edit Publication" : "Post Publication" }</h4>
                <button type="button" className="btn-close" data-bs-dismiss="modal" aria-label="Close" onClick={resetPublicationForm}></button>
            </div>
            <div className="modal-body">
            <div className="card border-0">

                {step === 1 && (
                <>
                    <div className="form-floating mb-3">
                    <select className="form-select rounded-1 fs-14" aria-label="Content Type" id="category" name="category" value={category} onChange={(e) => setCategory(e.target.value)} required>
                        <option defaultValue ></option>
                        <option value="Form">Form</option>
                        <option value="Report">Report</option>
                        <option value="Guidelines">Guidelines</option>
                        <option value="Laws & Regulations">Laws & Regulations</option>
                        <option value="Journal & Articles">Journal & Articles</option>
                    </select>
                    <label htmlFor="floatingSelect">Content Type</label>
                    </div>

                    <div className="mb-3">
                        <div className="form-floating mb-1">
                            <input type="text" className="form-control rounded-1" placeholder='Content Title' id='title' value={title} onChange={(e) => setTitle(e.target.value)} required />
                            <label htmlFor="title">Content Title</label>
                        </div>
                    </div>
             
                    <div {...getRootProps({ className: 'dropzone border p-5 text-center rounded' })}>
                        <input {...getInputProps()} />
                        {isDragActive ? (

                            <p>Drop public content here...</p>

                        ) : (

                            <div>
                                <h2 className='text-secondary'><i className="bi bi-collection"></i> </h2>
                                <p className='fs-16'> Drop publication attachment here (PDF), or click to browse </p>
                                <small className="text-muted">(Only one PDF file allowed)</small>
                            </div>

                        )}
                    </div>

                    <div className="progress rounded-0 mt-3 mb-4" style={{ height: '7px'}}>
                        <div className="progress-bar progress-bar-striped progress-bar-animated bg-danger" role="progressbar" style={{ width: `${step === 1 ? '50%' : '100%'}` }}> </div>
                    </div>

                    { category && title && (files.length > 0 || editingPublication) && (

                          <div className="d-flex justify-content-end">
                              <Link onClick={() => setStep(2)} > <span> Preview <i className="bi bi-chevron-double-right"></i></span></Link>
                          </div>

                        )
                    }
                    
                </>
                )}

                {step === 2 && (

                    <>
                        { files.length > 0 ? (

                            <object data={URL.createObjectURL(files[0])} type="application/pdf" width="100%" height="350px">
                                <p className="text-heading-secondary">Preview not available.</p>
                            </object>

                        ) : existingFileURL ? (

                            <object data={existingFileURL} type="application/pdf" width="100%" height="350px">
                                <p className="text-heading-secondary">Preview not available.</p>
                            </object>

                        ) : (
                            <p className="text-muted">No preview available</p>
                        )}

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
                                  <p className="text-heading-secondary"> Posting publication is in-progress </p>
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
                            <p className="text-heading-secondary">Publication posted successfully.</p>
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


            </div>

            </div>
            </div>
        </div>
        </>
    );
}



export default PublicationForm