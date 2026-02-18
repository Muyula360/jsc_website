import React, { useState, useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";
import { formatTableDate } from "../utils/dateUtils";
import { toast } from "react-toastify";


import { getPublications, deletePublication, reset, deleteReset  } from "../features/publicationSlice";
import PublicationForm from "../components/PublicationForm";


const ContentsMgrPublications = () => {

  const dispatch = useDispatch();
  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

  const { publications, isLoading, deleteLoading, isSuccess, deleteSuccess, isError, deleteError } = useSelector((state) => state.publications);

  const [publicationList, setPublicationlist] = useState([]);
  const [search, setSearch] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [publicationsPerPage, setPublicationsPerPage] = useState(5);
  const [selectedPublication, setSelectedPublication] = useState([]);


  // get publication list when this page/component loads
  useEffect(() => {
    dispatch(getPublications());
  }, [dispatch]);


  // get publication list after publication deletion
  useEffect(() => {
  if (deleteSuccess) {
      dispatch(getPublications());   // Refresh the list
    }
  }, [deleteSuccess, dispatch]);


  // after fetching publication successfully assign fetched publication list to the publicationlist array
  useEffect(() => {
    if (isSuccess) {
      setPublicationlist(publications);
    }
    if (isError) {
      toast.error("Failed to fetch publication updates.");
    }
  }, [publications, isSuccess, isError]);


  // Search + Filter
  const filteredData = publicationList.filter((item) =>
    [item.worktStation, item.title, item.category, item.postedBy]
      .join(" ")
      .toLowerCase()
      .includes(search.toLowerCase())
  );

  const totalItems = filteredData.length;
  const totalPages = Math.ceil(totalItems / publicationsPerPage);
  const startItem = (currentPage - 1) * publicationsPerPage + 1;
  const endItem = Math.min(currentPage * publicationsPerPage, totalItems);
  const currentItems = filteredData.slice(startItem - 1, endItem);

  const handlePageChange = (pageNumber) => {
    if (pageNumber >= 1 && pageNumber <= totalPages) {
      setCurrentPage(pageNumber);
    }
  };

  // delete publication (when user clicks delete publication this function is invoked)
  const handleDelete = (id) => {
    dispatch(deletePublication(id))
      .unwrap()
      .then(() => toast.success("Publication deleted successfully"))
      .catch(() => toast.error("Failed to delete publication post"));
  };

  // publication pagination
  const renderPagination = () => {
    return Array.from({ length: totalPages }, (_, i) => i + 1).map((page) => (
      <li key={page} className={`page-item ${currentPage === page ? "active" : ""}`} >
        <button className="page-link btn-sm" onClick={() => handlePageChange(page)} >
          {page}
        </button>
      </li>
    ));
  };


  // Publications UI
  return (
    <div className="container-fluid py-3">
      <div className="d-flex justify-content-between align-items-center mb-4">
        <h5 className="m-0">
          <i className="bi bi-list-stars me-2"></i> Publications
        </h5>
        <button type="button" className='btn btn-accent rounded-1' data-bs-toggle="modal" data-bs-target="#publicationUpdatesForm" >
          <i className="bi bi-pencil-fill me-1"></i> Publish Content
        </button>
      </div>


      {/* Publication Form Modal */}
      <div className="modal fade" id="publicationUpdatesForm" data-bs-backdrop="static" data-bs-keyboard="false" tabIndex="-1" aria-labelledby="publicationUpdatesFormLabel" aria-hidden="true" >
        <PublicationForm editingPublication={ selectedPublication.publicationsID ? selectedPublication : null } />
      </div>


      {/* Publication Delete Alert Modal */}
      <div className="modal fade" id="deletePublicationAlert" data-bs-backdrop="static" data-bs-keyboard="false" tabIndex="-1" aria-labelledby="deletePublicationAlertLabel" aria-hidden="true">
        <div className="modal-dialog modal-dialog-centered">
          <div className="modal-content py-3 px-4">
            <div className="modal-header border-0">
              <h1 className="modal-title fs-5" id="exampleModalLabel"></h1>
            </div>
            
            {deleteLoading ? (
              <>
                <div className="modal-body bg-light text-center rounded-2 py-4 px-3">
                  <div className="d-flex flex-column justify-content-center align-items-center">
                    <span className='spinner-border spinner-border-sm mb-4' style={{ width: '2rem', height: '2rem' }}></span>
                    <span className="">Deleting ...</span>
                  </div>
                </div>
                <div className="modal-footer border-0 px-0">
                  <button type="button" className="btn btn-outline-danger btn-sm" disabled> <i className="bi bi-trash"></i> Delete Publication </button>
                  <button type="button" className="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal" onClick={() => { setSelectedPublication([]); dispatch(deleteReset()); }}> <i className="bi bi-x"></i> Cancel </button>          
                </div>
              </>
            ) : deleteSuccess ? (
              <>
                <div className="modal-body bg-light text-center rounded-2 py-4 px-3">
                  <div className="d-flex flex-column justify-content-center align-items-center">
                    <i className="bi bi-check-circle-fill fs-1"></i>
                    <span className="">Publication deleted successfully!</span>
                  </div>
                </div>
                <div className="modal-footer border-0 px-0">
                  <button type="button" className="btn btn-outline-danger btn-sm" disabled> <i className="bi bi-trash"></i> Delete Publication </button>
                  <button type="button" className="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal" onClick={() => { setSelectedPublication([]); dispatch(deleteReset()); }}> <i className="bi bi-x"></i> Cancel </button>          
                </div>
              </>
            ) : (
              <>
                <div className="modal-body bg-light text-center rounded-2 py-4 px-3">
                  <h6 className="text-heading fw-semibold mb-3">{ ` "${selectedPublication.title}" ` }</h6>
                  <small className="text-danger">This publication will be permanently removed. Do you want to proceed?</small>
                </div>
                <div className="modal-footer border-0 px-0">
                  <button type="button" className="btn btn-outline-danger btn-sm" onClick={() => handleDelete(selectedPublication.publicationsID)}><i className="bi bi-trash"></i> Delete Publication </button>
                  <button type="button" className="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal" onClick={() => { setSelectedPublication([]); dispatch(deleteReset()); }}> <i className="bi bi-x"></i> Cancel </button>          
                </div>
              </>
            )}

          </div>
        </div>
      </div>


      {/* Publication&Updates Display */}   
      <div className="card border-0 shadow-sm">
        <div className="card-body py-5 px-4">
          {/* Search & Filter */}
          <div className="d-flex justify-content-between align-items-center mb-3 flex-wrap">
            <input type="text" className="form-control w-50 rounded-1 fs-14 me-2" placeholder="Search Publication ..." value={search} onChange={(e) => setSearch(e.target.value)} />
            <div className="d-flex align-items-center">
              <span className="me-2">Show</span>
              <select className="form-select form-select-sm" value={publicationsPerPage} onChange={(e) => { setPublicationsPerPage(Number(e.target.value)); setCurrentPage(1); }} >
                {[5, 10, 15].map((num) => (
                  <option key={num} value={num}>
                    {num}
                  </option>
                ))}
              </select>
            </div>
          </div>

          {/* Table */}
          <div className="table-responsive mt-4">
            <table className="table table-hover align-middle">
              <thead className="">
                <tr>
                  <th style={{ width: "3%" }}><h6 className="text-heading fw-semibold text-center"><i className="bi bi-sort-up-alt fs-20"></i></h6></th>
                  <th style={{ width: "35%" }}><h6 className="text-heading fw-semibold">Content Title</h6></th>
                  <th style={{ width: "17%" }}><h6 className="text-heading fw-semibold">Category</h6></th>
                  <th style={{ width: "15%" }}><h6 className="text-heading fw-semibold">Posted By</h6></th>     
                  <th style={{ width: "15%" }}><h6 className="text-heading fw-semibold">Posted On</h6></th>
                  <th style={{ width: "10%" }}><h6 className="text-heading fw-semibold">Status</h6></th>
                  <th style={{ width: "5%" }} className="text-end"></th>
                </tr>
              </thead>
              <tbody>
                {currentItems.map((item, index) => (
                  <tr key={item.publicationsID || index}>
                    <td><i className="bi bi-file-earmark-pdf text-accent fs-20"></i></td>
                    <td>{item.title}</td>
                    <td>{item.category}</td>
                    <td>{item.postedBy}</td>
                    <td>{formatTableDate(item.createdAt)}</td>
                    <td>
                      <span className="badge bg-success">Posted</span>
                    </td>
                    <td className="text-end">
                      <div className="btn-group">
                        <button className="btn btn-sm btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#publicationUpdatesForm" title="Edit" onClick={() => setSelectedPublication(item)} >
                          <i className="bi bi-pencil"></i>
                        </button>
                        <button className="btn btn-sm btn-outline-danger" title="Delete" data-bs-toggle="modal" data-bs-target="#deletePublicationAlert" onClick={() => setSelectedPublication(item)} >
                          <i className="bi bi-trash"></i>
                        </button>
                      </div>
                    </td>
                  </tr>
                ))}
                {currentItems.length === 0 && (
                  <tr>
                    <td colSpan="7" className="text-center py-3">
                      No Publication updates found.
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>

          {/* Pagination */}
          <nav className="d-flex justify-content-between align-items-center mt-4">
            <span>
              Showing {startItem}-{endItem} of {totalItems}
            </span>
            <ul className="pagination mb-0">
              <li className="page-item">
                <button className="page-link btn-sm" onClick={() => handlePageChange(currentPage - 1)} disabled={currentPage === 1} >
                  <i className="bi bi-chevron-left"></i>
                </button>
              </li>
              {renderPagination()}
              <li className="page-item">
                <button className="page-link btn-sm" onClick={() => handlePageChange(currentPage + 1)} disabled={currentPage === totalPages} >
                  <i className="bi bi-chevron-right"></i>
                </button>
              </li>
            </ul>
          </nav>
        </div>
      </div>
    </div>
  );
};


export default ContentsMgrPublications
