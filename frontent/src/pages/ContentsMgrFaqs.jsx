import React, { useEffect, useState, useCallback, useMemo } from "react";
import { useDispatch, useSelector } from "react-redux";
import { formatTableDate } from "../utils/dateUtils";
import { toast } from "react-toastify";

import {
  getFAQs,
  deleteFAQ,
  deleteReset,
  selectFAQs,
  selectIsLoading,
  selectDeleteLoading,
  selectDeleteSuccess,
  selectDeleteError,
  selectErrorMessage,
} from "../features/faqsSlice";

import FAQForm from "../components/FAQsForm";

const ContentsMgrFAQs = () => {
  const dispatch = useDispatch();

  // Safe selector with fallback values
  const {
    faqs = [],
    isLoading = false,
    deleteLoading = false,
    deleteSuccess = false,
    deleteError = false,
    message = "",
  } = useSelector((state) => state.faqs || {});

  const [search, setSearch] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [perPage, setPerPage] = useState(5);
  const [selected, setSelected] = useState(null);
  const [isDeleting, setIsDeleting] = useState(false);
  const [showFAQModal, setShowFAQModal] = useState(false);
  const [showViewModal, setShowViewModal] = useState(false);

  // Function to remove all Bootstrap modals and backdrops
  const removeAllModals = useCallback(() => {
    // Remove all modal backdrops
    const backdrops = document.querySelectorAll('.modal-backdrop');
    backdrops.forEach(backdrop => backdrop.remove());
    
    // Remove modal-open class from body
    document.body.classList.remove('modal-open');
    document.body.style.overflow = '';
    document.body.style.paddingRight = '';
    
    // Hide all modals
    const modals = document.querySelectorAll('.modal.show, .modal.fade.show');
    modals.forEach(modal => {
      modal.classList.remove('show');
      modal.style.display = 'none';
    });
  }, []);

  // Memoized fetch function
  const fetchFAQs = useCallback(() => {
    dispatch(getFAQs());
  }, [dispatch]);

  // 🔹 Fetch FAQs on mount
  useEffect(() => {
    fetchFAQs();
  }, [fetchFAQs]);

  // 🔹 Delete feedback with proper cleanup
  useEffect(() => {
    if (deleteSuccess) {
      toast.success("FAQ deleted successfully");
      dispatch(deleteReset());
      setSelected(null);
      setIsDeleting(false);
      
      // Hide delete modal and remove backdrop
      const deleteModal = document.getElementById('deleteFAQAlert');
      if (deleteModal && window.bootstrap) {
        const modal = window.bootstrap.Modal.getInstance(deleteModal);
        if (modal) {
          modal.hide();
        }
      }
      
      // Remove any remaining backdrops
      removeAllModals();
      
      fetchFAQs();
    }
    
    if (deleteError) {
      toast.error(message || "Delete failed. Please try again.");
      dispatch(deleteReset());
      setIsDeleting(false);
      
      // Hide delete modal and remove backdrop
      const deleteModal = document.getElementById('deleteFAQAlert');
      if (deleteModal && window.bootstrap) {
        const modal = window.bootstrap.Modal.getInstance(deleteModal);
        if (modal) {
          modal.hide();
        }
      }
      
      // Remove any remaining backdrops
      removeAllModals();
    }
  }, [deleteSuccess, deleteError, message, dispatch, fetchFAQs, removeAllModals]);

  // Handle delete with confirmation
  const handleDelete = useCallback(() => {
    if (!selected?.faqsID) {
      toast.error("No FAQ selected for deletion");
      return;
    }
    
    setIsDeleting(true);
    dispatch(deleteFAQ(selected.faqsID));
  }, [selected, dispatch]);

  // Handle search and reset pagination
  const handleSearch = useCallback((e) => {
    setSearch(e.target.value);
    setCurrentPage(1);
  }, []);

  // Handle per page change
  const handlePerPageChange = useCallback((e) => {
    const value = Number(e.target.value);
    setPerPage(value);
    setCurrentPage(1);
  }, []);

  // Handle edit click
  const handleEditClick = useCallback((item) => {
    setSelected(item);
    setShowFAQModal(true);
  }, []);

  // Handle delete click
  const handleDeleteClick = useCallback((item) => {
    setSelected(item);
    
    // Remove any existing backdrops first
    removeAllModals();
    
    // Show delete modal
    const modalElement = document.getElementById('deleteFAQAlert');
    if (modalElement && window.bootstrap) {
      const modal = new window.bootstrap.Modal(modalElement);
      modal.show();
    }
  }, [removeAllModals]);

  // Handle view click
  const handleViewClick = useCallback((item) => {
    setSelected(item);
    setShowViewModal(true);
  }, []);

  // Handle new FAQ click
  const handleNewFAQClick = useCallback(() => {
    setSelected(null);
    setShowFAQModal(true);
  }, []);

  // Handle form modal close
  const handleFormModalClose = useCallback(() => {
    setShowFAQModal(false);
    setSelected(null);
    
    // Hide any Bootstrap modals and remove backdrops
    const modalElement = document.getElementById('faqFormModalBootstrap');
    if (modalElement && window.bootstrap) {
      const modal = window.bootstrap.Modal.getInstance(modalElement);
      if (modal) {
        modal.hide();
      }
    }
    
    removeAllModals();
    fetchFAQs();
  }, [fetchFAQs, removeAllModals]);

  // Handle view modal close
  const handleViewModalClose = useCallback(() => {
    setShowViewModal(false);
    setSelected(null);
    removeAllModals();
  }, [removeAllModals]);

  // Close form modal manually
  const closeFormModal = useCallback(() => {
    setShowFAQModal(false);
    const modalElement = document.getElementById('faqFormModal');
    if (modalElement && window.bootstrap) {
      const modal = window.bootstrap.Modal.getInstance(modalElement);
      if (modal) {
        modal.hide();
      }
    }
    removeAllModals();
  }, [removeAllModals]);

  // Filter FAQs based on search
  const filteredFAQs = useMemo(() => {
    if (!Array.isArray(faqs)) return [];
    if (!search.trim()) return faqs;
    
    const searchLower = search.toLowerCase();
    return faqs.filter((item) => {
      const question = item.question?.toLowerCase() || '';
      const answer = item.answer?.toLowerCase() || '';
      const author = item.postedBy?.toLowerCase() || '';
      const station = item.worktStation?.toLowerCase() || '';
      
      return question.includes(searchLower) || 
             answer.includes(searchLower) || 
             author.includes(searchLower) ||
             station.includes(searchLower);
    });
  }, [faqs, search]);

  // Calculate pagination
  const totalItems = filteredFAQs.length;
  const totalPages = Math.max(1, Math.ceil(totalItems / perPage));
  const startIndex = (currentPage - 1) * perPage;
  const endIndex = Math.min(startIndex + perPage, totalItems);
  const currentItems = filteredFAQs.slice(startIndex, endIndex);

  // Handle page navigation
  const handleNextPage = useCallback(() => {
    if (currentPage < totalPages) {
      setCurrentPage(currentPage + 1);
    }
  }, [currentPage, totalPages]);

  const handlePrevPage = useCallback(() => {
    if (currentPage > 1) {
      setCurrentPage(currentPage - 1);
    }
  }, [currentPage]);

  // Cleanup on unmount
  useEffect(() => {
    return () => {
      removeAllModals();
    };
  }, [removeAllModals]);

  // Loading state
  if (isLoading) {
    return (
      <div className="container-fluid py-5">
        <div className="text-center py-5">
          <div className="spinner-border text-primary" role="status">
            <span className="visually-hidden">Loading...</span>
          </div>
          <p className="mt-3">Loading FAQs...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="container-fluid py-4">
      {/* Header */}
      <div className="d-flex justify-content-between align-items-center mb-4">
        <div>
          <h4 className="fw-bold mb-1">
            <i className="bi bi-question-circle-fill text-danger me-2"></i>
            FAQs Management
          </h4>
          <p className="text-muted small mb-0">
            Manage frequently asked questions and answers
          </p>
        </div>
        
        <button 
          type="button" 
          className="btn btn-accent rounded-1" 
          onClick={() => {
            removeAllModals();
            handleNewFAQClick();
          }}
        >
          <i className="bi bi-plus-circle-fill me-1"></i> Add New FAQ
        </button>
      </div>

      {/* FAQ Form Modal */}
      {showFAQModal && (
        <div 
          className="modal fade show" 
          id="faqFormModal" 
          tabIndex="-1" 
          aria-labelledby="faqFormModalLabel"
          aria-hidden="true"
          style={{ display: 'block', backgroundColor: 'rgba(0,0,0,0.5)' }}
        >
          <div className="modal-dialog modal-lg modal-dialog-centered">
            <div className="modal-content">
              <FAQForm
                editingFAQ={selected}
                onClose={() => {
                  handleFormModalClose();
                  closeFormModal();
                }}
              />
            </div>
          </div>
        </div>
      )}

      {/* Bootstrap Modal Alternative */}
      <div 
        className="modal fade" 
        id="faqFormModalBootstrap" 
        tabIndex="-1" 
        aria-labelledby="faqFormModalLabel"
        aria-hidden="true"
      >
        <div className="modal-dialog modal-lg modal-dialog-centered">
          <div className="modal-content">
            <FAQForm
              editingFAQ={selected}
              onClose={handleFormModalClose}
            />
          </div>
        </div>
      </div>

      {/* View FAQ Details Modal */}
      {showViewModal && selected && (
        <div 
          className="modal fade show" 
          id="viewFAQModal" 
          tabIndex="-1" 
          aria-labelledby="viewFAQModalLabel"
          aria-hidden="true"
          style={{ display: 'block', backgroundColor: 'rgba(0,0,0,0.5)' }}
        >
          <div className="modal-dialog modal-lg modal-dialog-centered">
            <div className="modal-content">
              <div className="modal-header" style={{ 
                color: 'white',
                borderBottom: 'none'
              }}>
                <h5 className="modal-title" id="viewFAQModalLabel" style={{ color: 'black' }}>
                  <i className="bi bi-question-circle-fill me-2" style={{ color: '#dc3545' }}></i>
                  FAQ Details
                </h5>
                <button 
                  type="button" 
                  className="btn-close btn-close-black" 
                  onClick={handleViewModalClose}
                  aria-label="Close"
                ></button>
              </div>
              
              <div className="modal-body p-4">
                {/* Question Section with Accent Color */}
                <div className="mb-4">
                  <div className="d-flex align-items-center mb-3">
                    <div style={{ 
                      background: 'linear-gradient(45deg, #dc3545, #bb2d3b)',
                      borderRadius: '40%',
                      padding: '1rem',
                      marginRight: '1rem',
                      display: 'inline-flex'
                    }}>
                      <i className="bi bi-question fs-4" style={{ color: 'white' }}></i>
                    </div>
                    <div>
                      <h5 className="mb-1 fw-bold text-danger">Question</h5>
                      <p className="mb-0 fs-5">{selected.question || 'No question provided'}</p>
                    </div>
                  </div>
                </div>
                
                {/* Answer Section */}
                <div className="mb-4">
                  <div className="d-flex align-items-center mb-3">
                    <div style={{ 
                      background: 'linear-gradient(45deg, #28a745, #218838)',
                      borderRadius: '40%',
                      padding: '1rem',
                      marginRight: '1rem',
                      display: 'inline-flex'
                    }}>
                      <i className="bi bi-chat-dots-fill fs-4" style={{ color: 'white' }}></i>
                    </div>
                    <div>
                      <h5 className="mb-1 fw-bold text-success">Answer</h5>
                      <p className="mb-0" style={{ whiteSpace: 'pre-wrap' }}>{selected.answer || 'No answer provided'}</p>
                    </div>
                  </div>
                </div>
                
                {/* Information Cards */}
                <div className="row mt-4">
                  {/* Posted By Card */}
                  <div className="col-md-6 mb-3">
                    <div className="p-3 rounded" style={{ 
                      background: 'linear-gradient(45deg, #f8f9fa, #e9ecef)',
                      borderLeft: '4px solid #0d6efd'
                    }}>
                      <h6 className="mb-2" style={{ color: '#0d6efd' }}>
                        <i className="bi bi-person-circle me-2" style={{ color: '#0d6efd' }}></i>
                        Posted By
                      </h6>
                      <p className="fw-bold mb-0" style={{ color: '#212529' }}>
                        {selected.postedBy || 'Unknown'}
                      </p>
                    </div>
                  </div>
                  
                  {/* Station Card */}
                  <div className="col-md-6 mb-3">
                    <div className="p-3 rounded" style={{ 
                      background: 'linear-gradient(45deg, #f8f9fa, #e9ecef)',
                      borderLeft: '4px solid #198754'
                    }}>
                      <h6 className="mb-2" style={{ color: '#198754' }}>
                        <i className="bi bi-building me-2" style={{ color: '#198754' }}></i>
                        Station
                      </h6>
                      <p className="fw-bold mb-0" style={{ color: '#212529' }}>
                        {selected.worktStation || 'N/A'}
                      </p>
                    </div>
                  </div>
                  
                  {/* Date Card */}
                  <div className="col-md-6 mb-3">
                    <div className="p-3 rounded" style={{ 
                      background: 'linear-gradient(45deg, #f8f9fa, #e9ecef)',
                      borderLeft: '4px solid #6f42c1'
                    }}>
                      <h6 className="mb-2" style={{ color: '#6f42c1' }}>
                        <i className="bi bi-calendar-event me-2" style={{ color: '#6f42c1' }}></i>
                        Posted Date
                      </h6>
                      <p className="fw-bold mb-0" style={{ color: '#212529' }}>
                        {formatTableDate(selected.postedAt) || 'N/A'}
                      </p>
                    </div>
                  </div>
                </div>
              </div>
              
              {/* Modal Footer */}
              <div className="modal-footer border-0" style={{ 
                background: 'linear-gradient(45deg, #f8f9fa, #e9ecef)',
                borderTop: '1px solid #dee2e6'
              }}>
                <div className="w-100 d-flex justify-content-end gap-2">
                  <button
                    type="button"
                    className="btn btn-danger"
                    style={{
                      color: 'white',
                      border: 'none',
                      padding: '0.5rem 1.5rem'
                    }}
                    onClick={() => {
                      handleViewModalClose();
                      handleEditClick(selected);
                    }}
                  >
                    <i className="bi bi-pencil me-2"></i>
                    Edit FAQ
                  </button>
                  <button
                    type="button"
                    className="btn"
                    style={{
                      background: 'linear-gradient(45deg, #6c757d, #5a6268)',
                      color: 'white',
                      border: 'none',
                      padding: '0.5rem 1.5rem'
                    }}
                    onClick={handleViewModalClose}
                  >
                    <i className="bi bi-x-circle me-2"></i>
                    Close
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      )}

      {/* Stats Card */}
      <div className="row mb-4">
        <div className="col-md-3">
          <div className="card border-0 shadow-sm">
            <div className="card-body">
              <div className="d-flex justify-content-between align-items-center">
                <div>
                  <h6 className="text-muted mb-1">Total FAQs</h6>
                  <h4 className="fw-bold mb-0">{faqs.length}</h4>
                </div>
                <div className="bg-danger bg-opacity-10 p-3 rounded-circle">
                  <i className="bi bi-question-circle fs-5 text-danger"></i>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div className="col-md-3">
          <div className="card border-0 shadow-sm">
            <div className="card-body">
              <div className="d-flex justify-content-between align-items-center">
                <div>
                  <h6 className="text-muted mb-1">Filtered Results</h6>
                  <h4 className="fw-bold mb-0">{filteredFAQs.length}</h4>
                </div>
                <div className="bg-info bg-opacity-10 p-3 rounded-circle">
                  <i className="bi bi-funnel fs-5 text-info"></i>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div className="col-md-6">
          <div className="card border-0 shadow-sm">
            <div className="card-body">
              <div className="d-flex align-items-center justify-content-between">
                <div className="flex-grow-1 me-3">
                  <input
                    type="text"
                    className="form-control form-control-sm"
                    placeholder="Search FAQs by question, answer, author, or station..."
                    value={search}
                    onChange={handleSearch}
                  />
                </div>
                <div className="d-flex align-items-center">
                  <label className="me-2 mb-0">Show:</label>
                  <select
                    className="form-select form-select-sm"
                    value={perPage}
                    onChange={handlePerPageChange}
                    style={{ width: 'auto' }}
                  >
                    {[5, 10, 15, 20, 25].map((num) => (
                      <option key={num} value={num}>
                        {num}
                      </option>
                    ))}
                  </select>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Main Content Card */}
      <div className="card border-0 shadow-lg">
        <div className="card-body p-0">
          {faqs.length === 0 ? (
            <div className="text-center py-5">
              <i className="bi bi-question-circle display-1 text-muted"></i>
              <h4 className="mt-3">No FAQs found</h4>
              <p className="text-muted">Start by adding your first FAQ</p>
              <button
                className="btn btn-accent mt-2"
                data-bs-toggle="modal"
                data-bs-target="#faqFormModalBootstrap"
                onClick={() => {
                  removeAllModals();
                  setSelected(null);
                }}
              >
                <i className="bi bi-plus-circle me-2"></i>
                Add Your First FAQ
              </button>
            </div>
          ) : (
            <>
              {/* Table */}
              <div className="table-responsive">
                <table className="table table-hover align-middle mb-0">
                  <thead className="table-light">
                    <tr>
                      <th style={{ width: '2%' }}>#</th>
                      <th style={{ width: '30%' }}>Question</th>
                      <th style={{ width: '30%' }}>Answer</th>
                      <th style={{ width: '10%' }}>Posted By</th>
                      <th style={{ width: '10%' }} className="text-end">Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    {currentItems.map((item, index) => (
                      <tr key={item.faqsID || index} className="hover-row">
                        <td className="fw-semibold text-muted">{startIndex + index + 1}</td>
                        <td>
                          <span className="fw-medium lh-base text-truncate d-inline-block">
                            {item.question || 'Untitled Question'}
                          </span>
                        </td>
                        <td>
                          <span className="lh-base text-truncate d-inline-block">
                            {item.answer?.substring(0, 70) || 'No answer provided'}
                          </span>
                        </td>
                        <td>{item.postedBy || 'Unknown'}</td>
                        <td className="text-end">
                          <div className="btn-group" role="group">
                            <button
                              className="btn btn-outline-info btn-sm me-1"
                              onClick={() => handleViewClick(item)}
                              title="View Details"
                              disabled={deleteLoading}
                            >
                              <i className="bi bi-eye-fill"></i>
                            </button>
                            <button
                              className="btn btn-outline-primary btn-sm me-1"
                              data-bs-toggle="modal"
                              data-bs-target="#faqFormModalBootstrap"
                              onClick={() => {
                                removeAllModals();
                                setSelected(item);
                              }}
                              title="Edit"
                              disabled={deleteLoading}
                            >
                              <i className="bi bi-pencil"></i>
                            </button>
                            <button
                              className="btn btn-outline-danger btn-sm"
                              onClick={() => handleDeleteClick(item)}
                              title="Delete"
                              disabled={deleteLoading}
                            >
                              <i className="bi bi-trash"></i>
                            </button>
                          </div>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>

              {/* Pagination */}
              {totalPages > 1 && (
                <div className="border-top p-3">
                  <div className="d-flex justify-content-between align-items-center">
                    <div className="text-muted">
                      Showing {startIndex + 1} to {Math.min(endIndex, totalItems)} of {totalItems} entries
                    </div>
                    <div className="d-flex gap-2">
                      <button
                        className="btn btn-outline-primary btn-sm"
                        onClick={handlePrevPage}
                        disabled={currentPage === 1}
                      >
                        <i className="bi bi-chevron-left"></i> Previous
                      </button>
                      <div className="d-flex align-items-center">
                        <span className="mx-2">
                          Page <strong>{currentPage}</strong> of <strong>{totalPages}</strong>
                        </span>
                      </div>
                      <button
                        className="btn btn-outline-primary btn-sm"
                        onClick={handleNextPage}
                        disabled={currentPage === totalPages}
                      >
                        Next <i className="bi bi-chevron-right"></i>
                      </button>
                    </div>
                  </div>
                </div>
              )}
            </>
          )}
        </div>
      </div>

      {/* Delete Confirmation Modal */}
      <div 
        className="modal fade" 
        id="deleteFAQAlert" 
        tabIndex="-1" 
        aria-labelledby="deleteFAQAlertLabel" 
        aria-hidden="true"
      >
        <div className="modal-dialog modal-dialog-centered">
          <div className="modal-content">
            <div className="modal-header border-0">
              <h5 className="modal-title text-danger" id="deleteFAQAlertLabel">
                <i className="bi bi-exclamation-triangle-fill me-2"></i>
                Confirm Deletion
              </h5>
              <button 
                type="button" 
                className="btn-close" 
                data-bs-dismiss="modal" 
                aria-label="Close"
                onClick={removeAllModals}
              ></button>
            </div>
            <div className="modal-body text-center py-4">
              <div className="mb-4">
                <div className="bg-danger bg-opacity-10 rounded-circle p-3 d-inline-block">
                  <i className="bi bi-trash-fill text-danger fs-1"></i>
                </div>
              </div>
              <h5 className="mb-3">Delete this FAQ?</h5>
              <p className="text-muted">
                <strong>Q: {selected?.question?.substring(0, 100) || 'Selected FAQ'}</strong>
              </p>
              <p className="text-muted mt-2">
                This action cannot be undone. The FAQ will be permanently removed from the system.
              </p>
            </div>
            <div className="modal-footer border-0 justify-content-center">
              <button
                type="button"
                className="btn btn-outline-secondary me-3"
                data-bs-dismiss="modal"
                disabled={isDeleting}
                onClick={removeAllModals}
              >
                Cancel
              </button>
              <button
                type="button"
                className="btn btn-danger"
                onClick={handleDelete}
                disabled={isDeleting || !selected?.faqsID}
              >
                {isDeleting ? (
                  <>
                    <span className="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>
                    Deleting...
                  </>
                ) : (
                  <>
                    <i className="bi bi-trash me-2"></i>
                    Delete FAQ
                  </>
                )}
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ContentsMgrFAQs;