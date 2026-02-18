import React, { useState, useEffect } from "react";
import { Link } from 'react-router-dom';
import { useDispatch, useSelector } from "react-redux";

import { getJudges } from "../features/judgeSlice";
import { returnDate } from "../utils/dateUtils";

const JudgesOfHighCourt = () => {

  const dispatch = useDispatch();
  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

  const { judges, isLoading, isSuccess, isError } = useSelector((state) => state.judges);

  const [judgesList, setJudgesList] = useState([]);
  const [search, setSearch] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [judgesPerPage, setJudgesPerPage] = useState(4);
  const [selectedJudge, setSelectedJudge] = useState(null);

  // get judges when this component mounts
  useEffect(() => {
    dispatch(getJudges());
  }, [dispatch]);


  // when fetch judges is successfully assign fetched judges to judgesList array
  useEffect(() => {
    if (isSuccess && judges.length > 0) {
      setJudgesList(judges);
    }
  }, [isSuccess, judges]);


  // filtering & searching judge
  const filteredJudgesList = judgesList
    .filter((judge) => judge.category === "High Court")
    .filter(
      (judge) =>
        judge.designation.toLowerCase().includes(search.toLowerCase()) ||
        judge.name?.toLowerCase().includes(search.toLowerCase()) ||
        judge.prefix.toLowerCase().includes(search.toLowerCase())
  );


  // judges per page
  const totalPages = Math.ceil(filteredJudgesList.length / judgesPerPage);
  const startItem = (currentPage - 1) * judgesPerPage + 1;
  const endItem = Math.min(currentPage * judgesPerPage, filteredJudgesList.length);
  const currentItems = filteredJudgesList.slice(startItem - 1, endItem);

  const handlePageChange = (pageNumber) => {
    if (pageNumber >= 1 && pageNumber <= totalPages) {
      setCurrentPage(pageNumber);
    }
  };

  // judges pagination
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

  // handle judge click
  const handlejudgeClick = (judge) => {
    setSelectedJudge(judge);
  };

  // judges display UI
  return (
    <>
      {/* Page Banner */}
      <div className='position-relative'>

        {/* Page banner */}
        <div className='page-banner'>
          <div className='container d-flex flex-column justify-content-center' style={{ height: '200px' }}>
            <h2 className='text-white fw-bold'>Judges of High Court</h2>
            <nav  aria-label='breadcrumb'>
              <ol className='breadcrumb'>
                  <li className='breadcrumb-item'><Link to='/'>Home</Link></li>
                  <li className='breadcrumb-item active' aria-current='page'>Judges</li>
                  <li className='breadcrumb-item active' aria-current='page'>Judges of High Court</li>
              </ol>
            </nav> 
          </div> 
        </div>

        {/* Search Bar */}
        <div className="position-absolute top-100 start-50 translate-middle bg-white shadow-sm rounded-1 p-3" style={{ width: '60%'}}>
          <div className="position-relative mx-3 my-2">
            <input type="text" className="form-control rounded-1 pe-5" placeholder="Search Judge ..." value={search} onChange={(e) => setSearch(e.target.value)} />
            <i className="bi bi-search position-absolute text-accent" style={{ top: '50%', right: '1rem', transform: 'translateY(-50%)', pointerEvents: 'none'}}></i>
          </div>
        </div>

      </div>

      <div className="container my-5 py-5">

        {/* Status Handling */}
        {isLoading && (
          <div className="text-center py-5">
            <div className="spinner-border text-secondary" role="status">
              <span className="visually-hidden">Loading...</span>
            </div>
            <p className="text-muted mt-3">Fetching Judges of High Court...</p>
          </div>
        )}

        {isError && (
          <div className="alert alert-danger text-center py-4" role="alert">
            Failed to load Judges of High Court. Please try again later.
          </div>
        )}

        {!isLoading && !isError && filteredJudgesList.length === 0 && (
          <div className="text-center py-4 text-muted">
            <p>No Judges of High Court found.</p>
          </div>
        )}

        {/* judges */}
        {!isLoading && !isError && filteredJudgesList.length > 0 && (
          <>
            <div className='bg-transparent mb-3'>
              <div className="d-flex justify-content-between align-items-center px-2 mb-3 flex-wrap">
                <h4 className='fw-bold text-accent' data-aos="fade-right" data-aos-duration="1500"> <i className="bi bi-people-fill text-heading-secondary me-1"></i> Judges of High Court </h4> 
                <div className="d-flex align-items-center" data-aos="fade-left" data-aos-duration="1500">
                  <span className="me-2">Show</span>
                  <select className="form-select form-select" value={judgesPerPage} onChange={(e) => { setJudgesPerPage(Number(e.target.value)); setCurrentPage(1); }} >
                    {[4, 6, 8, 10, 12].map((num) => (
                      <option key={num} value={num}>
                        {num}
                      </option>
                    ))}
                  </select>
                </div>
              </div>  
              <div className="row g-4">
                {currentItems.map((judge, index) => (
                  <div key={index} className="col-xl-6 col-lg-6 col-md-6 col-sm-12" data-aos="fade-up" data-aos-duration="1500">
                    <div className="card border-0 shadow-sm p-3" data-bs-toggle="modal" data-bs-target="#judgePreview" onClick={() => handlejudgeClick(judge)} >
                      <div className="d-flex gap-4 align-items-start p-3">
                        <img src={judge.coverPhoto ? `${webMediaURL}/${judge.coverPhoto}` : "/userProfilePic.png"} className="img-fluid rounded-1" style={{ width: "110px", height: "110px", objectFit: "cover" }} alt="Profile"  />
                        <div className="w-100">
                          <h5 className="text-heading-secondary fw-semibold fs-18 mb-1">{ `${judge.prefix} ${judge.name}` }</h5>
                          <span className="text-secondary fs-14 fw-semibold">{ judge.designation }</span>
                          <hr className="border border-secondary border-1 opacity-25 w-25 my-3"/>
                          <div className="d-flex justify-content-between align-items-center mt-3">
                            <span className="text-secondary fs-14"> Serves as Judge of High Court since July 2022</span>
                            <button className="btn btn-outline-danger rounded-2 fs-14 py-1 px-2 fw-semibold"> <i className="bi bi-arrow-right"></i> </button>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </div>

            {/* Pagination */}
            <nav aria-label="Page navigation" className="d-flex justify-content-between align-items-center mt-5">
              <span>Showing {startItem} - {endItem} of {filteredJudgesList.length} judges</span>
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

        {/* Judge Preview Modal  */}
        <div className="modal fade" id="judgePreview" data-bs-backdrop="static" tabIndex="-1" aria-hidden="true">
          <div className="modal-dialog modal-lg col-8">
            <div className="modal-content rounded-0 p-3">
              <div className="modal-header border-0">
                <button type="button" className="btn-close" data-bs-dismiss="modal" onClick={() => setSelectedJudge(null)}></button>
              </div>
              <div className="modal-body p-0">
                {selectedJudge && (
                  <div className="d-flex gap-4 align-items-start p-3">
                    <img src={selectedJudge.coverPhoto ? `${webMediaURL}/${selectedJudge.coverPhoto}` : "/userProfilePic.png"} className="img-fluid rounded-1" style={{ width: "210px", height: "210px", objectFit: "cover" }} alt="Profile"  />
                    <div className="w-100">
                      <h4 className="text-heading-secondary fw-semibold mb-1">{ `${selectedJudge.prefix} ${selectedJudge.name}` }</h4>
                      <span className="text-secondary fs-15 fw-semibold">{ selectedJudge.designation }</span>                
                      <div className="bg-light p-3 mt-4 text-secondary">
                        <span>{ selectedJudge.bio }</span>
                      </div>
                    </div>
                  </div>
                )}
              </div>
            </div>
          </div>
        </div>

      </div>
    </>
  );
};



export default JudgesOfHighCourt