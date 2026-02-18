import React, { useState, useEffect } from "react";
import { Link } from 'react-router-dom';
import { useDispatch, useSelector } from "react-redux";

import { getNewsletters } from "../features/newsLetterSlice";
import { returnDate } from "../utils/dateUtils";

const Newsletter = () => {

  const dispatch = useDispatch();
  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

  const { newsletters, isLoading, isSuccess, isError } = useSelector((state) => state.newsletters);

  const [newslettersList, setNewslettersList] = useState([]);
  const [search, setSearch] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [newslettersPerPage, setNewsletterPerPage] = useState(4);
  const [selectedNewsletter, setSelectedNewsletter] = useState(null);

  // get newsletters when this component mounts
  useEffect(() => {
    dispatch(getNewsletters());
  }, [dispatch]);

  // when fetch newsletters is successfully assign fetched newsletters to newslettersList array
  useEffect(() => {
    if (isSuccess && newsletters.length > 0) {
      setNewslettersList(newsletters);
    }
  }, [isSuccess, newsletters]);

  // searching newsletters
  const filteredNewslettersList = newslettersList.filter(
    (newsletter) =>
      newsletter.newsletterNo?.toString().includes(search) ||
      newsletter.newsletterYear?.toString().includes(search) ||
      newsletter.newsletterMonth?.toLowerCase().includes(search.toLowerCase()) ||
      newsletter.postedBy.toLowerCase().includes(search.toLowerCase())
  );

  // newsletters per page
  const totalPages = Math.ceil(filteredNewslettersList.length / newslettersPerPage);
  const startItem = (currentPage - 1) * newslettersPerPage + 1;
  const endItem = Math.min(currentPage * newslettersPerPage, filteredNewslettersList.length);
  const currentItems = filteredNewslettersList.slice(startItem - 1, endItem);

  const handlePageChange = (pageNumber) => {
    if (pageNumber >= 1 && pageNumber <= totalPages) {
      setCurrentPage(pageNumber);
    }
  };

  // newsletters pagination
  const setupPagination = () => {
    const pages = [];
    for (let i = 1; i <= totalPages; i++) {
      pages.push(
        <li className={`page-item ${currentPage === i ? "active" : ""}`} key={i}>
          <button className="page-link btn-sm" onClick={() => handlePageChange(i)}>
            {i}
          </button>
        </li>
      );
    }
    return pages;
  };


    // handle newsletter click
    const handleNewsletterClick = (newsletter) => {
        setSelectedNewsletter(newsletter);
    };



  // newsletters display UI
  return (
    <>
      {/* Page Banner */}
      <div className='position-relative'>

        {/* Page banner */}
        <div className='page-banner'>
          <div className='container d-flex flex-column justify-content-center' style={{ height: '200px' }}>
            <h2 className='text-white fw-bold'>Judiciary Newsletters</h2>
            <nav  aria-label='breadcrumb'>
              <ol className='breadcrumb'>
                  <li className='breadcrumb-item'><Link to='/'>Home</Link></li>
                  <li className='breadcrumb-item active' aria-current='page'>Newsletters</li>
              </ol>
            </nav> 
          </div> 
        </div>

        {/* Search Bar */}
        <div className="position-absolute top-100 start-50 translate-middle bg-white shadow-sm rounded-1 p-3" style={{ width: '60%'}}>
          <div className="position-relative mx-3 my-2">
            <input type="text" className="form-control rounded-1 pe-5" placeholder="Search Newsletters ..." value={search} onChange={(e) => setSearch(e.target.value)} />
            <i className="bi bi-search position-absolute text-accent" style={{ top: '50%', right: '1rem', transform: 'translateY(-50%)', pointerEvents: 'none'}}></i>
          </div>
        </div>

      </div>

      <div className="container my-5 py-5">

        <div className="d-flex justify-content-between align-items-center px-2 mb-3 flex-wrap">
            <h4 className='fw-bold text-accent' data-aos="fade-right" data-aos-duration="1500"> <i className="bi bi-folder2-open text-heading-secondary me-1"></i> Published Newsletters (Haki Bulletin) </h4> 
            <div className="d-flex align-items-center" data-aos="fade-left" data-aos-duration="1500">
            <span className="me-2">Show</span>
            <select className="form-select form-select" value={newslettersPerPage} onChange={(e) => { setNewsletterPerPage(Number(e.target.value)); setCurrentPage(1); }} >
                {[4, 8, 12].map((num) => (
                <option key={num} value={num}>
                    {num}
                </option>
                ))}
            </select>
            </div>
        </div>  

        {/* Status Handling */}
        {isLoading && (
          <div className="text-center py-5">
            <div className="spinner-border text-secondary" role="status">
              <span className="visually-hidden">Loading...</span>
            </div>
            <p className="text-muted mt-3">Fetching newsletters ...</p>
          </div>
        )}

        {isError && (
          <div className="alert alert-danger text-center py-4" role="alert">
            Failed to load newsletters. Please try again later.
          </div>
        )}

        {!isLoading && !isError && filteredNewslettersList.length === 0 && (
          <div className="text-center py-4 text-muted">
            <p>No newsletters found.</p>
          </div>
        )}

        {/* Newsletter */}
        {!isLoading && !isError && filteredNewslettersList.length > 0 && (
          <>
            <div className='bg-transparent mb-3' data-aos="fade-up" data-aos-duration="1500">
              <div className="row g-5">
                {currentItems.map((newsletter, index) => (
                  <Link key={index} className="col-xl-3 col-lg-3 col-md-6 col-sm-12 p-3" data-bs-toggle="modal" data-bs-target="#newsletterPreview" onClick={() => handleNewsletterClick(newsletter)} >
                    <div className="position-relative">
                      <img src={`${webMediaURL}/${newsletter.newsletterCoverPath}`} className="img-fluid w-100" style={{ height: "300px", objectFit: 'cover' }} alt="newsletter Cover" />
                      <div className="card border-0 shadow-sm rounded-0 w-75 position-absolute top-100 start-50 translate-middle py-2 px-3 mx-auto newsletter-card">
                        <span className="text-heading-secondary text-center"><h6 className="fw-bold">{ `Haki Bulletin No.${newsletter.newsletterNo}, ${newsletter.newsletterYear}` }</h6></span>
                      </div>
                    </div>
                  </Link>
                ))}
              </div>
            </div>

            {/* Pagination */}
            <nav aria-label="Page navigation" className="d-flex justify-content-between align-items-center mt-5">
              <span>Showing {startItem} - {endItem} of {filteredNewslettersList.length} newsletters</span>
              <ul className="pagination mb-0">
                <li className="page-item">
                  <button className="page-link btn-sm" onClick={() => setCurrentPage(currentPage - 1)} disabled={currentPage === 1} >
                    <i className="bi bi-chevron-double-left"></i> Prev
                  </button>
                </li>
                {setupPagination()}
                <li className="page-item">
                  <button className="page-link btn-sm" onClick={() => setCurrentPage(currentPage + 1)} disabled={currentPage === totalPages}>
                    Next <i className="bi bi-chevron-double-right"></i>
                  </button>
                </li>
              </ul>
            </nav>
          </>
        )}

        { /* newsletters Modal Preview */

            selectedNewsletter && (
            <div className="modal fade" id="newsletterPreview" data-bs-backdrop="static" tabIndex="-1" aria-labelledby="newsletterPreviewLabel" aria-hidden="true">
                <div className="modal-dialog modal-lg col-8">
                <div className="modal-content rounded-0 p-3">
                    <div className="modal-header border-0">
                    <h4 className="modal-title heading-poppin text-dark-accent">
                        Haki Bulletin No.{selectedNewsletter.newsletterNo}, {selectedNewsletter.newsletterYear}
                    </h4>
                    <button type="button" className="btn-close" data-bs-dismiss="modal" aria-label="Close" onClick={() => setSelectedNewsletter(null) }></button>
                    </div>
                    <div className="modal-body">
                    {selectedNewsletter.newsletterPath ? (
                        <iframe src={`${webMediaURL}/${selectedNewsletter.newsletterPath}`} title={`Haki Bulletin No.${selectedNewsletter.newsletterNo}`} width="100%" height="750px" frameBorder="0" />
                    ) : (
                        <div className="text-center py-5 text-muted">
                        <p>Newsletter file not available.</p>
                        </div>
                    )}
                    </div>
                </div>
                </div>
            </div>
        )}


      </div>
    </>
  );
};

export default Newsletter;
