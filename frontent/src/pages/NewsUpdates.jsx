import AOS from 'aos';
import { Link } from "react-router-dom";
import React, { useState, useEffect } from "react";
import { useDispatch, useSelector  } from 'react-redux';

import { getNewsupdates } from "../features/newsUpdateSlice";
import {  formatDate, returnDate } from "../utils/dateUtils";


const NewsUpdates = () => {

  const dispatch = useDispatch();
  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

  const { newsupdates, isLoading, isSuccess, isError } = useSelector((state) => state.newsUpdates);

  const [newsList, setNewsList] = useState([]);
  const [search, setSearch] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [newsPerPage, setNewsPerPage] = useState(10);
  const [selectedNews, setSelectedNews] = useState([]);


  // get news updates list when this page/component loads
  useEffect(() => {
    dispatch(getNewsupdates());
  }, [dispatch]);


  // after fetching news updates successfully assign fetched news updates list to the newsList array
  useEffect(() => {
    if (isSuccess) {
      setNewsList(newsupdates);
    }
    if (isError) {
      toast.error("Failed to fetch news updates.");
    }
  }, [newsupdates, isSuccess, isError]);


  // Search + Filter
  const filteredData = newsList.filter((item) =>
    [item.newsNum, item.newsTitle, item.newsAuthor, item.postedBy]
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
            <h2 className='text-white fw-bold'>News & Updates</h2>
            <nav  aria-label='breadcrumb'>
              <ol className='breadcrumb'>
                  <li className='breadcrumb-item'><Link to='/'>Home</Link></li>
                  <li className='breadcrumb-item active' aria-current='page'>Latest News</li>
              </ol>
            </nav> 
          </div> 
        </div>

        {/* Search Bar */}
        <div className="position-absolute top-100 start-50 translate-middle bg-white shadow-sm rounded-1 p-3" style={{ width: '60%'}}>
          <div className="position-relative mx-3 my-2">
            <input type="text" className="form-control rounded-1 pe-5" placeholder="Search News ..." value={search} onChange={(e) => setSearch(e.target.value)} />
            <i className="bi bi-search position-absolute text-accent" style={{ top: '50%', right: '1rem', transform: 'translateY(-50%)', pointerEvents: 'none'}}></i>
          </div>
        </div>
      </div>

      {/* News Display */}
      <div className="container px-0 py-5 my-5">
        <div className="row">
          <div className="col-lg-12 col-md-12">
            <div className="d-flex justify-content-between align-items-center px-2 mb-3 flex-wrap">
              <h4 className='fw-bold text-accent' data-aos="fade-right" data-aos-duration="1500"> Latest News </h4> 
              <div className="d-flex align-items-center" data-aos="fade-up" data-aos-duration="1500">
                <span className="me-2">Show</span>
                <select className="form-select form-select border-0 shadow-sm" value={newsPerPage} onChange={(e) => { setNewsPerPage(Number(e.target.value)); setCurrentPage(1); }} >
                  {[5, 10, 15].map((num) => (
                    <option key={num} value={num}>
                      {num}
                    </option>
                  ))}
                </select>
              </div>
            </div> 

            {
              /* Top Three News */
              currentItems.length > 0 && (
                <div className="row">
                  <div className="col-lg-7 col-md-12 mb-4">
                    <div className="card border-0 shadow-sm h-100" data-aos="fade-up" data-aos-duration="1500">
                      <img src={ `${webMediaURL}/${ currentItems[0].coverPhotoPath }` } className="card-img-top" style={{ height: '40dvh', objectFit: 'cover', objectPosition:'top' }} alt="..." />
                      <div className="card-body px-4 py-3">
                        <small className='text-secondary'> { currentItems[0].postedBy } </small>
                        <h5 className="card-title text-heading my-3">{ currentItems[0].newsTitle }</h5>
                      </div>
                      <div className="card-footer border-0 bg-transparent d-flex justify-content-between px-4 pb-4">
                        <span className="text-secondary fs-13"> <i className="bi bi-clock text-accent me-1"></i> { formatDate( currentItems[0].postedAt ) }</span>
                        <Link className="icon-link icon-link-hover fs-14 fw-semibold" to={`/newsupdates/${currentItems[0].newsupdatesID}`} >Full Story <i className="bi bi-arrow-right"></i></Link>
                      </div>
                    </div>
                  </div>

                  <div className="col-lg-5 col-md-12 mb-4">
                    {currentItems.slice(1, 4).map((item, index) => (
                      <div key={index} className='mb-3' >
                        <div className="card border-0 shadow-sm p-3 w-100 h-100 d-flex flex-column justify-content-between" data-aos="fade-left" data-aos-duration="1500">
                          <div className='d-flex flex-row '>
                            <div className="w-50 pe-3 d-flex flex-column">
                              <small className='text-secondary fs-12'> { item.postedBy } </small>
                              <Link to={`/newsupdates/${item.newsupdatesID}`} className="text-decoration-none">
                                <h6 className="card-title text-heading fs-13 my-3">{ item.newsTitle }</h6>
                              </Link>
                            </div>
                            <div className='w-50'>
                              <img src={ `${webMediaURL}/${ item.coverPhotoPath }` } className="rounded-2" style={{ width: '100%', objectFit: 'cover', objectPosition:'top' }} alt="..." />
                            </div>
                          </div>
                          <div className="card-footer border-0 bg-transparent p-0">
                            <span className="text-secondary fs-12"> <i className="bi bi-clock text-accent me-1"></i> { returnDate( item.postedAt ) }</span>
                          </div>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              )
            }

            {
              /* More News Items */
              currentItems.length > 3 && (
                <div className='mt-5'>
                  <h4 className='fw-bold text-accent mb-4' data-aos="fade-up" data-aos-duration="1500"> More News </h4> 
                  <div className="row gx-4 gy-3">      
                    {currentItems.slice(4, currentItems.length).map((item, index) => (
                      <div key={index} className="col-lg-4 col-md-12">
                        <div className="card border-0 shadow-sm p-3 w-100 h-100 d-flex flex-column justify-content-between" data-aos="fade-left" data-aos-duration="1500">
                          <div className='d-flex flex-row '>
                            <div className="w-50 pe-3 d-flex flex-column justify-content-between">
                              <small className='text-secondary fs-12'> { item.postedBy } </small>
                              <h6 className="card-title text-heading fs-13 my-3">{ item.newsTitle }</h6>
                            </div>
                            <div className='w-50'>
                              <img src={ `${webMediaURL}/${ item.coverPhotoPath }` } className="rounded-2" style={{ width: '100%', objectFit: 'cover', objectPosition:'top' }} alt="..." />
                            </div>
                          </div>
                          <div className="card-footer border-0 bg-transparent p-0">
                            <span className="text-secondary fs-12"> <i className="bi bi-clock text-accent me-1"></i> { returnDate( item.postedAt ) }</span>
                          </div>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              )
            }

          </div>
        </div>  
      </div>
    </>
  )
}


export default NewsUpdates