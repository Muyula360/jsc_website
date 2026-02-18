import React, { useState, useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";
import { formatTableDate } from "../utils/dateUtils";
import { toast } from "react-toastify";


import { getNewsletters, deleteNewsletter, reset, deleteReset } from "../features/newsLetterSlice";
import NewsletterForm from "../components/NewsletterForm";


const ContentsMgrNewsletterletters = () => {

  const dispatch = useDispatch();
  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

  const { newsletters, isLoading, deleteLoading, isSuccess, deleteSuccess, isError, deleteError } = useSelector((state) => state.newsletters);

  const [newsletterList, setNewsletterlist] = useState([]);
  const [search, setSearch] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [newslettersPerPage, setNewslettersPerPage] = useState(5);
  const [selectedNewsletter, setSelectedNewsletter] = useState([]);


  // get newsletter list when this page/component loads
  useEffect(() => {
    dispatch(getNewsletters());
  }, [dispatch]);


  // after fetching newsletters successfully assign fetched newsletters list to the newsletterslist array
  useEffect(() => {
    if (isSuccess) {
      setNewsletterlist(newsletters);
    }
    if (isError) {
      toast.error("Failed to fetch newsletter updates.");
    }
  }, [newsletters, isSuccess, isError]);


  // Search + Filter
  const filteredData = newsletterList.filter((item) =>
    [item.worktStation, item.newsletterMonth, item.postedBy]
      .join(" ")
      .toLowerCase()
      .includes(search.toLowerCase())
  );

  const totalItems = filteredData.length;
  const totalPages = Math.ceil(totalItems / newslettersPerPage);
  const startItem = (currentPage - 1) * newslettersPerPage + 1;
  const endItem = Math.min(currentPage * newslettersPerPage, totalItems);
  const currentItems = filteredData.slice(startItem - 1, endItem);

  const handlePageChange = (pageNumber) => {
    if (pageNumber >= 1 && pageNumber <= totalPages) {
      setCurrentPage(pageNumber);
    }
  };

  // delete newsletter (when user clicks delete newsletter this function is invoked)
  const handleDelete = (id) => {
    dispatch(deleteNewsletter(id))
      .unwrap()
      .then(() => toast.success("Newsletter deleted successfully"))
      .catch(() => toast.error("Failed to delete newsletter post"));
  };

  // newsletter pagination
  const renderPagination = () => {
    return Array.from({ length: totalPages }, (_, i) => i + 1).map((page) => (
      <li key={page} className={`page-item ${currentPage === page ? "active" : ""}`} >
        <button className="page-link btn-sm" onClick={() => handlePageChange(page)} >
          {page}
        </button>
      </li>
    ));
  };


  // Newsletter UI
  return (
    <div className="container-fluid py-3">
      <div className="d-flex justify-content-between align-items-center mb-4">
        <h5 className="m-0">
          <i className="bi bi-list-stars me-2"></i> Newsletterletters (Haki Bulletin)
        </h5>
        <button type="button" className='btn btn-accent rounded-1' data-bs-toggle="modal" data-bs-target="#newsletterUpdatesForm" >
          <i className="bi bi-pencil-fill me-1"></i> Post Newsletterletter
        </button>
      </div>


      {/* Newsletter Form Modal */}
      <div className="modal fade" id="newsletterUpdatesForm" data-bs-backdrop="static" data-bs-keyboard="false" tabIndex="-1" aria-labelledby="newsletterUpdatesFormLabel" aria-hidden="true" >
        <NewsletterForm editingNewsletter={ selectedNewsletter.newsletterID ? selectedNewsletter : null } />
      </div>


      {/* Newsletter Delete Alert Modal */}
      <div className="modal fade" id="deleteNewsletterAlert" data-bs-backdrop="static" data-bs-keyboard="false" tabIndex="-1" aria-labelledby="deleteNewsletterAlertLabel" aria-hidden="true">
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
                  <button type="button" className="btn btn-outline-danger btn-sm" disabled> <i className="bi bi-trash"></i> Delete Newsletter </button>
                  <button type="button" className="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal" onClick={() => { setSelectedNewsletter([]); dispatch(deleteReset()); }}><i className="bi bi-x"></i> Cancel </button>          
                </div>
              </>
            ) : deleteSuccess ? (
              <>
                <div className="modal-body bg-light text-center rounded-2 py-4 px-3">
                  <div className="d-flex flex-column justify-content-center align-items-center">
                    <i className="bi bi-check-circle-fill fs-1"></i>
                    <span className="">Newsletter deleted successfully!</span>
                  </div>
                </div>
                <div className="modal-footer border-0 px-0">
                  <button type="button" className="btn btn-outline-danger btn-sm" disabled> <i className="bi bi-trash"></i> Delete Newsletter </button>
                  <button type="button" className="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal" onClick={() => { setSelectedNewsletter([]); dispatch(deleteReset()); }}> <i className="bi bi-x"></i> Cancel </button>          
                </div>
              </>
            ) : (
              <>
                <div className="modal-body bg-light text-center rounded-2 py-4 px-3">
                  <h6 className="text-heading fw-semibold mb-3">{ `"Haki Bulletin Toleo No.${selectedNewsletter.newsletterNo}, ${selectedNewsletter.newsletterMonth} Mwaka ${selectedNewsletter.newsletterYear}"` }</h6>
                  <small className="text-danger">This newsletter will be permanently removed. Do you want to proceed?</small>
                </div>
                <div className="modal-footer border-0 px-0">
                  <button type="button" className="btn btn-outline-danger btn-sm" onClick={() => handleDelete(selectedNewsletter.newsletterID)}><i className="bi bi-trash"></i> Delete Newsletter </button>
                  <button type="button" className="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal" onClick={() => { setSelectedNewsletter([]); dispatch(deleteReset()); }}> <i className="bi bi-x"></i> Cancel </button>          
                </div>
              </>
            )}

          </div>
        </div>
      </div>


      {/* Newsletter Display */}   
      <div className="card border-0 shadow-sm">
        <div className="card-body py-5 px-4">
          {/* Search & Filter */}
          <div className="d-flex justify-content-between align-items-center mb-3 flex-wrap">
            <input type="text" className="form-control w-50 rounded-1 fs-14 me-2" placeholder="Search Newsletter ..." value={search} onChange={(e) => setSearch(e.target.value)} />
            <div className="d-flex align-items-center">
              <span className="me-2">Show</span>
              <select className="form-select form-select-sm" value={newslettersPerPage} onChange={(e) => { setNewslettersPerPage(Number(e.target.value)); setCurrentPage(1); }} >
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
                  <th style={{ width: "9%" }}><h6 className="text-heading fw-semibold text-center"><i className="bi bi-sort-up-alt fs-20"></i></h6></th>
                  <th style={{ width: "30%" }}><h6 className="text-heading fw-semibold">Newsletter Title</h6></th>
                  <th style={{ width: "10%" }}><h6 className="text-heading fw-semibold">Reads</h6></th>
                  <th style={{ width: "10%" }}><h6 className="text-heading fw-semibold">Downloads</h6></th>
                  <th style={{ width: "15%" }}><h6 className="text-heading fw-semibold">Posted By</h6></th>
                  <th style={{ width: "15%" }}><h6 className="text-heading fw-semibold">Posted On</h6></th>
                  <th style={{ width: "11%" }}><h6 className="text-heading fw-semibold">Status</h6></th>             
                  <th style={{ width: "5%" }} className="text-end"></th>
                </tr>
              </thead>
              <tbody>
                {currentItems.map((item, index) => (
                  <tr key={item.newsletterID || index}>
                    <td><img src={`${webMediaURL}/${item.newsletterCoverPath}`} className="rounded-0" style={{ width: "100%", height: "50px", objectFit: "cover" }}  alt="Newsletter Cover Photo" /></td>
                    <td>{ `Haki Bulletin Toleo No.${item.newsletterNo}, ${item.newsletterMonth} Mwaka ${item.newsletterYear}`}</td>
                    <td>{ item.reads }</td>
                    <td>{ item.downloads }</td>
                    <td>{ item.postedBy }</td>
                    <td>{formatTableDate(item.postedAt)}</td>
                    <td><span className="badge bg-success">Posted</span></td>
                    <td className="text-end">
                      <div className="btn-group">
                        <button className="btn btn-sm btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#newsletterUpdatesForm" title="Edit" onClick={() => setSelectedNewsletter(item)} >
                          <i className="bi bi-pencil"></i>
                        </button>
                        <button className="btn btn-sm btn-outline-danger" title="Delete" data-bs-toggle="modal" data-bs-target="#deleteNewsletterAlert" onClick={() => setSelectedNewsletter(item)} >
                          <i className="bi bi-trash"></i>
                        </button>
                      </div>
                    </td>
                  </tr>
                ))}
                {currentItems.length === 0 && (
                  <tr>
                    <td colSpan="8" className="text-center py-3">
                      No Newsletter updates found.
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


export default ContentsMgrNewsletterletters
