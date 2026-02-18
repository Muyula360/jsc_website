import React, { useEffect, useState, useCallback } from "react";
import { useDispatch, useSelector } from "react-redux";
import { formatTableDate } from "../utils/dateUtils";
import { toast } from "react-toastify";

import {
  getSpeeches,
  deleteSpeech,
  deleteReset,
} from "../features/speechSlice";

import SpeechForm from "../components/SpeechForm";

const ContentsMgrSpeeches = () => {
  const dispatch = useDispatch();

  // Safe selector with fallback values
  const {
    speeches = [],
    isLoading = false,
    deleteLoading = false,
    deleteSuccess = false,
    deleteError = false,
    message = "",
  } = useSelector((state) => state.speech || {});

  const [search, setSearch] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [perPage, setPerPage] = useState(5);
  const [selected, setSelected] = useState(null);
  const [isDeleting, setIsDeleting] = useState(false);
  const [showSpeechModal, setShowSpeechModal] = useState(false);
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
  const fetchSpeeches = useCallback(() => {
    dispatch(getSpeeches());
  }, [dispatch]);

  // 🔹 Fetch speeches on mount
  useEffect(() => {
    fetchSpeeches();
  }, [fetchSpeeches]);

  // 🔹 Delete feedback with proper cleanup
  useEffect(() => {
    if (deleteSuccess) {
      toast.success("Speech deleted successfully");
      dispatch(deleteReset());
      setSelected(null);
      setIsDeleting(false);
      
      // Hide delete modal and remove backdrop
      const deleteModal = document.getElementById('deleteSpeechAlert');
      if (deleteModal && window.bootstrap) {
        const modal = window.bootstrap.Modal.getInstance(deleteModal);
        if (modal) {
          modal.hide();
        }
      }
      
      // Remove any remaining backdrops
      removeAllModals();
      
      fetchSpeeches();
    }
    
    if (deleteError) {
      toast.error(message || "Delete failed. Please try again.");
      dispatch(deleteReset());
      setIsDeleting(false);
      
      // Hide delete modal and remove backdrop
      const deleteModal = document.getElementById('deleteSpeechAlert');
      if (deleteModal && window.bootstrap) {
        const modal = window.bootstrap.Modal.getInstance(deleteModal);
        if (modal) {
          modal.hide();
        }
      }
      
      // Remove any remaining backdrops
      removeAllModals();
    }
  }, [deleteSuccess, deleteError, message, dispatch, fetchSpeeches, removeAllModals]);

  // Handle delete with confirmation
  const handleDelete = useCallback(() => {
    if (!selected?.announcementID) {
      toast.error("No speech selected for deletion");
      return;
    }
    
    setIsDeleting(true);
    dispatch(deleteSpeech(selected.announcementID));
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
    setShowSpeechModal(true);
  }, []);

  // Handle delete click
  const handleDeleteClick = useCallback((item) => {
    setSelected(item);
    
    // Remove any existing backdrops first
    removeAllModals();
    
    // Show delete modal
    const modalElement = document.getElementById('deleteSpeechAlert');
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

  // Handle new speech click
  const handleNewSpeechClick = useCallback(() => {
    setSelected(null);
    setShowSpeechModal(true);
  }, []);

  // Handle form modal close - FIXED: Reset selected when modal closes
  const handleFormModalClose = useCallback(() => {
    setShowSpeechModal(false);
    setSelected(null);
    
    // Hide any Bootstrap modals and remove backdrops
    const modalElement = document.getElementById('speechFormModalBootstrap');
    if (modalElement && window.bootstrap) {
      const modal = window.bootstrap.Modal.getInstance(modalElement);
      if (modal) {
        modal.hide();
      }
    }
    
    removeAllModals();
    fetchSpeeches();
  }, [fetchSpeeches, removeAllModals]);

  // Handle view modal close
  const handleViewModalClose = useCallback(() => {
    setShowViewModal(false);
    setSelected(null);
    removeAllModals();
  }, [removeAllModals]);

  // Filter speeches based on search
  const filteredSpeeches = React.useMemo(() => {
    if (!Array.isArray(speeches)) return [];
    if (!search.trim()) return speeches;
    
    const searchLower = search.toLowerCase();
    return speeches.filter((item) => {
      const title = item.announcementTitle?.toLowerCase() || '';
      const location = item.worktStation?.toLowerCase() || '';
      const author = item.postedBy?.toLowerCase() || '';
      
      return title.includes(searchLower) || 
             location.includes(searchLower) || 
             author.includes(searchLower);
    });
  }, [speeches, search]);

  // Calculate pagination
  const totalItems = filteredSpeeches.length;
  const totalPages = Math.max(1, Math.ceil(totalItems / perPage));
  const startIndex = (currentPage - 1) * perPage;
  const endIndex = Math.min(startIndex + perPage, totalItems);
  const currentItems = filteredSpeeches.slice(startIndex, endIndex);

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
          <p className="mt-3">Loading speeches...</p>
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
            <i className="bi bi-megaphone-fill text-danger me-2"></i>
            Speeches Management
          </h4>
          <p className="text-muted small mb-0">
            Manage and organize speeches
          </p>
        </div>
        
        <button 
          type="button" 
          className="btn btn-accent rounded-1" 
          onClick={() => {
            removeAllModals();
            handleNewSpeechClick();
          }}
        >
          <i className="bi bi-pencil-fill me-1"></i> Post Speech
        </button>
      </div>

      {/* Speech Form Modal - DIRECT RENDER */}
      {showSpeechModal && (
        <div 
          className="modal fade show" 
          id="speechFormModal" 
          tabIndex="-1" 
          aria-labelledby="speechFormModalLabel"
          aria-hidden="true"
          style={{ display: 'block', backgroundColor: 'rgba(0,0,0,0.5)' }}
        >
          <div className="modal-dialog modal-lg modal-dialog-centered">
            <div className="modal-content">
              <SpeechForm
                editingSpeech={selected}  // ✅ FIXED: Changed from editingAnnouncement to editingSpeech
                onClose={handleFormModalClose}  // ✅ FIXED: Use single onClose handler
              />
            </div>
          </div>
        </div>
      )}

      {/* Bootstrap Modal Alternative - For data-bs-toggle usage */}
      <div 
        className="modal fade" 
        id="speechFormModalBootstrap" 
        tabIndex="-1" 
        aria-labelledby="speechFormModalLabel"
        aria-hidden="true"
      >
        <div className="modal-dialog modal-lg modal-dialog-centered">
          <div className="modal-content">
            <SpeechForm
              editingSpeech={selected}  // ✅ FIXED: Changed from editingAnnouncement to editingSpeech
              onClose={handleFormModalClose}
            />
          </div>
        </div>
      </div>

      {/* View Speech Details Modal */}
      {showViewModal && selected && (
        <div 
          className="modal fade show" 
          id="viewSpeechModal" 
          tabIndex="-1" 
          aria-labelledby="viewSpeechModalLabel"
          aria-hidden="true"
          style={{ display: 'block', backgroundColor: 'rgba(0,0,0,0.5)' }}
        >
          <div className="modal-dialog modal-lg modal-dialog-centered">
            <div className="modal-content">
              <div className="modal-header" style={{ 
                borderBottom: 'none'
              }}>
                <h5 className="modal-title" id="viewSpeechModalLabel" style={{ color: 'black' }}>
                  <i className="bi bi-file-text-fill me-2 text-danger"></i>
                  Speech Details
                </h5>
                <button 
                  type="button" 
                  className="btn-close" 
                  onClick={handleViewModalClose}
                  aria-label="Close"
                ></button>
              </div>
              
              <div className="modal-body p-4">
                {/* Title Section with Accent Color */}
                <div className="mb-4">
                  <div className="d-flex align-items-center mb-3">
                    <div style={{ 
                      background: 'linear-gradient(45deg, #dc3545, #bb2d3b)',
                      borderRadius: '40%',
                      padding: '1rem',
                      marginRight: '1rem',
                      display: 'inline-flex'
                    }}>
                      <i className="bi bi-megaphone fs-4" style={{ color: 'white' }}></i>
                    </div>
                    <div>
                      <h5 className="mb-1 fw-bold">
                        {selected.announcementTitle || 'Untitled'}
                      </h5>
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
                      <h6 className="mb-2 text-primary">
                        <i className="bi bi-person-circle me-2"></i>
                        Posted By
                      </h6>
                      <p className="fw-bold mb-0">
                        {selected.postedBy || 'Unknown'}
                      </p>
                    </div>
                  </div>
                  
                  {/* Location Card */}
                  <div className="col-md-6 mb-3">
                    <div className="p-3 rounded" style={{ 
                      background: 'linear-gradient(45deg, #f8f9fa, #e9ecef)',
                      borderLeft: '4px solid #198754'
                    }}>
                      <h6 className="mb-2 text-success">
                        <i className="bi bi-geo-alt-fill me-2"></i>
                        Location
                      </h6>
                      <p className="fw-bold mb-0">
                        {selected.announcementDesc || 'N/A'}
                      </p>
                    </div>
                  </div>
                  
                  {/* Date Card - Added for completeness */}
                  <div className="col-md-6 mb-3">
                    <div className="p-3 rounded" style={{ 
                      background: 'linear-gradient(45deg, #f8f9fa, #e9ecef)',
                      borderLeft: '4px solid #6c757d'
                    }}>
                      <h6 className="mb-2 text-secondary">
                        <i className="bi bi-calendar-event me-2"></i>
                        Posted Date
                      </h6>
                      <p className="fw-bold mb-0">
                        {formatTableDate(selected.postedAt) || 'N/A'}
                      </p>
                    </div>
                  </div>
                </div>
              </div>
              
              {/* Modal Footer */}
              <div className="modal-footer border-0" style={{ 
                background: '#f8f9fa',
                borderTop: '1px solid #dee2e6'
              }}>
                <div className="w-100 d-flex justify-content-end gap-2">
                  <button
                    type="button"
                    className="btn btn-danger"
                    onClick={() => {
                      handleViewModalClose();
                      handleEditClick(selected);
                    }}
                  >
                    <i className="bi bi-pencil me-2"></i>
                    Edit Speech
                  </button>
                  <button
                    type="button"
                    className="btn btn-secondary"
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
                  <h6 className="text-muted mb-1">Total Speeches</h6>
                  <h4 className="fw-bold mb-0">{speeches.length}</h4>
                </div>
                <div className="bg-danger bg-opacity-10 p-3 rounded-circle">
                  <i className="bi bi-megaphone fs-5 text-danger"></i>
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
                  <h4 className="fw-bold mb-0">{filteredSpeeches.length}</h4>
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
                    placeholder="Search speeches by title, location, or author..."
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
          {speeches.length === 0 ? (
            <div className="text-center py-5">
              <i className="bi bi-megaphone display-1 text-muted"></i>
              <h4 className="mt-3">No speeches found</h4>
              <p className="text-muted">Start by posting your first speech</p>
              <button
                className="btn btn-danger mt-2"
                onClick={() => {
                  removeAllModals();
                  handleNewSpeechClick();
                }}
              >
                <i className="bi bi-plus-circle me-2"></i>
                Post Your First Speech
              </button>
            </div>
          ) : (
            <>
              {/* Table */}
              <div className="table-responsive">
                <table className="table table-hover align-middle mb-0">
                  <thead className="table-light">
                    <tr>
                      <th style={{ width: '5%' }}>#</th>
                      <th style={{ width: '50%' }}>Title</th>
                      <th style={{ width: '10%' }}>Location</th>
                      <th style={{ width: '10%' }}>Posted By</th>
                      <th style={{ width: '10%' }}>Date</th>
                      <th style={{ width: '15%' }} className="text-end">Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    {currentItems.map((item, index) => (
                      <tr key={item.announcementID || index} className="hover-row">
                        <td className="fw-semibold text-muted">{startIndex + index + 1}</td>
                        <td><span className="fw-medium">{item.announcementTitle || 'Untitled'}</span></td>
                        <td>{item.worktStation || 'N/A'}</td>
                        <td>{item.postedBy || 'Unknown'}</td>
                        <td>{formatTableDate(item.postedAt) || 'N/A'}</td>
                        <td className="text-end">
                          <div className="btn-group" role="group">
                            <button
                              className="btn btn-outline-info btn-sm"
                              onClick={() => handleViewClick(item)}
                              title="View Details"
                              disabled={deleteLoading}
                            >
                              <i className="bi bi-eye-fill"></i>
                            </button>
                            <button
                              className="btn btn-outline-primary btn-sm"
                              data-bs-toggle="modal"
                              data-bs-target="#speechFormModalBootstrap"
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
                    <nav>
                      <ul className="pagination mb-0">
                        <li className={`page-item ${currentPage === 1 ? 'disabled' : ''}`}>
                          <button className="page-link" onClick={handlePrevPage}>
                            <i className="bi bi-chevron-left"></i>
                          </button>
                        </li>
                        {Array.from({ length: Math.min(5, totalPages) }, (_, i) => {
                          let pageNum;
                          if (totalPages <= 5) {
                            pageNum = i + 1;
                          } else if (currentPage <= 3) {
                            pageNum = i + 1;
                          } else if (currentPage >= totalPages - 2) {
                            pageNum = totalPages - 4 + i;
                          } else {
                            pageNum = currentPage - 2 + i;
                          }
                          return (
                            <li key={pageNum} className={`page-item ${currentPage === pageNum ? 'active' : ''}`}>
                              <button className="page-link" onClick={() => setCurrentPage(pageNum)}>
                                {pageNum}
                              </button>
                            </li>
                          );
                        })}
                        <li className={`page-item ${currentPage === totalPages ? 'disabled' : ''}`}>
                          <button className="page-link" onClick={handleNextPage}>
                            <i className="bi bi-chevron-right"></i>
                          </button>
                        </li>
                      </ul>
                    </nav>
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
        id="deleteSpeechAlert" 
        tabIndex="-1" 
        aria-labelledby="deleteSpeechAlertLabel" 
        aria-hidden="true"
      >
        <div className="modal-dialog modal-dialog-centered">
          <div className="modal-content">
            <div className="modal-header border-0">
              <h5 className="modal-title text-danger" id="deleteSpeechAlertLabel">
                <i className="bi bi-exclamation-triangle-fill me-2"></i>
                Confirm Deletion
              </h5>
              <button 
                type="button" 
                className="btn-close" 
                data-bs-dismiss="modal" 
                aria-label="Close"
              ></button>
            </div>
            <div className="modal-body text-center py-4">
              <div className="mb-4">
                <div className="bg-danger bg-opacity-10 rounded-circle p-3 d-inline-block">
                  <i className="bi bi-trash-fill text-danger fs-1"></i>
                </div>
              </div>
              <h5 className="mb-3">Delete "{selected?.announcementTitle || 'Selected Speech'}"?</h5>
              <p className="text-muted">
                This action cannot be undone. The speech will be permanently removed from the system.
              </p>
            </div>
            <div className="modal-footer border-0 justify-content-center">
              <button
                type="button"
                className="btn btn-outline-secondary me-3"
                data-bs-dismiss="modal"
                disabled={isDeleting}
              >
                Cancel
              </button>
              <button
                type="button"
                className="btn btn-danger"
                onClick={handleDelete}
                data-bs-dismiss="modal"
                disabled={isDeleting || !selected?.announcementID}
              >
                {isDeleting ? (
                  <>
                    <span className="spinner-border spinner-border-sm me-2"></span>
                    Deleting...
                  </>
                ) : (
                  <>
                    <i className="bi bi-trash me-2"></i>
                    Delete Speech
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

export default ContentsMgrSpeeches;