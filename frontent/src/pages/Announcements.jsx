import { Link } from "react-router-dom";
import React, { useState, useEffect } from "react";
import { useDispatch, useSelector } from 'react-redux';
import { toast } from 'react-toastify';

import { getAnnouncements} from "../features/announcementSlice";
import { formatTableDate, isRecent } from "../utils/dateUtils";


const Announcements = () => {

  const dispatch = useDispatch();
  
  const webUrl = import.meta.env.VITE_API_WEBURL;
  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;
  const iconsPath = webUrl + '/src/assets/icons';

  const { announcements, isLoading, isSuccess, isError } = useSelector((state) => state.announcements);

  const [announcementsList, setAnnouncementsList] = useState([]);
  const [search, setSearch] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [announcementsPerPage, setAnnouncementsPerPage] = useState(5);

  // Get announcements on mount
  useEffect(() => {
    dispatch(getAnnouncements());
  }, [dispatch]);


  // update announcementList array
  useEffect(() => {
    if (isSuccess) {
      setAnnouncementsList(announcements);
    }
    if (isError) {
      toast.error("Failed to fetch announcements.");
    }
  }, [announcements, isSuccess, isError]);


  // Search
  const filteredData = announcementsList.filter((item) =>
    item.announcementTitle.toLowerCase().includes(search.toLowerCase())
  );

  // Split filtered announcements into recent and older
  const recentAnnouncements = filteredData.filter(item => isRecent(item.postedAt));
  const olderAnnouncements = filteredData.filter(item => !isRecent(item.postedAt));


  const totalItems = filteredData.length;
  const totalPages = Math.ceil(totalItems / announcementsPerPage);
  const startItem = (currentPage - 1) * announcementsPerPage + 1;
  const endItem = Math.min(currentPage * announcementsPerPage, totalItems);
  const currentItems = filteredData.slice(startItem - 1, endItem);

  const handlePageChange = (pageNumber) => {
    if (pageNumber >= 1 && pageNumber <= totalPages) {
      setCurrentPage(pageNumber);
    }
  };

  // announcements pagination
  const renderPagination = () => {
    return Array.from({ length: totalPages }, (_, i) => i + 1).map((page) => (
      <li key={page} className={`page-item ${currentPage === page ? "active" : ""}`}>
        <button className="page-link btn-sm" onClick={() => handlePageChange(page)}>
          {page}
        </button>
      </li>
    ));
  };


  // announcements display UI
  return (
    <>
      {/* Page Banner */}
      <div className='position-relative'>
        <div className='page-banner'>
          <div className='container d-flex flex-column justify-content-center' style={{ height: '200px' }}>
            <h2 className='text-white fw-bold'>Announcements</h2>
            <nav aria-label='breadcrumb'>
              <ol className='breadcrumb'>
                <li className='breadcrumb-item'><Link to='/'>Home</Link></li>
                <li className='breadcrumb-item active' aria-current='page'>Announcements</li>
              </ol>
            </nav>
          </div>
        </div>

        {/* Search Bar */}
        <div className="position-absolute top-100 start-50 translate-middle bg-white shadow-sm rounded-1 p-3" style={{ width: '60%' }}>
          <div className="position-relative mx-3 my-2">
            <input type="text" className="form-control rounded-1 pe-5" placeholder="Search Announcement ..." value={search} onChange={(e) => setSearch(e.target.value)} />
            <i className="bi bi-search position-absolute text-accent" style={{ top: '50%', right: '1rem', transform: 'translateY(-50%)', pointerEvents: 'none'}}></i>
          </div>
        </div>
      </div>

      <div className="container px-0 py-5 my-5">
        <div className="row">
          <div className="col-lg-12 col-md-12">
            <div className="d-flex justify-content-between align-items-center px-2 mb-3 flex-wrap">
              <h4 className='fw-bold text-accent'>Published Announcements</h4>
              <div className="d-flex align-items-center">
                <span className="me-2">Show</span>
                <select className="form-select form-select" value={announcementsPerPage}
                  onChange={(e) => {
                    setAnnouncementsPerPage(Number(e.target.value));
                    setCurrentPage(1);
                  }}
                >
                  {[5, 10, 15].map((num) => (
                    <option key={num} value={num}>{num}</option>
                  ))}
                </select>
              </div>
            </div>

            {/* LOADING STATE */}
            {isLoading && (
              <ul className="p-0">
                {Array(5).fill(0).map((_, index) => (
                  <li key={index} className="list-group-item bg-white p-4 border-0 rounded-3 mb-3">
                    <div className="d-flex align-items-center gap-3">
                      <div className="placeholder-glow" style={{ width: '40px', height: '40px' }}>
                        <div className="placeholder rounded-5 w-100 h-100"></div>
                      </div>
                      <div className="flex-grow-1">
                        <div className="placeholder-glow">
                          <span className="placeholder col-6"></span>
                          <span className="placeholder col-9 mt-2"></span>
                        </div>
                      </div>
                    </div>
                  </li>
                ))}
              </ul>
            )}

            {/* ERROR STATE */}
            {isError && (
              <div className="alert alert-danger p-4 text-center" role="alert">
                Failed to load announcements. Please try again later.
              </div>
            )}

            {/* ANNOUNCEMENTS */}
            {!isLoading && !isError && (
              <>
                {/* Recent Announcements */}
                {recentAnnouncements.length > 0 && (
                  <>
                    <h6 className="text-secondary mx-1 mb-3" data-aos="fade-right" data-aos-duration="1500">Recent Announcements</h6>
                    <ul className="p-0" data-aos="fade-up" data-aos-duration="1500">
                      {recentAnnouncements.map((item, index) => (
                        <li key={item.announcementID || index} className="list-group-item bg-white py-3 px-4 border-0 rounded-3 mb-3">
                          <div className="d-flex align-items-center gap-3">
                            <div style={{ width: '40px' }}>
                              <img src={`${iconsPath}/announcement.png`} alt="icon" className="rounded-5 w-100" />
                            </div>
                            <div className="flex-grow-1">
                              <small className="text-accent">{formatTableDate(item.postedAt)}</small>
                              <h6 className="text-heading-secondary my-1">{item.announcementTitle}</h6>
                            </div>
                            <div>
                              <Link href={`${webMediaURL}/${item.announcementAttachmentPath}`} className="ms-3 fs-20" title="View PDF" target="_blank" rel="noopener noreferrer">
                                <i className="bi bi-arrow-up-right-square"></i>
                              </Link>
                            </div>
                          </div>
                        </li>
                      ))}
                    </ul>
                  </>
                )}

                {/* Older Announcements */}
                {olderAnnouncements.length > 0 && (
                  <>
                    <h6 className="text-secondary mx-1 mt-4 mb-3" data-aos="fade-right" data-aos-duration="1500">Older Announcements</h6>
                    <ul className="p-0" data-aos="fade-left" data-aos-duration="1500">
                      {olderAnnouncements.map((item, index) => (
                        <li key={item.announcementID || index} className="list-group-item bg-white py-3 px-4 border-0 rounded-3 mb-3">
                          <div className="d-flex align-items-center gap-3">
                            <div style={{ width: '40px' }}>
                              <img src={`${iconsPath}/announcement.png`} alt="icon" className="rounded-5 w-100" />
                            </div>
                            <div className="flex-grow-1">
                              <small className="text-accent">{formatTableDate(item.postedAt)}</small>
                              <h6 className="text-heading-secondary my-1">{item.announcementTitle}</h6>
                            </div>
                            <div>
                              <Link href={`${webMediaURL}/${item.announcementAttachmentPath}`} className="ms-3 fs-20" title="View PDF" target="_blank" rel="noopener noreferrer">
                                <i className="bi bi-arrow-up-right-square"></i>
                              </Link>
                            </div>
                          </div>
                        </li>
                      ))}
                    </ul>
                  </>
                )}

                {/* No Data */}
                {recentAnnouncements.length === 0 && olderAnnouncements.length === 0 && (
                  <ul className="p-0" data-aos="fade-up" data-aos-duration="1500">
                    <li className="list-group-item p-5 border-0 rounded-2 mb-2 bg-white">
                      <div className="text-center">
                        <h5 className="text-heading-secondary fw-semibold">No Announcements Found</h5>
                        <p className="text-secondary m-0">Try adjusting your search or check back later.</p>
                      </div>
                    </li>
                  </ul>
                )}

                {/* Pagination */}
                <nav className="d-flex justify-content-between align-items-center mt-5" data-aos="fade-up" data-aos-duration="1500">
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
              </>
            )}
  

          </div>
        </div>
      </div>
    </>
  );
};

export default Announcements;