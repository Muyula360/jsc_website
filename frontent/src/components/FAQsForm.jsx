import React, { useState, useEffect, useCallback, useRef } from "react";
import { useDispatch, useSelector } from "react-redux";

import {
  postFAQ,
  updateFAQ,
  postReset,
  updateReset,
} from "../features/faqsSlice";

/**
 * FAQForm – Create or edit a frequently asked question.
 * @param {Object} props
 * @param {Object|null} props.editingFAQ - FAQ object when editing, null for new.
 * @param {Function} props.onClose - Callback to close the parent modal.
 */
const FAQForm = ({ editingFAQ, onClose }) => {
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
  } = useSelector((state) => state.faqs || {});

  // ------------------------------------------------------------
  // 2. Local state
  // ------------------------------------------------------------
  const [question, setQuestion] = useState("");
  const [answer, setAnswer] = useState("");
  const [errors, setErrors] = useState({});
  const [submitted, setSubmitted] = useState(false);

  // Ref to prevent auto‑close on initial mount
  const isFirstRender = useRef(true);
  const closeTimerRef = useRef(null);

  // ------------------------------------------------------------
  // 3. Memoized form reset
  // ------------------------------------------------------------
  const resetForm = useCallback(() => {
    setQuestion("");
    setAnswer("");
    setErrors({});
    setSubmitted(false);

    if (closeTimerRef.current) {
      clearTimeout(closeTimerRef.current);
      closeTimerRef.current = null;
    }

    dispatch(postReset());
    dispatch(updateReset());
  }, [dispatch]);

  // ------------------------------------------------------------
  // 4. Populate form when editing
  // ------------------------------------------------------------
  useEffect(() => {
    if (editingFAQ) {
      setQuestion(editingFAQ.question || "");
      setAnswer(editingFAQ.answer || "");
    } else {
      resetForm();
    }
  }, [editingFAQ, resetForm]);

  // ------------------------------------------------------------
  // 5. Handle submission
  // ------------------------------------------------------------
  const handleSubmit = useCallback(
    (e) => {
      e.preventDefault();

      // Validation
      const newErrors = {};
      if (!question.trim()) newErrors.question = "Question is required.";
      if (!answer.trim()) newErrors.answer = "Answer is required.";

      if (Object.keys(newErrors).length > 0) {
        setErrors(newErrors);
        return;
      }

      setErrors({});
      setSubmitted(true);

      const faqData = {
        question: question.trim(),
        answer: answer.trim(),
      };

      if (editingFAQ) {
        faqData.faqsID = editingFAQ.faqsID;
        dispatch(updateFAQ(faqData));
      } else {
        dispatch(postFAQ(faqData));
      }
    },
    [question, answer, editingFAQ, dispatch]
  );

  // ------------------------------------------------------------
  // 6. Success/Error feedback – auto‑close only after successful submit
  // ------------------------------------------------------------
  useEffect(() => {
    // Skip auto‑close on initial mount if flags are already true
    if (isFirstRender.current) {
      isFirstRender.current = false;
      return;
    }

    const isPostSuccess = postSuccess && !editingFAQ && submitted;
    const isUpdateSuccess = updateSuccess && editingFAQ && submitted;

    if ((isPostSuccess || isUpdateSuccess) && onClose) {
      closeTimerRef.current = setTimeout(() => {
        onClose();
        resetForm();
      }, 2000);
    }

    return () => {
      if (closeTimerRef.current) {
        clearTimeout(closeTimerRef.current);
        closeTimerRef.current = null;
      }
    };
  }, [postSuccess, updateSuccess, editingFAQ, submitted, onClose, resetForm]);

  // ------------------------------------------------------------
  // 7. Cleanup on unmount
  // ------------------------------------------------------------
  useEffect(() => {
    return () => {
      if (closeTimerRef.current) {
        clearTimeout(closeTimerRef.current);
      }
      dispatch(postReset());
      dispatch(updateReset());
    };
  }, [dispatch]);

  // ------------------------------------------------------------
  // 8. UI Helpers
  // ------------------------------------------------------------
  const isSubmitting = editingFAQ ? updateLoading : postLoading;
  const submitSuccess = editingFAQ ? updateSuccess : postSuccess;
  const submitError = editingFAQ ? updateError : postError;
  const isSuccess = submitSuccess && submitted;
  const isError = submitError && submitted;

  // ------------------------------------------------------------
  // 9. Render
  // ------------------------------------------------------------
  return (
    <div className="modal-content">
      {/* Modal Header */}
      <div className="modal-header border-0">
        <h4 className="modal-title">
          <i className={`bi ${editingFAQ ? 'bi-pencil-fill' : 'bi-plus-circle-fill'} me-2 text-danger`}></i>
          {editingFAQ ? "Edit FAQ" : "Add New FAQ"}
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
        {!isSuccess && !isError ? (
          <form onSubmit={handleSubmit}>
            {/* Question Field */}
            <div className="mb-3">
              <div className="form-floating">
                <input
                  type="text"
                  className={`form-control ${errors.question ? "is-invalid" : ""}`}
                  id="question"
                  placeholder="FAQ Question"
                  value={question}
                  onChange={(e) => {
                    setQuestion(e.target.value);
                    if (errors.question) setErrors({ ...errors, question: null });
                  }}
                  disabled={isSubmitting}
                />
                <label htmlFor="question">
                  <i className="bi bi-question-circle me-2 text-danger"></i>
                  FAQ Question
                </label>
                {errors.question && (
                  <div className="invalid-feedback">{errors.question}</div>
                )}
              </div>
            </div>

            {/* Answer Field */}
            <div className="mb-4">
              <div className="form-floating">
                <textarea
                  className={`form-control ${errors.answer ? "is-invalid" : ""}`}
                  id="answer"
                  placeholder="FAQ Answer"
                  value={answer}
                  onChange={(e) => {
                    setAnswer(e.target.value);
                    if (errors.answer) setErrors({ ...errors, answer: null });
                  }}
                  style={{ height: "200px" }}
                  disabled={isSubmitting}
                />
                <label htmlFor="answer">
                  <i className="bi bi-chat-dots-fill me-2 text-success"></i>
                  FAQ Answer
                </label>
                {errors.answer && (
                  <div className="invalid-feedback">{errors.answer}</div>
                )}
              </div>
            </div>

            {/* Form Actions */}
            <div className="d-flex justify-content-end gap-2">
              <button
                type="button"
                className="btn btn-outline-secondary"
                onClick={() => {
                  resetForm();
                  if (onClose) onClose();
                }}
                disabled={isSubmitting}
              >
                <i className="bi bi-x-circle me-2"></i>
                Cancel
              </button>
              <button
                type="submit"
                className="btn btn-danger"
                disabled={isSubmitting}
              >
                {isSubmitting ? (
                  <>
                    <span className="spinner-border spinner-border-sm me-2" />
                    {editingFAQ ? "Updating..." : "Posting..."}
                  </>
                ) : (
                  <>
                    <i className={`bi ${editingFAQ ? 'bi-check-circle' : 'bi-send'} me-2`}></i>
                    {editingFAQ ? "Update FAQ" : "Post FAQ"}
                  </>
                )}
              </button>
            </div>
          </form>
        ) : (
          /* Success/Error Feedback - Centered */
          <div className="d-flex flex-column justify-content-center align-items-center text-center py-5">
            {isSuccess && (
              <>
                <div className="success-animation mb-4">
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
                <h4 className="text-success fw-bold mb-3">Success!</h4>
                <p className="text-muted mb-2">
                  FAQ {editingFAQ ? "updated" : "posted"} successfully.
                </p>
                <p className="text-muted small">Closing in 2 seconds...</p>
              </>
            )}

            {isError && (
              <>
                <div className="mb-4">
                  <div className="bg-danger bg-opacity-10 rounded-circle p-4 d-inline-block">
                    <i className="bi bi-exclamation-triangle-fill text-danger fs-1"></i>
                  </div>
                </div>
                <h4 className="text-danger fw-bold mb-3">Failed!</h4>
                <p className="text-muted mb-4">
                  {message || "An error occurred. Please try again."}
                </p>
                <button
                  type="button"
                  className="btn btn-outline-danger rounded-5 px-4"
                  onClick={() => {
                    setSubmitted(false);
                    dispatch(postReset());
                    dispatch(updateReset());
                  }}
                >
                  <i className="bi bi-arrow-repeat me-2"></i>
                  Try Again
                </button>
              </>
            )}
          </div>
        )}
      </div>
    </div>
  );
};

export default FAQForm;