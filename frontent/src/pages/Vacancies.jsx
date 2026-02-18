import { Link } from "react-router-dom";
import React, { useState, useEffect } from "react";
import { useDispatch, useSelector  } from 'react-redux';

import { getVacancies } from "../features/vacanciesSlice";
import {  formatTableDate, returnDate } from "../utils/dateUtils";


const Vacancies = () => {

  const dispatch = useDispatch();
  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

  const { vacancies, isLoading, deleteLoading, isSuccess, deleteSuccess, isError, deleteError } = useSelector((state) => state.vacancies);

  const [vacanciesList, setVacanciesList] = useState([]);
  const [search, setSearch] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [vacanciesPerPage, setvacanciesPerPage] = useState(5);
  const [selectedvacancy, setSelectedvacancy] = useState([]);


  // get vacancies list when this page/component mount
  useEffect(() => {
    dispatch(getVacancies());
  }, [dispatch]);

  
  // after fetching vacancies successfully assign fetched vacancies list to the vacancieslist array
  useEffect(() => {
    if (isSuccess) {
      setVacanciesList(vacancies);
    }
    if (isError) {
      toast.error("Failed to fetch vacancies updates.");
    }
  }, [vacancies, isSuccess, isError]);


  // Search + Filter
  const filteredData = vacanciesList.filter((item) =>
    [item.vacancyNum, item.vacancyTitle, item.vacancyer, item.postedBy]
      .join(" ")
      .toLowerCase()
      .includes(search.toLowerCase())
  );

  const totalItems = filteredData.length;
  const totalPages = Math.ceil(totalItems / vacanciesPerPage);
  const startItem = (currentPage - 1) * vacanciesPerPage + 1;
  const endItem = Math.min(currentPage * vacanciesPerPage, totalItems);
  const currentItems = filteredData.slice(startItem - 1, endItem);

  const handlePageChange = (pageNumber) => {
    if (pageNumber >= 1 && pageNumber <= totalPages) {
      setCurrentPage(pageNumber);
    }
  };


  // vacancies pagination
  const renderPagination = () => {
    return Array.from({ length: totalPages }, (_, i) => i + 1).map((page) => (
      <li key={page} className={`page-item ${currentPage === page ? "active" : ""}`} >
        <button className="page-link btn-sm" onClick={() => handlePageChange(page)} >
          {page}
        </button>
      </li>
    ));
  };

  // vacancy display UI
  return (
    <>
      <div className='position-relative'>

        {/* Page banner */}
        <div className='page-banner'>
          <div className='container d-flex flex-column justify-content-center' style={{ height: '200px' }}>
            <h2 className='text-white fw-bold mb-4 w-75'>Let's shape the Future of Justice together, Be part of our Team in Delivering Justice for all.</h2>
            <nav  aria-label='breadcrumb'>
              <ol className='breadcrumb'>
                  <li className='breadcrumb-item'><Link to='/'>Home</Link></li>
                  <li className='breadcrumb-item active' aria-current='page'>Vacancies</li>
              </ol>
            </nav> 
          </div> 
        </div>

        {/* Search Bar */}
        <div className="position-absolute top-100 start-50 translate-middle bg-white shadow-sm rounded-1 p-3" style={{ width: '60%'}}>
          <div className="position-relative mx-3 my-2">
            <input type="text" className="form-control rounded-1 pe-5" placeholder="Search Vacancy ..." value={search} onChange={(e) => setSearch(e.target.value)} />
            <i className="bi bi-search position-absolute text-accent" style={{ top: '50%', right: '1rem', transform: 'translateY(-50%)', pointerEvents: 'none'}}></i>
          </div>
        </div>

      </div>

      {/* vacancies Display */}
      <div className="container px-0 py-5 my-5">
        <div className="row">
          <div className="col-lg-12 col-md-12">
            <div className="d-flex justify-content-between align-items-center px-2 mb-3 flex-wrap">
              <h4 className='fw-bold text-accent' data-aos="fade-right" data-aos-duration="1500"> <i className="bi bi-award bi text-heading-secondary me-1"></i> Job Vacancies </h4> 
              <div className="d-flex align-items-center" data-aos="fade-left" data-aos-duration="1500">
                <span className="me-2">Show</span>
                <select className="form-select form-select" value={vacanciesPerPage} onChange={(e) => { setvacanciesPerPage(Number(e.target.value)); setCurrentPage(1); }} >
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
                        <th style={{ width: "37%" }}><h6 className="text-heading fw-semibold">Vacancy Title</h6></th>
                        <th style={{ width: "10%" }}><h6 className="text-heading fw-semibold">Positions</h6></th>
                        <th style={{ width: "10%" }}><h6 className="text-heading fw-semibold">Open</h6></th>
                        <th style={{ width: "10%" }}><h6 className="text-heading fw-semibold">Close</h6></th>
                        <th style={{ width: "15%" }}><h6 className="text-heading fw-semibold">Posted On</h6></th>
                        <th style={{ width: "10%" }}><h6 className="text-heading fw-semibold">Status</h6></th>
                        <th style={{ width: "5%" }} className="text-end"></th>
                      </tr>
                    </thead>
                    <tbody>
                      {currentItems.map((item, index) => {
                        
                        const today = new Date();
                        const closeDate = new Date(item.closeDate);
                        const isClosed = closeDate < today;

                        return (
                          <tr key={item.vacancyID || index}>
                            <td><i className="bi bi-file-earmark-pdf text-accent fs-20"></i></td>
                            <td>{item.vacancyTitle}</td>
                            <td>{item.vacantPositions}</td>
                            <td>{returnDate(item.openDate)}</td>
                            <td>{returnDate(item.closeDate)}</td>
                            <td>{returnDate(item.postedAt)}</td>
                            <td>
                              <span className={`badge ${isClosed ? 'bg-danger' : 'bg-success'}`}>
                                {isClosed ? 'Closed' : 'Open'}
                              </span>
                            </td>
                            <td className="text-end">
                              <Link to={`${item.link}`} className="btn btn-sm btn-outline-danger me-1" title="View vacancy Details" target="_blank" rel="noopener noreferrer">
                                <i className="bi bi-arrow-up-right"></i>
                              </Link>
                            </td>
                          </tr>
                        );
                      })}
                      
                      {currentItems.length === 0 && (
                        <tr>
                          <td colSpan="8" className="text-center py-3">
                            No job vacancies are available at the moment. Please visit again soon.
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

export default Vacancies