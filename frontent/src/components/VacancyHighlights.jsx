import { Link } from "react-router-dom";
import React, { useState, useEffect } from "react";
import { useDispatch, useSelector } from 'react-redux';
import { getTenders } from "../features/tenderSlice";
import { returnDate } from "../utils/dateUtils";
import { toast } from "react-toastify";

const VacancyHighlights = () => {

  const dispatch = useDispatch();
  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

  const { tenders, isLoading, isSuccess, isError, message } = useSelector(
    (state) => state.tenders
  );

  const [tendersList, setTendersList] = useState([]);

  // get all the tenders from API
  useEffect(() => {
    dispatch(getTenders());
  }, [dispatch]);

  // if fetching tender is successfully assign fetched tenders to tenderList array
  useEffect(() => {
    if (isSuccess) {
      setTendersList(tenders);
    }
    if (isError) {
      toast.error("Failed to fetch tender updates.");
    }
  }, [tenders, isSuccess, isError]);


  // tender highlight UI
  return (
    <div className="list-group list-group-flush p-1">
      <div className="d-flex justify-content-between align-items-center mb-4">
        <h6 className="text-heading m-0">
          <i className="bi bi-stickies text-accent me-1"></i> Public Tenders
        </h6>
        <Link className="icon-link icon-link-hover fs-15" to="/tenders">
          See More <i className="bi bi-arrow-right"></i>
        </Link>
      </div>

      {isLoading && (
        <div className="text-center bg-light py-5">
          <div className="spinner-border text-accent" role="status"></div>
          <p className="mt-2 text-secondary">Loading tenders...</p>
        </div>
      )}

      {isError && (
        <div className="text-center text-danger bg-light py-5">
          <i className="bi bi-exclamation-triangle me-2"></i>
          {message || "Failed to load tender data."}
        </div>
      )}

      {!isLoading && isSuccess && tendersList.length === 0 && (
        <div className="text-center bg-light py-5">
          <i className="bi bi-info-circle me-2"></i>
          No tenders available at the moment. Please check back later.
        </div>
      )}

      {tendersList.slice(0, 3).map((tender, index) => {
        const today = new Date();
        const closeDate = new Date(tender.closeDate);
        const isClosed = closeDate < today;

        return (
          <li key={index} className="list-group-item d-flex justify-content-between align-items-center px-3 py-2 bg-light">
            <div className="w-100">
              <span className={`badge fw-normal border-0 mb-1 ${isClosed ? 'bg-danger' : 'bg-success'}`}>
                {isClosed ? 'Closed' : 'Open'}
              </span>
              <div className="d-flex justify-content-between align-items-center">
                <h6 className="text-heading-secondary fw-semibold mb-0">{tender.tenderNum}</h6>
                <Link to={tender.link} className="ms-3 fs-18" title="View Tender Details" target="_blank" rel="noopener noreferrer">
                  <i className="bi bi-arrow-up-right-square"></i>
                </Link>
              </div>
              <p className="text-secondary fs-14 mt-1 mb-3"> {tender.tenderTitle} </p>
              <div className="d-flex justify-content-between">
                <small className="text-secondary">
                  <i className="bi bi-bank2 me-1"></i> {tender.tenderer}
                </small>
                <small className="text-secondary">
                  <i className="bi bi-clock me-1"></i> {returnDate(tender.postedAt)}
                </small>
              </div>
            </div>
          </li>
        );
      })}
    </div>
  );
};

export default VacancyHighlights;