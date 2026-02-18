import React, { useState, useEffect, useCallback, useRef } from "react";
import { useDispatch, useSelector } from "react-redux";
import { useDropzone } from "react-dropzone";

import {
  postSpeech,
  updateSpeech,
  postReset,
  updateReset,
} from "../features/speechSlice";

/**
 * SpeechForm – Create or edit a speech announcement.
 * @param {Object} props
 * @param {Object|null} props.editingSpeech - Speech object when editing, null for new.
 * @param {Function} props.onClose - Callback to close the parent modal.
 */
const SpeechForm = ({ editingSpeech, onClose }) => {
  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;
  const dispatch = useDispatch();

  // ------------------------------------------------------------
  // 1. Defensive Redux selector with fallback values
  // ------------------------------------------------------------
  const {
    postLoading = false,
    updateLoading = false,
    postSuccess = false,
    updateSuccess = false,
    postError = false,
    updateError = false,
    message = "",
  } = useSelector((state) => state.speech || {});

  // ------------------------------------------------------------
  // 2. Local state
  // ------------------------------------------------------------
  const [step, setStep] = useState(1);
  const [title, setTitle] = useState("");
  const [location, setLocation] = useState("");
  const [files, setFiles] = useState([]);
  const [existingFileURL, setExistingFileURL] = useState(null);
  const [errors, setErrors] = useState({});

  // Ref to track if this is the initial mount
  const isInitialMount = useRef(true);
  // Ref to store previous editingSpeech value
  const prevEditingSpeechRef = useRef(null);
  // Ref to store object URL for cleanup
  const objectUrlRef = useRef(null);

  // ------------------------------------------------------------
  // 3. Dropzone configuration – memoized with useCallback
  // ------------------------------------------------------------
  const onDrop = useCallback((acceptedFiles) => {
    if (acceptedFiles.length > 0) {
      // Revoke previous object URL if any
      if (objectUrlRef.current) {
        URL.revokeObjectURL(objectUrlRef.current);
        objectUrlRef.current = null;
      }
      setFiles([acceptedFiles[0]]);
      setErrors((prev) => ({ ...prev, file: null }));
    }
  }, []);

  const { getRootProps, getInputProps, isDragActive } = useDropzone({
    onDrop,
    multiple: false,
    accept: { "application/pdf": [".pdf"] },
    maxFiles: 1,
  });

  // ------------------------------------------------------------
  // 4. Memoized form reset
  // ------------------------------------------------------------
  const resetForm = useCallback(() => {
    setStep(1);
    setTitle("");
    setLocation("");
    setFiles([]);
    if (objectUrlRef.current) {
      URL.revokeObjectURL(objectUrlRef.current);
      objectUrlRef.current = null;
    }
    setExistingFileURL(null);
    setErrors({});

    dispatch(postReset());
    dispatch(updateReset());
  }, [dispatch]);

  // ------------------------------------------------------------
  // 5. Populate form when editing - FIXED VERSION
  // ------------------------------------------------------------
  useEffect(() => {
    // Skip on initial mount if we want to start with empty form
    if (isInitialMount.current) {
      isInitialMount.current = false;
      
      // If we have editingSpeech on initial mount (e.g., when modal opens with edit mode)
      if (editingSpeech) {
        setTitle(editingSpeech.announcementTitle || "");
        setLocation(editingSpeech.announcementDesc || "");
        if (editingSpeech.attachmentPath) {
          setExistingFileURL(`${webMediaURL}/${editingSpeech.attachmentPath}`);
        }
      }
      return;
    }

    // Check if editingSpeech changed from null to object (open edit mode)
    if (editingSpeech && !prevEditingSpeechRef.current) {
      setTitle(editingSpeech.announcementTitle || "");
      setLocation(editingSpeech.announcementDesc || "");
      if (editingSpeech.attachmentPath) {
        setExistingFileURL(`${webMediaURL}/${editingSpeech.attachmentPath}`);
      }
      setStep(1); // Reset to step 1 when editing
    }
    
    // Check if editingSpeech changed from object to null (closed edit mode, open create mode)
    if (!editingSpeech && prevEditingSpeechRef.current) {
      resetForm();
    }

    // Update ref with current value
    prevEditingSpeechRef.current = editingSpeech;
  }, [editingSpeech, webMediaURL, resetForm]);

  // ------------------------------------------------------------
  // 6. Step control – move to preview when file is selected
  // ------------------------------------------------------------
  useEffect(() => {
    if (files.length > 0) {
      setStep(2);
    }
  }, [files]);

  // ------------------------------------------------------------
  // 7. Create & revoke object URL for new file
  // ------------------------------------------------------------
  useEffect(() => {
    if (files.length > 0) {
      const url = URL.createObjectURL(files[0]);
      objectUrlRef.current = url;
    }
    return () => {
      if (objectUrlRef.current) {
        URL.revokeObjectURL(objectUrlRef.current);
        objectUrlRef.current = null;
      }
    };
  }, [files]);

  // ------------------------------------------------------------
  // 8. Handle submission
  // ------------------------------------------------------------
  const handleSubmit = useCallback(
    (e) => {
      e.preventDefault();

      // Validation
      const newErrors = {};
      if (!title.trim()) newErrors.title = "Title is required.";
      if (!location.trim()) newErrors.location = "Location is required.";
      if (!editingSpeech && files.length === 0)
        newErrors.file = "PDF file is required.";

      if (Object.keys(newErrors).length > 0) {
        setErrors(newErrors);
        return;
      }

      setErrors({});
      setStep(3); // Move to feedback step

      const formData = new FormData();
      formData.append("announcementTitle", title.trim());
      formData.append("announcementlocation", location.trim());

      if (files.length > 0) {
        formData.append("announcementAttachment", files[0]);
      }

      if (editingSpeech) {
        formData.append("announcementID", editingSpeech.announcementID);
        dispatch(updateSpeech(formData));
      } else {
        dispatch(postSpeech(formData));
      }
    },
    [title, location, files, editingSpeech, dispatch]
  );

  // ------------------------------------------------------------
  // 9. Success/Error feedback – auto‑close only after successful submit
  // ------------------------------------------------------------
  useEffect(() => {
    if ((postSuccess || updateSuccess) && onClose) {
      const timer = setTimeout(() => {
        onClose();
        resetForm();
      }, 2000);
      return () => clearTimeout(timer);
    }
  }, [postSuccess, updateSuccess, onClose, resetForm]);

  // ------------------------------------------------------------
  // 10. Cleanup on unmount
  // ------------------------------------------------------------
  useEffect(() => {
    return () => {
      if (objectUrlRef.current) {
        URL.revokeObjectURL(objectUrlRef.current);
      }
      dispatch(postReset());
      dispatch(updateReset());
    };
  }, [dispatch]);

  // ------------------------------------------------------------
  // 11. UI Helpers
  // ------------------------------------------------------------
  const isSubmitting = postLoading || updateLoading;
  const isSuccess = postSuccess || updateSuccess;
  const isError = postError || updateError;

  const getProgressWidth = () => {
    if (step === 1) return "50%";
    if (step === 2) return "75%";
    return "100%";
  };

  // ------------------------------------------------------------
  // 12. Render
  // ------------------------------------------------------------
  return (
    <div className="p-2 pb-3">
      {/* Modal Header */}
      <div className="modal-header border-0">
        <h4 className="modal-title">
          {editingSpeech ? "Edit Speech" : "Post Speech"}
        </h4>
        <button
          type="button"
          className="btn-close"
          aria-label="Close"
          onClick={() => {
            resetForm();
            if (onClose) onClose();
          }}
          disabled={isSubmitting}
        />
      </div>

      <div className="modal-body">
        <div className="card border-0">
          {/* ========== STEP 1: Title, Location, Upload ========== */}
          {step === 1 && (
            <>
              <div className="mb-3">
                <div className="form-floating">
                  <input
                    type="text"
                    className={`form-control ${errors.title ? "is-invalid" : ""}`}
                    id="title"
                    placeholder="Speech Title"
                    value={title}
                    onChange={(e) => setTitle(e.target.value)}
                    disabled={isSubmitting}
                  />
                  <label htmlFor="title">Speech Title</label>
                  {errors.title && (
                    <div className="invalid-feedback">{errors.title}</div>
                  )}
                </div>
              </div>

              <div className="mb-3">
                <div className="form-floating">
                  <input
                    type="text"
                    className={`form-control ${errors.location ? "is-invalid" : ""}`}
                    id="location"
                    placeholder="Speech Location"
                    value={location}
                    onChange={(e) => setLocation(e.target.value)}
                    disabled={isSubmitting}
                  />
                  <label htmlFor="location">Speech Location</label>
                  {errors.location && (
                    <div className="invalid-feedback">{errors.location}</div>
                  )}
                </div>
              </div>

              <div
                {...getRootProps({
                  className: `dropzone border p-5 text-center rounded cursor-pointer ${
                    errors.file ? "border-danger" : ""
                  } ${isSubmitting ? "opacity-50 pe-none" : ""}`,
                })}
              >
                <input {...getInputProps()} disabled={isSubmitting} />
                {isDragActive ? (
                  <p>Drop the Speech PDF here...</p>
                ) : (
                  <div>
                    <h2 className="text-secondary">
                      <i className="bi bi-collection" />
                    </h2>
                    <p className="fs-16">
                      {editingSpeech && !files.length
                        ? "Drop new PDF here or click to replace"
                        : "Drop Speech PDF here or click to upload"}
                    </p>
                    <small className="text-muted">
                      {editingSpeech && existingFileURL && !files.length
                        ? "Current file: existing PDF. Upload new to replace."
                        : "(Only one PDF file allowed)"}
                    </small>
                  </div>
                )}
              </div>
              {errors.file && (
                <p className="text-danger mt-2 small">{errors.file}</p>
              )}

              {/* Progress bar */}
              <div className="progress rounded-0 mt-3 mb-4" style={{ height: "7px" }}>
                <div
                  className="progress-bar progress-bar-striped progress-bar-animated bg-danger"
                  role="progressbar"
                  style={{ width: getProgressWidth() }}
                />
              </div>

              {title && location && (files.length > 0 || editingSpeech) && (
                <div className="d-flex justify-content-end">
                  <button
                    type="button"
                    className="btn btn-link p-0"
                    onClick={() => setStep(2)}
                    disabled={isSubmitting}
                  >
                    Preview <i className="bi bi-chevron-double-right" />
                  </button>
                </div>
              )}
            </>
          )}

          {/* ========== STEP 2: PDF Preview ========== */}
          {step === 2 && (
            <>
              {files.length > 0 ? (
                <object
                  data={objectUrlRef.current || ""}
                  type="application/pdf"
                  width="100%"
                  height="350px"
                  aria-label="PDF Preview"
                >
                  <p className="text-heading-secondary">
                    Preview not available.
                  </p>
                </object>
              ) : existingFileURL ? (
                <object
                  data={existingFileURL}
                  type="application/pdf"
                  width="100%"
                  height="350px"
                  aria-label="PDF Preview"
                >
                  <p className="text-heading-secondary">
                    Preview not available.
                  </p>
                </object>
              ) : (
                <p className="text-muted text-center py-5">
                  No preview available
                </p>
              )}

              <div className="progress rounded-0 mt-3 mb-4" style={{ height: "7px" }}>
                <div
                  className="progress-bar progress-bar-striped progress-bar-animated bg-danger"
                  role="progressbar"
                  style={{ width: getProgressWidth() }}
                />
              </div>

              <div className="d-flex justify-content-between mb-3">
                <button
                  type="button"
                  className="btn btn-link p-0"
                  onClick={() => setStep(1)}
                  disabled={isSubmitting}
                >
                  <i className="bi bi-chevron-double-left" /> Return Back
                </button>
                <button
                  type="button"
                  className="btn btn-link p-0"
                  onClick={handleSubmit}
                  disabled={isSubmitting}
                >
                  {isSubmitting ? (
                    <>
                      <span className="spinner-border spinner-border-sm me-2" />
                      {editingSpeech ? "Updating..." : "Posting..."}
                    </>
                  ) : (
                    <>
                      Finish <i className="bi bi-chevron-double-right" />
                    </>
                  )}
                </button>
              </div>
            </>
          )}

          {/* ========== STEP 3: Submission Feedback ========== */}
          {step === 3 && (
            <div className="card border-0 bg-light py-5">
              {isSubmitting && (
                <div className="d-flex flex-column justify-content-center align-items-center py-3">
                  <span
                    className="spinner-border spinner-border-sm"
                    style={{ width: "2rem", height: "2rem" }}
                  />
                  <div className="text-center my-4">
                    <h4 className="text-heading">Loading ...</h4>
                    <p className="text-heading-secondary">
                      {editingSpeech ? "Updating Speech" : "Posting Speech"} in
                      progress
                    </p>
                  </div>
                </div>
              )}

              {isSuccess && (
                <div className="d-flex flex-column justify-content-center align-items-center py-3">
                  <div className="success-animation">
                    <svg
                      className="checkmark"
                      xmlns="http://www.w3.org/2000/svg"
                      viewBox="0 0 52 52"
                    >
                      <circle
                        className="checkmark__circle"
                        cx="26"
                        cy="26"
                        r="25"
                        fill="none"
                      />
                      <path
                        className="checkmark__check"
                        fill="none"
                        d="M14.1 27.2l7.1 7.2 16.7-16.8"
                      />
                    </svg>
                  </div>
                  <div className="text-center my-4">
                    <h4 className="text-heading text-success">Success!</h4>
                    <p className="text-heading-secondary">
                      Speech {editingSpeech ? "updated" : "posted"} successfully.
                    </p>
                    <p className="text-muted small">Closing in 2 seconds...</p>
                  </div>
                </div>
              )}

              {isError && (
                <div className="d-flex flex-column justify-content-center align-items-center py-3">
                  <i className="bi bi-exclamation-circle fs-28 text-danger" />
                  <div className="text-center my-4">
                    <h4 className="text-heading text-danger">Failed!</h4>
                    <p className="text-heading-secondary">{message}</p>
                  </div>
                  <div className="d-flex justify-content-center w-100">
                    <button
                      type="button"
                      className="btn btn-outline-secondary rounded-5 w-25"
                      onClick={() => setStep(1)}
                      disabled={isSubmitting}
                    >
                      Return Back
                    </button>
                  </div>
                </div>
              )}
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default SpeechForm;