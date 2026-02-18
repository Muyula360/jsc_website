import React, { useState, useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";
import { formatTableDate } from "../utils/dateUtils";
import { toast } from "react-toastify";


import { getNewsupdates, deleteNews, reset, deleteReset } from "../features/newsUpdateSlice";
import NewsupdateForm from "../components/NewsupdateForm";


const ContentsMgrNewsupdates = () => {

  const dispatch = useDispatch();
  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

  const { newsupdates, isLoading, deleteLoading, isSuccess, deleteSuccess, isError, deleteError } = useSelector((state) => state.newsUpdates);

  const [newsList, setNewslist] = useState([]);
  const [search, setSearch] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [newsPerPage, setNewsperPage] = useState(5);
  const [selectedNews, setSelectedNews] = useState([]);


  // get news list when this page/component loads
  useEffect(() => {
    dispatch(getNewsupdates());
  }, [dispatch]);
  

  // after fetching news successfully assign fetched news list to the newslist array
  useEffect(() => {
    if (isSuccess) {
      setNewslist(newsupdates);
    }
    if (isError) {
      toast.error("Failed to fetch news updates.");
    }
  }, [newsupdates, isSuccess, isError]);


  // Search + Filter
  const filteredData = newsList.filter((item) =>
    [item.worktStation, item.newsTitle, item.postedBy]
      .join(" ")
      .toLowerCase()
      .includes(search.toLowerCase())
  );

  const totalItems = filteredData.length;
  const totalPages = Math.ceil(totalItems / newsPerPage);
  const startItem = (currentPage - 1) * newsPerPage + 1;
  const endItem = Math.min(currentPage * newsPerPage, totalItems);
  const currentItems = filteredData.slice(startItem - 1, endItem);

  const handlePageChange = (pageNumber) => {
    if (pageNumber >= 1 && pageNumber <= totalPages) {
      setCurrentPage(pageNumber);
    }
  };

  // delete news (when user clicks delete news this function is invoked)
  const handleDelete = (id) => {
    dispatch(deleteNews(id))
      .unwrap()
      .then(() => toast.success("News deleted successfully"))
      .catch(() => toast.error("Failed to delete news post"));
  };

  // news pagination
  const renderPagination = () => {
    return Array.from({ length: totalPages }, (_, i) => i + 1).map((page) => (
      <li key={page} className={`page-item ${currentPage === page ? "active" : ""}`} >
        <button className="page-link btn-sm" onClick={() => handlePageChange(page)} >
          {page}
        </button>
      </li>
    ));
  };


  // News&Updates UI
  return (
    <div className="container-fluid py-3">
      <div className="d-flex justify-content-between align-items-center mb-4">
        <h5 className="m-0">
          <i className="bi bi-list-stars me-2"></i> News & Updates
        </h5>
        <button type="button" className='btn btn-accent rounded-1' data-bs-toggle="modal" data-bs-target="#newsUpdatesForm" >
          <i className="bi bi-pencil-fill me-1"></i> Post News
        </button>
      </div>


      {/* News&Updates Form Modal */}
      <div className="modal fade" id="newsUpdatesForm" data-bs-backdrop="static" data-bs-keyboard="false" tabIndex="-1" aria-labelledby="newsUpdatesFormLabel" aria-hidden="true" >
        <NewsupdateForm editingNews={ selectedNews.newsupdatesID ? selectedNews : null } />
      </div>


      {/* News&Updates Delete Alert Modal */}
      <div className="modal fade" id="deleteNewsAlert" data-bs-backdrop="static" data-bs-keyboard="false" tabIndex="-1" aria-labelledby="deleteNewsAlertLabel" aria-hidden="true">
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
                  <button type="button" className="btn btn-outline-danger btn-sm" disabled> <i className="bi bi-trash"></i> Delete News </button>
                  <button type="button" className="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal" onClick={() => { setSelectedNews([]); dispatch(deleteReset()); }}><i className="bi bi-x"></i> Cancel </button>          
                </div>
              </>
            ) : deleteSuccess ? (
              <>
                <div className="modal-body bg-light text-center rounded-2 py-4 px-3">
                  <div className="d-flex flex-column justify-content-center align-items-center">
                    <i className="bi bi-check-circle-fill fs-1"></i>
                    <span className="">News deleted successfully!</span>
                  </div>
                </div>
                <div className="modal-footer border-0 px-0">
                  <button type="button" className="btn btn-outline-danger btn-sm" disabled> <i className="bi bi-trash"></i> Delete News </button>
                  <button type="button" className="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal" onClick={() => { setSelectedNews([]); dispatch(deleteReset()); }}> <i className="bi bi-x"></i> Cancel </button>          
                </div>
              </>
            ) : (
              <>
                <div className="modal-body bg-light text-center rounded-2 py-4 px-3">
                  <h6 className="text-heading fw-semibold mb-3">{ ` "${selectedNews.newsTitle}" ` }</h6>
                  <small className="text-danger">This news post will be permanently removed. Do you want to proceed?</small>
                </div>
                <div className="modal-footer border-0 px-0">
                  <button type="button" className="btn btn-outline-danger btn-sm" onClick={() => handleDelete(selectedNews.newsupdatesID)}><i className="bi bi-trash"></i> Delete News </button>
                  <button type="button" className="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal" onClick={() => { setSelectedNews([]); dispatch(deleteReset()); }}> <i className="bi bi-x"></i> Cancel </button>          
                </div>
              </>
            )}

          </div>
        </div>
      </div>


      {/* News&Updates Display */}   
      <div className="card border-0 shadow-sm">
        <div className="card-body py-5 px-4">
          {/* Search & Filter */}
          <div className="d-flex justify-content-between align-items-center mb-3 flex-wrap">
            <input type="text" className="form-control w-50 rounded-1 fs-14 me-2" placeholder="Search News ..." value={search} onChange={(e) => setSearch(e.target.value)} />
            <div className="d-flex align-items-center">
              <span className="me-2">Show</span>
              <select className="form-select form-select-sm" value={newsPerPage} onChange={(e) => { setNewsperPage(Number(e.target.value)); setCurrentPage(1); }} >
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
                  <th style={{ width: "10%" }}><h6 className="text-heading fw-semibold text-center"><i className="bi bi-sort-up-alt fs-20"></i></h6></th>
                  <th style={{ width: "30%" }}><h6 className="text-heading fw-semibold">News Title</h6></th>
                  <th style={{ width: "15%" }}><h6 className="text-heading fw-semibold">Posted By</h6></th>
                  <th style={{ width: "15%" }}><h6 className="text-heading fw-semibold">Station</h6></th>
                  <th style={{ width: "15%" }}><h6 className="text-heading fw-semibold">Posted On</h6></th>
                  <th style={{ width: "10%" }}><h6 className="text-heading fw-semibold">Status</h6></th>
                  <th style={{ width: "5%" }} className="text-end"></th>
                </tr>
              </thead>
              <tbody>
                {currentItems.map((item, index) => (
                  <tr key={item.newsupdatesID || index}>
                    <td> 
                      <img src={`${webMediaURL}/${item.coverPhotoPath}`} className="rounded-1" style={{ width: "100%", height: "50px", objectFit: "cover" }}  alt="News Cover Photo" />
                    </td>
                    <td>{item.newsTitle}</td>
                    <td>{item.postedBy}</td>
                    <td>{item.worktStation}</td>
                    <td>{formatTableDate(item.postedAt)}</td>
                    <td>
                      <span className="badge bg-success">Posted</span>
                    </td>
                    <td className="text-end">
                      <div className="btn-group">
                        <button className="btn btn-sm btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#newsUpdatesForm" title="Edit" onClick={() => setSelectedNews(item)} >
                          <i className="bi bi-pencil"></i>
                        </button>
                        <button className="btn btn-sm btn-outline-danger" title="Delete" data-bs-toggle="modal" data-bs-target="#deleteNewsAlert" onClick={() => setSelectedNews(item)} >
                          <i className="bi bi-trash"></i>
                        </button>
                      </div>
                    </td>
                  </tr>
                ))}
                {currentItems.length === 0 && (
                  <tr>
                    <td colSpan="7" className="text-center py-3">
                      No news updates found.
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

export default ContentsMgrNewsupdates;