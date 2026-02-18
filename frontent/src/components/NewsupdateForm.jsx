
import { Link } from 'react-router-dom';
import ReactQuill from 'react-quill';
import { useDropzone } from 'react-dropzone';
import React, { useState, useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";


import 'react-quill/dist/quill.snow.css';
import { postNews, updateNews } from '../features/newsUpdateSlice';
import { postReset } from '../features/billboardSlice';


const NewsupdateForm = ({ editingNews }) => {

    const dispatch = useDispatch();
    const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

    const { postLoading, updateLoading, postSuccess, updateSuccess, postError, updateError, message } = useSelector((state) => state.newsUpdates);

    const [step, setStep] = useState(1);
    const [title, setTitle] = useState('');
    const [body, setBody] = useState('');
    const [images, setImages] = useState([]);
    const [existingImages, setExistingImages] = useState([]); //uploaded images from database

    const [errors, setErrors] = useState('');
    const [ isSubmitting, setIsSubmitting ] = useState(false);


    const handleBack = () => setStep(1);


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


    // reset news form
    const resetNewsupdateForm = () => {

        setStep(1);
        setTitle('');
        setBody('');
        setImages([]);
        setExistingImages([]);
        setErrors('');
        setIsSubmitting(false);
    };


    // when user clicks edit news
    useEffect(() => {      
        if (editingNews) {
            
            setTitle(editingNews.newsTitle || '');
            setBody(editingNews.newsDesc || '');
            setStep(1);
            
            const imageURLs = editingNews.supportingPhotosPaths?.map(photo => `${webMediaURL}/${photo}`) || [];
            setExistingImages(imageURLs);

        } else {
            resetNewsupdateForm();
        }

    }, [editingNews]);


    // when user clicks post/update news
    const handleSubmit = (e) => {

        e.preventDefault();

        setStep(3);
        setIsSubmitting(true);

        if (images.length === 0 && existingImages.length === 0) {
            setErrors('At least one image is required.');
            return;
        }

        const newsDetails = new FormData();
        newsDetails.append('newsTitle', title);
        newsDetails.append('newsBody', body);
        newsDetails.append('showOnCarouselDisplay', 0);

        // Add only newly uploaded files
        images.forEach((img) => {
            newsDetails.append('newsPhotos', img);
        });

        // Add existing image paths to a separate field
        existingImages.forEach((url) => {
            const parts = url.split('/');
            const pathIndex = parts.indexOf('website-repository');
            const relativePath = parts.slice(pathIndex).join('/'); 
            newsDetails.append('existingPhotos', relativePath);
        });

        if (editingNews) {

            newsDetails.append('newsupdatesID', editingNews.newsupdatesID);
            dispatch(updateNews(newsDetails));

        } else {

            dispatch(postNews(newsDetails));
        }
    };


    // news form UI
    return (

        <>
        <div className="modal-dialog modal-lg col-10">
            <div className="modal-content p-2 pb-3">
            <div className="modal-header border-0">
                <h4 className="modal-title" id="staticBackdropLabel1"> {editingNews ? "Edit News & Updates" : "Post News & Updates"} </h4>
                <button type="button" className="btn-close" data-bs-dismiss="modal" aria-label="Close" onClick={resetNewsupdateForm} ></button>
            </div>
            <div className="modal-body">
            <div className="card border-0">

                {step === 1 && (
                <>
                    <div className="mb-3">
                        <div className="form-floating mb-1">
                            <input type="text" minLength={10} className="form-control" placeholder='News Title' id='title' value={title} onChange={(e) => setTitle(e.target.value)} required />
                            <label htmlFor="title">News Title</label>
                        </div>
                    </div>
                    <div className="custom-quill mb-3">
                        <ReactQuill 
                            theme="snow" 
                            value={body} 
                            onChange={setBody} 
                            key={editingNews ? editingNews.newsupdatesID : 'new'}
                            placeholder="Write news here ..."
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
                    
                    <div className="progress rounded-0 mb-5" style={{ height: '7px'}}>
                        <div className="progress-bar progress-bar-striped progress-bar-animated bg-danger" role="progressbar" style={{ width: `${step === 1 ? '50%' : '100%'}` }}> </div>
                    </div>
                    {

                        title && body && (

                            <div className="d-flex justify-content-center">
                                <Link onClick={() => setStep(2)} ><span> Upload Photos <i className="bi bi-chevron-double-right"></i></span></Link>
                            </div>

                        )

                    }         
                </>
                )}

                {step === 2 && (
                <>
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

                    <div className="mt-3 d-flex flex-wrap gap-3">
                    {/* Existing images from database */}
                    {existingImages.map((url, i) => (
                        <div key={`existing-${i}`} className="position-relative border p-2 rounded" style={{ width: '182px' }}>
                        <button type="button" className="btn btn-sm btn-accent position-absolute top-0 end-0 m-1 shadow-sm rounded-2 d-flex align-items-center justify-content-center" style={{ width: '24px', height: '24px', fontSize: '14px', padding: 0 }} onClick={() => setExistingImages(existingImages.filter((_, index) => index !== i))} aria-label="Remove" >
                            &times;
                        </button>
                        <img src={url} alt="Uploaded" width="100%" height="100" style={{ objectFit: 'cover', borderRadius: '4px' }} />
                        </div>
                    ))}

                    {/* current images preview */}
                    {images.map((file, i) => (
                        <div key={`new-${i}`} className="position-relative border p-2 rounded" style={{ width: '182px' }}>
                        <button type="button" className="btn btn-sm btn-accent position-absolute top-0 end-0 m-1 shadow-sm rounded-2 d-flex align-items-center justify-content-center" style={{ width: '24px', height: '24px', fontSize: '14px', padding: 0 }} onClick={() => setImages(images.filter((_, index) => index !== i))} aria-label="Remove" >
                            &times;
                        </button>
                        <img src={URL.createObjectURL(file)} alt="New" width="100%" height="100" style={{ objectFit: 'cover', borderRadius: '4px' }} />
                        </div>
                    ))}
                    </div>      
              
                    <div className="progress rounded-0 mt-3 mb-5" style={{ height: '7px'}}>
                        <div className="progress-bar progress-bar-striped progress-bar-animated bg-danger" role="progressbar" style={{ width: `${step === 1 ? '50%' : '100%'}` }}> </div>
                    </div>

                    <div className="d-flex justify-content-between">
                        <Link onClick={handleBack} > <span><i className="bi bi-chevron-double-left"></i> Return Back </span> </Link>
                        <Link onClick={handleSubmit}> <span> {editingNews ? 'Update News' : 'Post News'} <i className="bi bi-chevron-double-right"></i></span> </Link>
                    </div>

                </>
                )}

                {step === 3 && (
                    <div className="card border-0 bg-light py-5">
                        
                        {/* LOADING */}
                        {(postLoading || updateLoading) && (
                        <div className="d-flex flex-column justify-content-center align-items-center py-3">
                            <span className='spinner-border spinner-border-sm' style={{ width: '2rem', height: '2rem' }}></span>
                            <div className="text-center my-4">
                            <h4 className="text-heading">Loading ...</h4>
                            <p className="text-heading-secondary">
                                {editingNews ? "Updating news is in-progress" : "Posting news is in-progress"}
                            </p>
                            </div>
                        </div>
                        )}

                        {/* SUCCESS */}
                        {(postSuccess || updateSuccess) && (
                        <>
                            <div className="success-animation">
                            <svg className="checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
                                <circle className="checkmark__circle" cx="26" cy="26" r="25" fill="none" />
                                <path className="checkmark__check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8" />
                            </svg>
                            </div>
                            <div className="text-center my-4">
                            <h4 className="text-heading">Success!</h4>
                            <p className="text-heading-secondary">
                                {editingNews ? "News updated successfully." : "News posted successfully."}
                            </p>
                            </div>
                            <div className="d-flex justify-content-center">
                            <button className="btn btn-outline-secondary rounded-5 w-25" onClick={resetNewsupdateForm}> Post another news </button>
                            </div>
                        </>
                        )}

                        {/* ERROR */}
                        {(postError || updateError) && (
                        <div className="text-center my-4">
                            <h4 className="text-danger">Failed</h4>
                            <p className="text-muted">{message || "An error occurred. Please try again."}</p>
                            <div className="d-flex justify-content-center">
                            <button className="btn btn-danger rounded-5" onClick={() => { setStep(1); dispatch(postReset()); } }> Try Again </button>
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

export default NewsupdateForm