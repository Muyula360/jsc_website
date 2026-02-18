import { Link } from 'react-router-dom';
import ReactQuill from 'react-quill';
import { useDropzone } from 'react-dropzone';
import React, { useState, useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";


import 'react-quill/dist/quill.snow.css';
import { postBillboard, getBillboardPosts, updateBillboardPost, postReset, updateReset } from '../features/billboardSlice';


const BillboardForm = ({ editingBillboardPost }) => {
  
  const dispatch = useDispatch();
  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

  const { postLoading, updateLoading, postSuccess, updateSuccess, postError, updateError, message } = useSelector((state) => state.billboards);

  const [step, setStep] = useState(1);
  const [billboardTitle, setBillboardTitle] = useState(``);
  const [billboardBody, setBillboardBody] = useState(``);
  const [billboardPicture, setBillboardPicture] = useState(null);

  const [errors, setErrors] = useState('');
  const [ isSubmitting, setIsSubmitting ] = useState(false);


  // reset announcement form
  const resetBillboardForm = () => {
    setStep(1);
    setBillboardTitle("");
    setBillboardBody("");
    setBillboardPicture(null);

    dispatch(postReset());
    dispatch(updateReset());
    dispatch(getBillboardPosts());
  };


  // display uploaded/dropped billboard picture
  useEffect(() => {

    return () => {
      if (billboardPicture) {
        URL.revokeObjectURL(billboardPicture.preview);
      }
    };

  }, [billboardPicture]);


  // Populate billboard post when editing 
  useEffect(() => {
    
    if (editingBillboardPost) {
      setBillboardTitle(editingBillboardPost.billboardTitle || "");
      setBillboardBody(editingBillboardPost.billboardBody || "");
      
      // Check if image exists
      if (editingBillboardPost.billboardPhotoPath) {
        setBillboardPicture({
          preview: `${webMediaURL}/${editingBillboardPost.billboardPhotoPath}`,
          existing: true, // mark as existing, not new file
        });
      }
    }
  }, [editingBillboardPost]);


  // Clean up URL.createObjectURL when component unmounts
  useEffect(() => {
    return () => {
      if (billboardPicture && billboardPicture.preview && !billboardPicture.existing) {
        URL.revokeObjectURL(billboardPicture.preview);
      }
    };
  }, [billboardPicture]);


  // on drop billboard picture
  const onDropBillboardPic = (acceptedFiles) => {
    const file = acceptedFiles[0];
    const preview = URL.createObjectURL(file);

    if (billboardPicture && billboardPicture.preview && !billboardPicture.existing) {
      URL.revokeObjectURL(billboardPicture.preview);
    }

    setBillboardPicture({ file, preview });
  };

  // drop zone for billboard picture
  const { getRootProps, getInputProps, isDragActive } = useDropzone({
    accept: { 'image/jpeg': ['.jpeg', '.jpg'], 'image/png': ['.png'] },
    onDrop: onDropBillboardPic,
    multiple: false,
  });


  // when user clicks 'Post' button this function is invokeds
  const handleSubmit = (e) => {

    e.preventDefault();

    if (!billboardPicture || !billboardTitle || !billboardBody) {
      setErrors("All fields are required.");
      return;
    }

    setStep(3);
    setIsSubmitting(true);

    const billboardDetails = new FormData();
    billboardDetails.append('billboardTitle', billboardTitle);
    billboardDetails.append('billboardBody', billboardBody);
    billboardDetails.append('showOnCarouselDisplay', true);

    // If new image uploaded, send file
    if (billboardPicture.file) {
      billboardDetails.append('billboardPicture', billboardPicture.file);
    }

    // If editing, include billboardID in the payload
    if (editingBillboardPost) {

      billboardDetails.append('billboardID', editingBillboardPost.billboardID);
      dispatch(updateBillboardPost(billboardDetails));

    } else {

      dispatch(postBillboard(billboardDetails));
    }

  };

  
  // when user clicks 'return back' button this function is invoked
  const handleBack = () => setStep(1);


  // Billboard Form UI
  return (
    <>
      <div className="modal-dialog modal-lg col-9">
        <div className="modal-content px-3 py-2">
          <div className="modal-header border-0">
            <h4 className="modal-title" id="staticBackdropLabel1"> { editingBillboardPost ? "Edit Billboard" : "Post Billboard" } </h4>
            <button type="button" className="btn-close" onClick={resetBillboardForm} data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div className="modal-body">
            <div className="card border-0 custom-card">
              <form >
                {step === 1 && (
                  <>
                    <div className="dropzone-wrapper">
                      <div {...getRootProps()} className="dropzone bg-light border rounded text-center position-relative" style={{ height: "375px", overflow: "hidden", display: "flex", justifyContent: "center", alignItems: "center", border: "5px dashed #ccc" }} >
                        <input {...getInputProps()} style={{ opacity: 0, position: "absolute", width: "100%", height: "100%" }} />
                        {!billboardPicture ? (
                          <p className="text-muted fs-14">Drop billboard picture or click to select</p>
                        ) : (
                          <img src={billboardPicture.preview} alt="Preview" style={{ width: "100%", height: "100%", objectFit: "cover" }} />
                        )}
                      </div>
                    </div>

                    <div className="progress rounded-0 mt-4" style={{ height: '7px' }}>
                      <div className="progress-bar progress-bar-striped progress-bar-animated bg-danger" style={{ width: '50%' }}></div>
                    </div>

                    <div className="d-flex justify-content-end my-4">
                      <Link onClick={() => setStep(2)}>
                        <span> Next <i className="bi bi-chevron-double-right"></i></span>
                      </Link>
                    </div>
                  </>
                )}


                { step === 2 && (
                    <>           
                    <div className="">
                        <div className="mb-3">
                        <div className="form-floating mb-1">
                            <input type="text" minLength={10} className="form-control" placeholder='Billboard Title' id='billboardTitle' value={billboardTitle} onChange={(e) => setBillboardTitle(e.target.value)} required />
                            <label htmlFor="title">Billboard Title</label>
                        </div>
                        </div>
                        <div className="custom-quill mb-3">
                          <ReactQuill 
                              theme="snow" 
                              value={billboardBody} 
                              onChange={setBillboardBody} 
                              key={editingBillboardPost ? editingBillboardPost.billboardID : 'new'}
                              placeholder="Write billbord content here ..."
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
                    <div className="progress rounded-0 mt-3 mb-4" style={{ height: '7px'}}>
                        <div className="progress-bar progress-bar-striped progress-bar-animated bg-danger" role="progressbar" style={{ width: `${step === 1 ? '50%' : '100%'}` }}> </div>
                    </div>
                    <div className="d-flex justify-content-between mb-3">
                        <Link onClick={ handleBack } ><span><i className="bi bi-chevron-double-left"></i> Return Back </span></Link>
                        <Link onClick={ handleSubmit } > <span> Post Billboard <i className="bi bi-chevron-double-right"></i></span></Link>
                    </div>
                    </>
                )}

                { step === 3 && (

                  <div className="card border-0 bg-light py-5">
                      { (postLoading || updateLoading) && (
                          <div className="d-flex flex-column justify-content-center align-items-center py-3">
                              <span className='spinner-border spinner-border-sm' style={{ width: '2rem', height: '2rem' }}></span>
                              <div className="text-center my-4">
                                  <h4 className="text-heading">Loading ...</h4>
                                  <p className="text-heading-secondary"> Posting on billboard is in-progress </p>
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
                            <p className="text-heading-secondary"> Billboard posted successfully.</p>
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

export default BillboardForm