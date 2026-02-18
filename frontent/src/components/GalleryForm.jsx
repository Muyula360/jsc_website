
import { Link } from 'react-router-dom';
import ReactQuill from 'react-quill';
import { useDropzone } from 'react-dropzone';
import React, { useState, useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";


import { postAlbum } from '../features/gallerySlice';


const GalleryForm = () => {

    const dispatch = useDispatch();

    const { postLoading, postSuccess, postError, message } = useSelector((state) => state.newsUpdates);

    const [step, setStep] = useState(1);
    const [title, setTitle] = useState('');
    const [images, setImages] = useState([]);

    const [errors, setErrors] = useState('');
    const [ isSubmitting, setIsSubmitting ] = useState(false);


    const onDrop = (acceptedFiles) => {
        const newFiles = [...images, ...acceptedFiles].slice(0, 5); // Max 5
        setImages(newFiles);
    };


    const { getRootProps, getInputProps, isDragActive } = useDropzone({
        onDrop,
        multiple: true,
        accept: { 'image/jpeg': ['.jpeg', '.jpg'], 'image/png': ['.png'] },
        maxFiles: 5,
    });


    const resetGalleryForm = () => {       
      setStep(1);
      setTitle('');
      setImages([]);
    }


    const handleSubmit = (e) => {

        e.preventDefault();
      
        setStep(2);

        setIsSubmitting(true);

        if (images.length < 1) {
          setErrors('At least one image is required.');
          return;
        }

        const albumDetails = new FormData();

        albumDetails.append('albumTitle', title);
        images.forEach((img, index) => { albumDetails.append(`albumPhotos`, img); });

        dispatch( postAlbum(albumDetails) );

    };



    return (

        <>
        <div className="modal-dialog modal-lg col-8">
            <div className="modal-content p-2 pb-3">
            <div className="modal-header border-0">
                <h4 className="modal-title" id="staticBackdropLabel1">Create Album</h4>
                <button type="button" className="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div className="modal-body">
            <div className="card border-0">

                {step === 1 && (
                <>
                    <div className="mb-3">
                        <div className="form-floating mb-1">
                            <input type="text" minLength={10} className="form-control" placeholder='News Title' id='title' value={title} onChange={(e) => setTitle(e.target.value)} required />
                            <label htmlFor="title">Album Title</label>
                        </div>
                    </div>

                    <div {...getRootProps({ className: 'dropzone border p-5 text-center rounded' })}>
                        <input {...getInputProps()} />
                        {isDragActive ? (

                            <p>Drop the images here...</p>

                        ) : (

                            <div>
                                <h2 className='text-secondary'><i className="bi bi-collection"></i> </h2>
                                <p className='fs-16'> Drag photos up to 5 images here, or click to browse </p>
                            </div>

                        )}
                        <small className="text-muted">(At least 1, max 5 images)</small>
                    </div>

                    <div>
                        {images.length > 0 && (
                            <div className="d-flex flex-wrap gap-3 mt-3">
                            {images.map((file, i) => (
                                <div key={i} className="border p-2 rounded">
                                <img src={URL.createObjectURL(file)} alt="preview" width="182" height="100" style={{ objectFit: 'cover' }} />
                                </div>
                            ))}
                            </div>
                        )}
                    </div>

                    
                    <div className="progress rounded-0 mt-3 mb-5" style={{ height: '7px'}}>
                        <div className="progress-bar progress-bar-striped progress-bar-animated bg-danger" role="progressbar" style={{ width: `${step === 1 ? '50%' : '100%'}` }}> </div>
                    </div>
                    {

                      title && images.length > 0 && (

                          <div className="d-flex justify-content-center">
                              <Link onClick={handleSubmit}> <span> Publish Album <i className="bi bi-chevron-double-right"></i></span></Link>
                          </div>

                      )

                    }

                    
                </>
                )}

                {step === 2 && (

                    <div className="card border-0 bg-light py-5">
                        {postLoading&& (
                          <div className="d-flex flex-column justify-content-center align-items-center py-3">
                              <span className='spinner-border spinner-border-sm' style={{ width: '2rem', height: '2rem' }}></span>
                              <div className="text-center my-4">
                                  <h4 className="text-heading">Loading ...</h4>
                                  <p className="text-heading-secondary"> Publishing album is in-progress </p>
                              </div>
                          </div>
                        )}
                        <div className="success-animation">
                            <svg className="checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
                            <circle className="checkmark__circle" cx="26" cy="26" r="25" fill="none"/>
                            <path className="checkmark__check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"/>
                            </svg>
                        </div>
                        <div className="text-center my-4">
                            <h4 className="text-heading">Success!</h4>
                            <p className="text-heading-secondary">Album published successfully.</p>
                        </div>
                        <div className="d-flex justify-content-center">
                            <button className="btn btn-outline-secondary rounded-5 w-25" onClick={resetGalleryForm} > Create another album </button>
                        </div>
                        
                    </div>

                )}


            </div>

            </div>
            </div>
        </div>
        </>
    );
}


export default GalleryForm