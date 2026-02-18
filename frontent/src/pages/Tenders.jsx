import { Link } from "react-router-dom";
import React, { useState, useEffect } from "react";
import { useDispatch, useSelector  } from 'react-redux';

import { getTenders } from "../features/tenderSlice";
import {  formatTableDate, returnDate } from "../utils/dateUtils";


const Tenders = () => {

  const dispatch = useDispatch();
  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

  const { tenders, isLoading, deleteLoading, isSuccess, deleteSuccess, isError, deleteError } = useSelector((state) => state.tenders);

  const [tendersList, setTendersList] = useState([]);
  const [search, setSearch] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [tendersPerPage, setTendersPerPage] = useState(5);
  const [selectedTender, setSelectedTender] = useState([]);


  // get tenders list when this page/component loads
  useEffect(() => {
    dispatch(getTenders());
  }, [dispatch]);

  
  // after fetching tenders successfully assign fetched tenders list to the tenderslist array
  useEffect(() => {
    if (isSuccess) {
      setTendersList(tenders);
    }
    if (isError) {
      toast.error("Failed to fetch tenders updates.");
    }
  }, [tenders, isSuccess, isError]);


  // Search + Filter
  const filteredData = tendersList.filter((item) =>
    [item.tenderNum, item.tenderTitle, item.tenderer, item.postedBy]
      .join(" ")
      .toLowerCase()
      .includes(search.toLowerCase())
  );

  const totalItems = filteredData.length;
  const totalPages = Math.ceil(totalItems / tendersPerPage);
  const startItem = (currentPage - 1) * tendersPerPage + 1;
  const endItem = Math.min(currentPage * tendersPerPage, totalItems);
  const currentItems = filteredData.slice(startItem - 1, endItem);

  const handlePageChange = (pageNumber) => {
    if (pageNumber >= 1 && pageNumber <= totalPages) {
      setCurrentPage(pageNumber);
    }
  };


  // tenders pagination
  const renderPagination = () => {
    return Array.from({ length: totalPages }, (_, i) => i + 1).map((page) => (
      <li key={page} className={`page-item ${currentPage === page ? "active" : ""}`} >
        <button className="page-link btn-sm" onClick={() => handlePageChange(page)} >
          {page}
        </button>
      </li>
    ));
  };

  // tender display UI
  return (
    <>
      <div className='position-relative'>

        {/* Page banner */}
        <div className='page-banner'>
          <div className='container d-flex flex-column justify-content-center' style={{ height: '200px' }}>
            <h2 className='text-white fw-bold'>Judiciary Tenders</h2>
            <nav  aria-label='breadcrumb'>
              <ol className='breadcrumb'>
                  <li className='breadcrumb-item'><Link to='/'>Home</Link></li>
                  <li className='breadcrumb-item active' aria-current='page'>Tenders</li>
              </ol>
            </nav> 
          </div> 
        </div>

        {/* Search Bar */}
        <div className="position-absolute top-100 start-50 translate-middle bg-white shadow-sm rounded-1 p-3" style={{ width: '60%'}}>
          <div className="position-relative mx-3 my-2">
            <input type="text" className="form-control rounded-1 pe-5" placeholder="Search Tender ..." value={search} onChange={(e) => setSearch(e.target.value)} />
            <i className="bi bi-search position-absolute text-accent" style={{ top: '50%', right: '1rem', transform: 'translateY(-50%)', pointerEvents: 'none'}}></i>
          </div>
        </div>

      </div>

      {/* Tenders Display */}
      <div className="container px-0 py-5 my-5">
        <div className="row">
          <div className="col-lg-12 col-md-12">
            <div className="d-flex justify-content-between align-items-center px-2 mb-3 flex-wrap">
              <h4 className='fw-bold text-accent' data-aos="fade-right" data-aos-duration="1500"> <i className="bi-stickies text-heading-secondary me-1"></i> Published Tenders </h4> 
              <div className="d-flex align-items-center" data-aos="fade-left" data-aos-duration="1500">
                <span className="me-2">Show</span>
                <select className="form-select form-select" value={tendersPerPage} onChange={(e) => { setTendersPerPage(Number(e.target.value)); setCurrentPage(1); }} >
                  {[5, 10, 15].map((num) => (
                    <option key={num} value={num}>
                      {num}
                    </option>
                  ))}
                </select>
              </div>
            </div>  

            <div className="card border-0 shadow-sm" data-aos="fade-up" data-aos-duration="1500">
              <div className="card-body py-4 px-3">
                <div className="table-responsive">
                  <table className="table table-hover align-middle">
                    <thead className="">
                      <tr>
                        <th style={{ width: "3%" }}><h6 className="text-heading fw-semibold text-center"><i className="bi bi-sort-up-alt fs-20"></i></h6></th>
                        <th style={{ width: "10%" }}><h6 className="text-heading fw-semibold">Tender No</h6></th>
                        <th style={{ width: "20%" }}><h6 className="text-heading fw-semibold">Tender Title</h6></th>
                        <th style={{ width: "13%" }}><h6 className="text-heading fw-semibold">Tenderer</h6></th>
                        <th style={{ width: "10%" }}><h6 className="text-heading fw-semibold">Open</h6></th>
                        <th style={{ width: "10%" }}><h6 className="text-heading fw-semibold">Close</h6></th>
                        <th style={{ width: "12%" }}><h6 className="text-heading fw-semibold">Posted On</h6></th>
                        <th style={{ width: "7%" }}><h6 className="text-heading fw-semibold">Status</h6></th>
                        <th style={{ width: "5%" }} className="text-end"></th>
                      </tr>
                    </thead>
                    <tbody>
                      {currentItems.map((item, index) => {
                        const today = new Date();
                        const closeDate = new Date(item.closeDate);
                        const isClosed = closeDate < today;

                        return (
                          <tr key={item.tenderID || index}>
                            <td><i className="bi bi-file-earmark-pdf text-accent fs-20"></i></td>
                            <td>{item.tenderNum}</td>
                            <td>{item.tenderTitle}</td>
                            <td>{item.tenderer}</td>
                            <td>{returnDate(item.openDate)}</td>
                            <td>{returnDate(item.closeDate)}</td>
                            <td>{returnDate(item.postedAt)}</td>
                            <td>
                              <span className={`badge ${isClosed ? 'bg-danger' : 'bg-success'}`}>
                                {isClosed ? 'Closed' : 'Open'}
                              </span>
                            </td>
                            <td className="text-end">
                              <Link to={`${item.link}`} className="btn btn-sm btn-outline-danger me-1" title="View Tender Details" target="_blank" rel="noopener noreferrer">
                                <i className="bi bi-arrow-up-right"></i>
                              </Link>
                            </td>
                          </tr>
                        );
                      })}
                      
                      {currentItems.length === 0 && (
                        <tr>
                          <td colSpan="9" className="text-center py-3">
                            No Tenders Updates Found.
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

        </div>  
      </div>
    </>
  )
}

export default Tenders