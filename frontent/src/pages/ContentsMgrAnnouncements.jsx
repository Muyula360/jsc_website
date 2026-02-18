import React, { useState, useEffect, useCallback, useMemo } from "react";
import { useDispatch, useSelector } from "react-redux";
import { formatTableDate } from "../utils/dateUtils";
import { toast } from "react-toastify";

import {
  getAnnouncements,
  deleteAnnouncement,
  deleteReset,
} from "../features/announcementSlice";
import AnnouncementForm from "../components/AnnouncementForm";

const ContentsMgrAnnouncements = () => {
  const dispatch = useDispatch();
  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL; // kept if needed

  // 🔹 Safe selector with fallback values
  const {
    announcements = [],
    isLoading = false,
    deleteLoading = false,
    deleteSuccess = false,
    deleteError = false,
    message = "",
  } = useSelector((state) => state.announcements || {});

  // 🔹 Local UI state
  const [search, setSearch] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [perPage, setPerPage] = useState(5);
  const [selected, setSelected] = useState(null);
  const [isDeleting, setIsDeleting] = useState(false);
  const [showFormModal, setShowFormModal] = useState(false);
  const [showViewModal, setShowViewModal] = useState(false);

  // ------------------------------------------------------------
  // Bootstrap modal cleanup
  // ------------------------------------------------------------
  const removeAllModals = useCallback(() => {
    const backdrops = document.querySelectorAll(".modal-backdrop");
    backdrops.forEach((backdrop) => backdrop.remove());

    document.body.classList.remove("modal-open");
    document.body.style.overflow = "";
    document.body.style.paddingRight = "";

    const modals = document.querySelectorAll(".modal.show, .modal.fade.show");
    modals.forEach((modal) => {
      modal.classList.remove("show");
      modal.style.display = "none";
    });
  }, []);

  // ------------------------------------------------------------
  // Data fetching
  // ------------------------------------------------------------
  const fetchAnnouncements = useCallback(() => {
    dispatch(getAnnouncements());
  }, [dispatch]);

  useEffect(() => {
    fetchAnnouncements();
  }, [fetchAnnouncements]);

  // ------------------------------------------------------------
  // Delete feedback with cleanup & refetch
  // ------------------------------------------------------------
  useEffect(() => {
    if (deleteSuccess) {
      toast.success("Announcement deleted successfully");
      dispatch(deleteReset());
      setSelected(null);
      setIsDeleting(false);

      // Hide delete modal via Bootstrap API
      const deleteModalEl = document.getElementById("deleteAnnouncementAlert");
      if (deleteModalEl && window.bootstrap) {
        const modal = window.bootstrap.Modal.getInstance(deleteModalEl);
        modal?.hide();
      }

      removeAllModals();
      fetchAnnouncements();
    }

    if (deleteError) {
      toast.error(message || "Delete failed. Please try again.");
      dispatch(deleteReset());
      setIsDeleting(false);

      const deleteModalEl = document.getElementById("deleteAnnouncementAlert");
      if (deleteModalEl && window.bootstrap) {
        const modal = window.bootstrap.Modal.getInstance(deleteModalEl);
        modal?.hide();
      }

      removeAllModals();
    }
  }, [
    deleteSuccess,
    deleteError,
    message,
    dispatch,
    fetchAnnouncements,
    removeAllModals,
  ]);

  // ------------------------------------------------------------
  // Memoized filtered data & pagination
  // ------------------------------------------------------------
  const filteredAnnouncements = useMemo(() => {
    if (!Array.isArray(announcements)) return [];
    if (!search.trim()) return announcements;

    const searchLower = search.toLowerCase();
    return announcements.filter((item) => {
      const station = item.worktStation?.toLowerCase() || "";
      const title = item.announcementTitle?.toLowerCase() || "";
      const postedBy = item.postedBy?.toLowerCase() || "";
      return (
        station.includes(searchLower) ||
        title.includes(searchLower) ||
        postedBy.includes(searchLower)
      );
    });
  }, [announcements, search]);

  const totalItems = filteredAnnouncements.length;
  const totalPages = Math.max(1, Math.ceil(totalItems / perPage));
  const startIndex = (currentPage - 1) * perPage;
  const endIndex = Math.min(startIndex + perPage, totalItems);
  const currentItems = filteredAnnouncements.slice(startIndex, endIndex);

  // ------------------------------------------------------------
  // Event handlers (memoized)
  // ------------------------------------------------------------
  const handleSearch = useCallback((e) => {
    setSearch(e.target.value);
    setCurrentPage(1);
  }, []);

  const handlePerPageChange = useCallback((e) => {
    setPerPage(Number(e.target.value));
    setCurrentPage(1);
  }, []);

  const handleEditClick = useCallback((item) => {
    setSelected(item);
    setShowFormModal(true);
  }, []);

  const handleDeleteClick = useCallback(
    (item) => {
      setSelected(item);
      removeAllModals(); // clean any orphaned backdrops

      const modalEl = document.getElementById("deleteAnnouncementAlert");
      if (modalEl && window.bootstrap) {
        const modal = new window.bootstrap.Modal(modalEl);
        modal.show();
      }
    },
    [removeAllModals]
  );

  const handleViewClick = useCallback((item) => {
    setSelected(item);
    setShowViewModal(true);
  }, []);

  const handleNewClick = useCallback(() => {
    setSelected(null);
    setShowFormModal(true);
  }, []);

  const handleFormModalClose = useCallback(() => {
    setShowFormModal(false);
    setSelected(null);

    // Hide Bootstrap form modal if it's open
    const formModalEl = document.getElementById("announcementFormModal");
    if (formModalEl && window.bootstrap) {
      const modal = window.bootstrap.Modal.getInstance(formModalEl);
      modal?.hide();
    }

    removeAllModals();
    fetchAnnouncements(); // refresh list after add/edit
  }, [fetchAnnouncements, removeAllModals]);

  const handleViewModalClose = useCallback(() => {
    setShowViewModal(false);
    setSelected(null);
    removeAllModals();
  }, [removeAllModals]);

  const handleDelete = useCallback(() => {
    if (!selected?.announcementID) {
      toast.error("No announcement selected for deletion");
      return;
    }
    setIsDeleting(true);
    dispatch(deleteAnnouncement(selected.announcementID));
  }, [selected, dispatch]);

  // ------------------------------------------------------------
  // Cleanup on unmount
  // ------------------------------------------------------------
  useEffect(() => {
    return () => {
      removeAllModals();
    };
  }, [removeAllModals]);

  // ------------------------------------------------------------
  // Loading state
  // ------------------------------------------------------------
  if (isLoading) {
    return (
      <div className="container-fluid py-5">
        <div className="text-center py-5">
          <div className="spinner-border text-primary" role="status">
            <span className="visually-hidden">Loading...</span>
          </div>
          <p className="mt-3">Loading announcements...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="container-fluid py-4">
      {/* ========== Header ========== */}
      <div className="d-flex justify-content-between align-items-center mb-4">
        <div>
          <h4 className="fw-bold mb-1">
            <i className="bi bi-megaphone-fill text-danger me-2"></i>
            Announcements Management
          </h4>
          <p className="text-muted small mb-0">
            Manage and organize announcements
          </p>
        </div>

        <button
          type="button"
          className="btn btn-accent rounded-1"
          onClick={() => {
            removeAllModals();
            handleNewClick();
          }}
        >
          <i className="bi bi-pencil-fill me-1"></i> Post Announcement
        </button>
      </div>

      {/* ========== React‑controlled Form Modal ========== */}
      {showFormModal && (
        <div
          className="modal fade show"
          id="announcementFormModal"
          tabIndex="-1"
          aria-labelledby="announcementFormModalLabel"
          aria-hidden="true"
          style={{ display: "block", backgroundColor: "rgba(0,0,0,0.5)" }}
        >
          <div className="modal-dialog modal-lg modal-dialog-centered">
            <div className="modal-content">
              <AnnouncementForm
                editingAnnouncement={selected}
                onClose={handleFormModalClose}
              />
            </div>
          </div>
        </div>
      )}

      {/* ========== Bootstrap Form Modal (alternative, static) ========== */}
      <div
        className="modal fade"
        id="announcementFormModalBootstrap"
        tabIndex="-1"
        aria-labelledby="announcementFormModalLabel"
        aria-hidden="true"
      >
        <div className="modal-dialog modal-lg modal-dialog-centered">
          <div className="modal-content">
            <AnnouncementForm
              editingAnnouncement={selected}
              onClose={handleFormModalClose}
            />
          </div>
        </div>
      </div>

      {/* ========== View Modal ========== */}
      {showViewModal && selected && (
        <div
          className="modal fade show"
          id="viewAnnouncementModal"
          tabIndex="-1"
          aria-labelledby="viewAnnouncementModalLabel"
          aria-hidden="true"
          style={{ display: "block", backgroundColor: "rgba(0,0,0,0.5)" }}
        >
          <div className="modal-dialog modal-lg modal-dialog-centered">
            <div className="modal-content">
              <div className="modal-header border-bottom-0">
                <h5 className="modal-title" id="viewAnnouncementModalLabel">
                  <i className="bi bi-file-text-fill me-2"></i>
                  Announcement Details
                </h5>
                <button
                  type="button"
                  className="btn-close"
                  onClick={handleViewModalClose}
                  aria-label="Close"
                ></button>
              </div>
              <div className="modal-body p-4">
                <div className="mb-4">
                  <div className="d-flex align-items-center mb-3">
                    <div
                      style={{
                        background: "linear-gradient(45deg, #dc3545, #bb2d3b)",
                        borderRadius: "40%",
                        padding: "1rem",
                        marginRight: "1rem",
                      }}
                    >
                      <i className="bi bi-megaphone fs-4 text-white"></i>
                    </div>
                    <div>
                      <h5 className="mb-1 fw-bold">
                        {selected.announcementTitle || "Untitled"}
                      </h5>
                    </div>
                  </div>
                </div>
                <div className="row mt-4">
                  <div className="col-md-6 mb-3">
                    <div
                      className="p-3 rounded"
                      style={{
                        background: "linear-gradient(45deg, #f8f9fa, #e9ecef)",
                        borderLeft: "4px solid red",
                      }}
                    >
                      <h6 className="mb-2 text-primary">
                        <i className="bi bi-person-circle me-2 text-primary"></i>
                        Posted By
                      </h6>
                      <p className="fw-bold mb-0">
                        {selected.postedBy || "Unknown"}
                      </p>
                    </div>
                  </div>
                  <div className="col-md-6 mb-3">
                    <div
                      className="p-3 rounded"
                      style={{
                        background: "linear-gradient(45deg, #f8f9fa, #e9ecef)",
                        borderLeft: "4px solid red",
                      }}
                    >
                      <h6 className="mb-2 text-success">
                        <i className="bi bi-geo-alt-fill me-2 text-success"></i>
                        Station
                      </h6>
                      <p className="fw-bold mb-0">
                        {selected.worktStation || "N/A"}
                      </p>
                    </div>
                  </div>
                </div>
              </div>
              <div
                className="modal-footer border-0"
                style={{
                  background: "linear-gradient(45deg, #f8f9fa, #e9ecef)",
                  borderTop: "1px solid #dee2e6",
                }}
              >
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
                    Edit
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

      {/* ========== Stats Cards ========== */}
      <div className="row mb-4">
        <div className="col-md-3">
          <div className="card border-0 shadow-sm">
            <div className="card-body">
              <div className="d-flex justify-content-between align-items-center">
                <div>
                  <h6 className="text-muted mb-1">Total Announcements</h6>
                  <h4 className="fw-bold mb-0">{announcements.length}</h4>
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
                  <h4 className="fw-bold mb-0">{filteredAnnouncements.length}</h4>
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
                    placeholder="Search by title, station, or author..."
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
                    style={{ width: "auto" }}
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

      {/* ========== Main Table Card ========== */}
      <div className="card border-0 shadow-lg">
        <div className="card-body p-0">
          {announcements.length === 0 ? (
            <div className="text-center py-5">
              <i className="bi bi-megaphone display-1 text-muted"></i>
              <h4 className="mt-3">No announcements found</h4>
              <p className="text-muted">Start by posting your first announcement</p>
              <button
                className="btn btn-accent mt-2"
                onClick={() => {
                  removeAllModals();
                  handleNewClick();
                }}
              >
                <i className="bi bi-plus-circle me-2"></i>
                Post Your First Announcement
              </button>
            </div>
          ) : (
            <>
              <div className="table-responsive">
                <table className="table table-hover align-middle mb-0">
                  <thead className="table-light">
                    <tr>
                      <th style={{ width: "3%" }}>#</th>
                      <th style={{ width: "37%" }}>Title</th>
                      <th style={{ width: "15%" }}>Posted By</th>
                      <th style={{ width: "15%" }}>Station</th>
                      <th style={{ width: "15%" }}>Posted On</th>
                      <th style={{ width: "10%" }}>Status</th>
                      <th style={{ width: "5%" }} className="text-end">
                        Actions
                      </th>
                    </tr>
                  </thead>
                  <tbody>
                    {currentItems.map((item, index) => (
                      <tr key={item.announcementID || index}>
                        <td className="fw-semibold text-muted">
                          {startIndex + index + 1}
                        </td>
                        <td>
                          <span className="fw-medium lh-base">
                            {item.announcementTitle || "Untitled"}
                          </span>
                        </td>
                        <td>{item.postedBy || "Unknown"}</td>
                        <td>{item.worktStation || "N/A"}</td>
                        <td>{formatTableDate(item.postedAt) || "N/A"}</td>
                        <td>
                          <span className="badge bg-success">Posted</span>
                        </td>
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
                              onClick={() => {
                                removeAllModals();
                                handleEditClick(item);
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
                    {currentItems.length === 0 && (
                      <tr>
                        <td colSpan="7" className="text-center py-3">
                          No matching announcements found.
                        </td>
                      </tr>
                    )}
                  </tbody>
                </table>
              </div>

              {/* Pagination */}
              {totalPages > 1 && (
                <div className="border-top p-3">
                  <div className="d-flex justify-content-between align-items-center">
                    <div className="text-muted">
                      Showing {startIndex + 1} to{" "}
                      {Math.min(endIndex, totalItems)} of {totalItems} entries
                    </div>
                    <div className="d-flex gap-2">
                      <button
                        className="btn btn-outline-primary btn-sm"
                        onClick={() =>
                          setCurrentPage((prev) => Math.max(prev - 1, 1))
                        }
                        disabled={currentPage === 1}
                      >
                        <i className="bi bi-chevron-left"></i> Previous
                      </button>
                      <div className="d-flex align-items-center">
                        <span className="mx-2">
                          Page <strong>{currentPage}</strong> of{" "}
                          <strong>{totalPages}</strong>
                        </span>
                      </div>
                      <button
                        className="btn btn-outline-primary btn-sm"
                        onClick={() =>
                          setCurrentPage((prev) => Math.min(prev + 1, totalPages))
                        }
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

      {/* ========== Delete Confirmation Modal (Bootstrap) ========== */}
      <div
        className="modal fade"
        id="deleteAnnouncementAlert"
        tabIndex="-1"
        aria-labelledby="deleteAnnouncementAlertLabel"
        aria-hidden="true"
      >
        <div className="modal-dialog modal-dialog-centered">
          <div className="modal-content">
            <div className="modal-header border-0">
              <h5 className="modal-title text-danger" id="deleteAnnouncementAlertLabel">
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
              <h5 className="mb-3">
                Delete "{selected?.announcementTitle || "Selected Announcement"}"?
              </h5>
              <p className="text-muted">
                This action cannot be undone. The announcement will be permanently
                removed.
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
                disabled={isDeleting || !selected?.announcementID}
              >
                {isDeleting ? (
                  <>
                    <span
                      className="spinner-border spinner-border-sm me-2"
                      role="status"
                      aria-hidden="true"
                    ></span>
                    Deleting...
                  </>
                ) : (
                  <>
                    <i className="bi bi-trash me-2"></i>
                    Delete Announcement
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

export default ContentsMgrAnnouncements;