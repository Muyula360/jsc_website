import { Link } from 'react-router-dom';
import React, { useState, useEffect, useRef } from "react";
import { useDispatch, useSelector } from "react-redux";
import { formatTableDate } from "../utils/dateUtils";
import { toast } from "react-toastify";

import { getUserFeedbacks, updateFeedbackRead } from "../features/feedbackSlice";


const ContentsMgrFeedbacks = () => {

  const dispatch = useDispatch();
  
  const webUrl = import.meta.env.VITE_API_WEBURL;
  const iconsPath = webUrl+'/src/assets/icons';

  const { feedbacks, isLoading, updateLoading, isSuccess, updateSuccess, isError, updateError } = useSelector((state) => state.feedbacks);

  const [feedbacksList, setfeedbacksList] = useState([]);
  const [selectedFeedback, setSelectedFeedback] = useState([]);
  const [search, setSearch] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [feedbacksPerPage, setfeedbacksPerPage] = useState(5);  const [selectedNotification, setSelectedNotification] = useState([]);


  // get feedbacks when this page/component loads
  useEffect(() => {
    dispatch(getUserFeedbacks());
  }, [dispatch]);
  

  // after fetching feedbacks successfully assign fetched feedbacks to the feedbacksList array
  useEffect(() => {
    if (isSuccess) {
      setfeedbacksList(feedbacks);
    }
    if (isError) {
      toast.error("Failed to fetch feedbacks.");
    }
  }, [feedbacks, isSuccess, isError]);


  // tooltip
  useEffect(() => {
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    const tooltipList = tooltipTriggerList.map((tooltipTriggerEl) => {
      return new window.bootstrap.Tooltip(tooltipTriggerEl, {
        trigger: 'hover'
      });
    });

    // Cleanup: Dispose tooltips on unmount/re-render to avoid duplicates
    return () => {
      tooltipList.forEach((tooltip) => tooltip.dispose());
    };
  }, [feedbacksList, currentPage]);


  // Search + Filter
  const filteredData = feedbacksList.filter((item) =>
    [item.submitterEmail, item.submitterName, item.feedbackSubject, item.feedbackBody]
    .join(" ")
    .toLowerCase()
    .includes(search.toLowerCase())
  );

  const totalItems = filteredData.length;
  const totalPages = Math.ceil(totalItems / feedbacksPerPage);
  const startItem = (currentPage - 1) * feedbacksPerPage + 1;
  const endItem = Math.min(currentPage * feedbacksPerPage, totalItems);
  const currentItems = filteredData.slice(startItem - 1, endItem);

  const handlePageChange = (pageNumber) => {
    if (pageNumber >= 1 && pageNumber <= totalPages) {
      setCurrentPage(pageNumber);
    }
  };


  // feedbacks pagination
  const renderPagination = () => {
    return Array.from({ length: totalPages }, (_, i) => i + 1).map((page) => (
      <li key={page} className={`page-item ${currentPage === page ? "active" : ""}`} >
        <button className="page-link btn-sm" onClick={() => handlePageChange(page)} >
          {page}
        </button>
      </li>
    ));
  };


  // handle feedback click
  const handleFeedbackClick = (feedback) => {
    setSelectedFeedback(feedback);
    dispatch(updateFeedbackRead(feedback.feedbackID));
  };


  // feedbacks UI
  return (
    <div className="container-fluid py-3">
        <div className="d-flex justify-content-between mb-5">
            <div className="w-50">
                <input type="text" className="form-control rounded-2 py-2 px-4" placeholder="Search ..." value={search} onChange={(e) => setSearch(e.target.value)} />
            </div>
            <div className="">
                <select className="form-select form-select" value={feedbacksPerPage} onChange={(e) => { setfeedbacksPerPage(Number(e.target.value)); setCurrentPage(1); }} >
                    {[5, 10, 15].map((num) => (
                    <option key={num} value={num}>
                        {num}
                    </option>
                    ))}
                </select>
            </div>
        </div>

        {/* feedbacks title*/}
        <div className="d-flex justify-content-between align-items-center mb-5">
            <div>
                <h4>Feedbacks</h4>
                <small className="text-secondary fs-15">You have <span className="text-accent">{ feedbacksList.filter(item => item.readStatus === 0).length }</span> feedbacks to go through</small>
            </div>
            <div className="">
                <button type="button" className="btn btn-outline-secondary">Mark all as Read</button>
            </div>
        </div>


        {/* feedback Preview Modal  */}
        <div className="modal fade" id="feedbackPreview" data-bs-backdrop="static" data-bs-keyboard="false" tabIndex="-1" aria-labelledby="feedbackPreviewLabel" aria-hidden="true" >
          <div className="modal-dialog modal-lg col-8">
            <div className="modal-content rounded-0 p-3">
              <div className="modal-header border-0">
                
                <button type="button" className="btn-close" data-bs-dismiss="modal" onClick={() => setSelectedFeedback([])}></button>
              </div>
              <div className="modal-body">
                <h6 className='text-secondary mb-2'> Sub: <span className='text-heading-secondary fw-semibold fs-18'>{ selectedFeedback.feedbackSubject }</span></h6>
                <div className='d-flex justify-content-between text-secondary mb-3'>
                    <h6>{ `From: ${selectedFeedback.submitterName} (${selectedFeedback.submitterEmail})`}</h6>
                    <span className='fs-13'>{ `${formatTableDate(selectedFeedback.createdAt)}`}</span>
                </div>
                <div className='bg-light p-3 mb-3'>
                    <p className='text-secondary fs-14'>{ selectedFeedback.feedbackBody }</p>
                </div>
                <small className='text-accent'> {`${selectedFeedback.readCount} viewed`} </small>
              </div>
            </div>
          </div>
        </div>


        {/* feedbacks display */}
        <div>
            <h6 className="text-secondary mx-1 mb-2">Today</h6>
            <ul className="p-0">
                {currentItems.map((item, index) => (
                    <li key={item.feedbackID || index} className="list-group-item bg-white py-3 px-4 border-0 rounded-3 mb-3">
                        <Link to="#" data-bs-toggle="modal"  data-bs-target="#feedbackPreview" onClick={() => handleFeedbackClick(item)}>
                        <div className="d-flex align-items-center gap-3">
                          <div style={{ width: '40px' }}>
                              <img src={ `${iconsPath}/review.png` } alt="Notification Icon" style={{ width: "100%" }} className="rounded-5"/>
                          </div>
                          <div className="flex-grow-1">
                              <h6 className="text-heading-secondary">{ `#${item.submitterEmail}` } . <small className="text-accent-secondary small"> { formatTableDate(item.createdAt) }</small></h6>
                              <p className="text-secondary m-0 fs-14">{ item.feedbackSubject }</p>
                          </div>
                          <div className="">
                            <span className="bg-light rounded-circle px-2 py-1">
                              {item.readStatus === 0 ? (
                                <i className="bi bi-envelope text-accent"></i>
                              ) : (
                                <i className="bi bi-envelope-open text-dark"></i>
                              )}
                            </span>
                          </div>
                        </div>
                        </Link>
                    </li>
                ))}

                {currentItems.length === 0 && (
                  <li className="list-group-item p-4 border-0 rounded-2 mb-2 bg-white">
                    <div className="text-center">
                      <p className="text-secondary m-0">No feedbacks found.</p>
                    </div>
                  </li>
                )}
            </ul>
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
  );
};



export default ContentsMgrFeedbacks