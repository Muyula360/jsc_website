import { Link } from "react-router-dom";
import React, { useState, useEffect } from "react";
import { useDispatch, useSelector  } from 'react-redux';

import { getPublications } from "../features/publicationSlice";
import {  formatTableDate, returnDate } from "../utils/dateUtils";


const PublicForms = () => {

  const dispatch = useDispatch();
  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

  const { publications, isLoading, deleteLoading, isSuccess, deleteSuccess, isError, deleteError } = useSelector((state) => state.publications);

  const [publicationsList, getPublicationsList] = useState([]);
  const [search, setSearch] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [publicationsPerPage, setPublicationsPerPage] = useState(6);
  const [selectedPublication, setSelectedPublication] = useState(null);


  // get publication list when this page/component loads
  useEffect(() => {
    dispatch(getPublications());
  }, [dispatch]);

  
  // after fetching publications successfully assign fetched publications list to the publicationslist array
  useEffect(() => {
    if (isSuccess) {
      getPublicationsList(publications);
    }
    if (isError) {
      toast.error("Failed to fetch publications updates.");
    }
  }, [publications, isSuccess, isError]);


  // filtering & searching publication
  const filteredPublications = publicationsList
    .filter((publication) => publication.category === "Form")
    .filter(
      (publication) =>
        publication.title.toLowerCase().includes(search.toLowerCase())
  );


  const totalItems = filteredPublications.length;
  const totalPages = Math.ceil(totalItems / publicationsPerPage);
  const startItem = (currentPage - 1) * publicationsPerPage + 1;
  const endItem = Math.min(currentPage * publicationsPerPage, totalItems);
  const currentItems = filteredPublications.slice(startItem - 1, endItem);

  const handlePageChange = (pageNumber) => {
    if (pageNumber >= 1 && pageNumber <= totalPages) {
      setCurrentPage(pageNumber);
    }
  };


  // publications pagination
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


  // handle download publication
  const handleDownload = (publication) => {
    if (publication?.contentPath) {
      const fullPath = `${webMediaURL}/${publication.contentPath}`;
      window.open(fullPath, "_blank");
    }
  };


  // publications display UI
  return (
    <>
      <div className='position-relative'>

        {/* Page banner */}
        <div className='page-banner'>
          <div className='container d-flex flex-column justify-content-center' style={{ height: '200px' }}>
            <h2 className='text-white fw-bold'>Public Forms</h2>
            <nav  aria-label='breadcrumb'>
              <ol className='breadcrumb'>
                  <li className='breadcrumb-item'><Link to='/'>Home</Link></li>
                  <li className='breadcrumb-item active' aria-current='page'>Publication Forms</li>
              </ol>
            </nav> 
          </div> 
        </div>

        {/* Search Bar */}
        <div className="position-absolute top-100 start-50 translate-middle bg-white shadow-sm rounded-1 p-3" style={{ width: '60%'}}>
          <div className="position-relative mx-3 my-2">
            <input type="text" className="form-control rounded-1 pe-5" placeholder="Search Form ..." value={search} onChange={(e) => setSearch(e.target.value)} />
            <i className="bi bi-search position-absolute text-accent" style={{ top: '50%', right: '1rem', transform: 'translateY(-50%)', pointerEvents: 'none'}}></i>
          </div>
        </div>

      </div>

      {/* publications Display */}
      <div className="container px-0 py-5 my-5">    
        <div className="row">

          {/* publication menu */}
          <div className="col-lg-4 col-md-12 py-3 px-4">
            <div className="card border-0 p-4 rounded-1 shadow-sm">
              <h5 className="fw-semibold fs-20 text-dark-accent mb-4">Documents Category</h5>
              <ul className="publication-category-card list-group list-group list-group-flush">
                <Link to="/publicforms" className="list-group-item list-group-item-action active"> Public Forms </Link>
                <Link to="/publicreports" className="list-group-item list-group-item-action"> Reports </Link>
                <Link to="/guidelines" className="list-group-item list-group-item-action"> Guidelines </Link>
                <Link to="/laws&regulations" className="list-group-item list-group-item-action"> Laws & Regulations </Link>
                <Link to="/newsletter" className="list-group-item list-group-item-action"> Newsletter </Link>
              </ul>
            </div>
          </div>

          {/* publication content */}
          <div className="col-lg-8 col-md-12">

            {/* Status Handling */}
            {isLoading && (
              <div className="bg-white rounded-1 shadow-sm text-center my-3 py-5">
                <div className="spinner-border text-secondary" role="status">
                  <span className="visually-hidden">Loading...</span>
                </div>
                <p className="text-muted mt-3">Fetching Public Forms...</p>
              </div>
            )}
    
            {isError && (
              <div className="alert alert-danger rounded-1 text-center my-3 py-5" role="alert">
                Failed to load public forms. Please try again later.
              </div>
            )}
    
            {!isLoading && !isError && filteredPublications.length === 0 && (
              <div className="bg-white rounded-1 shadow-sm text-center my-3 py-5">
                <span className="text-muted">No public form found.</span>
              </div>
            )}
    
            {/* public forms */}
            {!isLoading && !isError && filteredPublications.length > 0 && (
              <div className="py-3">
                <div className='bg-transparent mb-3'>
                  <div className="d-flex justify-content-between align-items-center px-2 mb-3 flex-wrap">
                    <h5 className='fw-bold text-accent' data-aos="fade-right" data-aos-duration="1500"> <i className="bi bi-folder2-open text-heading-secondary me-1"></i> Public Forms </h5> 
                    <div className="d-flex align-items-center" data-aos="fade-left" data-aos-duration="1500">
                      <span className="me-2">Show</span>
                      <select className="form-select form-select-sm" value={publicationsPerPage} onChange={(e) => { setPublicationsPerPage(Number(e.target.value)); setCurrentPage(1); }} >
                        {[2, 4, 6, 8].map((num) => (
                          <option key={num} value={num}>
                            {num}
                          </option>
                        ))}
                      </select>
                    </div>
                  </div>

                  <div className="row g-4">
                    {currentItems.map((publication, index) => (
                      <div key={ index } className="col-lg-6 col-md-12 p-3" data-aos="fade-up" data-aos-duration="1500">
                        <div className="card border-0 p-3 rounded-1 shadow-sm">
                          <div className="card-body p-0 d-flex">
                            <span className="text-heading-secondary me-2"><i className="bi bi-file-earmark-text fs-42"></i></span>
                            <div className="p-1">
                              <h5 className="text-heading-secondary fs-16 fw-semibold">{ publication.title }</h5>
                              <div className="text-heading-secondary fs-13">{ `${returnDate(publication.createdAt)} - ${publication.category}` }</div>
                            </div>
                          </div>
                          <div className="">
                            <button className="btn-accent-outline w-50 fs-14 text-center rounded-1" onClick={() => handleDownload(publication)}> Get Form </button>
                          </div>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
    
                {/* Pagination */}
                <nav aria-label="Page navigation" className="d-flex justify-content-between align-items-center mt-5" data-aos="fade-right" data-aos-duration="1500">
                  <span>Showing {startItem} - {endItem} of {filteredPublications.length} Public Forms </span>
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
              </div>
            )}

          </div>
        </div>
      </div>

    </>
  )
}

export default PublicForms;
