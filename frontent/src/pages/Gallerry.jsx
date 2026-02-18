import React, { useState, useEffect } from "react";
import { Link } from 'react-router-dom';
import { useDispatch, useSelector } from "react-redux";

import { getAlbums } from "../features/gallerySlice";
import { returnDate } from "../utils/dateUtils";

const Gallery = () => {
  const dispatch = useDispatch();
  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

  const { galleries, isLoading, isSuccess, isError } = useSelector((state) => state.gallery);

  const [galleryData, setGalleryData] = useState([]);
  const [search, setSearch] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage] = useState(6);
  const [selectedAlbum, setSelectedAlbum] = useState([]);

  // get gallery when this component mounts
  useEffect(() => {
    dispatch(getAlbums());
  }, [dispatch]);

  // when fetch gallery is successfully assign fetched gallery to gallerydata array
  useEffect(() => {
    if (isSuccess && galleries.length > 0) {
      setGalleryData(galleries);
    }
  }, [isSuccess, galleries]);

  // searching gallery
  const filteredGalleryData = galleryData.filter(
    (album) =>
      album.albumTitle.toLowerCase().includes(search.toLowerCase()) ||
      album.albumPhotoCount?.toString().includes(search) ||
      album.worktStation?.toLowerCase().includes(search.toLowerCase()) ||
      album.postedBy.toLowerCase().includes(search.toLowerCase())
  );

  // gallery per page
  const totalPages = Math.ceil(filteredGalleryData.length / itemsPerPage);
  const startItem = (currentPage - 1) * itemsPerPage + 1;
  const endItem = Math.min(currentPage * itemsPerPage, filteredGalleryData.length);
  const currentItems = filteredGalleryData.slice(startItem - 1, endItem);

  const handlePageChange = (pageNumber) => {
    if (pageNumber >= 1 && pageNumber <= totalPages) {
      setCurrentPage(pageNumber);
    }
  };

  // gallery pagination
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

  // handle album click
  const handleAlbumClick = (album) => {
    setSelectedAlbum(album);
  };

  // galley display UI
  return (
    <>
      {/* Page Banner */}
      <div className='position-relative'>

        {/* Page banner */}
        <div className='page-banner'>
          <div className='container d-flex flex-column justify-content-center' style={{ height: '200px' }}>
            <h2 className='text-white fw-bold'>Judiciary Gallery</h2>
            <nav  aria-label='breadcrumb'>
              <ol className='breadcrumb'>
                  <li className='breadcrumb-item'><Link to='/'>Home</Link></li>
                  <li className='breadcrumb-item active' aria-current='page'>Gallery</li>
              </ol>
            </nav> 
          </div> 
        </div>

        {/* Search Bar */}
        <div className="position-absolute top-100 start-50 translate-middle bg-white shadow-sm rounded-1 p-3" style={{ width: '60%'}}>
          <div className="px-3 py-4">
            <input type="text" className="form-control rounded-1" placeholder="Search Gallery ..." value={search} onChange={(e) => setSearch(e.target.value)} />
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
            <p className="text-muted mt-3">Fetching gallery albums...</p>
          </div>
        )}

        {isError && (
          <div className="alert alert-danger text-center py-4" role="alert">
            Failed to load gallery. Please try again later.
          </div>
        )}

        {!isLoading && !isError && filteredGalleryData.length === 0 && (
          <div className="text-center py-4 text-muted">
            <p>No albums found.</p>
          </div>
        )}

        {/* Albums */}
        {!isLoading && !isError && filteredGalleryData.length > 0 && (
          <>
            <div className='bg-transparent mb-3' data-aos="fade-up" data-aos-duration="1500">
              <div className="row g-4">
                {currentItems.map((album, index) => (
                  <Link key={index} className="col-xl-4 col-lg-4 col-md-6 col-sm-12 p-3" data-bs-toggle="modal" data-bs-target="#galleryPreview" onClick={() => handleAlbumClick(album)} >
                    <div className="position-relative">
                      <img src={`${webMediaURL}/${album.albumCoverPhotoPath}`} className="img-fluid w-100" style={{ height: "230px", objectFit: 'cover' }} alt="Album Cover" />
                      <div className="card border-0 shadow-sm rounded-0 w-75 position-absolute top-100 start-50 translate-middle p-3 mx-auto">
                        <span className="text-dark-accent text-center"><h6 className="">{ album.albumTitle }</h6></span>
                      </div>
                    </div>
                  </Link>
                ))}
              </div>
            </div>

            {/* Pagination */}
            <nav aria-label="Page navigation" className="d-flex justify-content-between align-items-center mt-5">
              <span>Showing {startItem} - {endItem} of {filteredGalleryData.length} Albums</span>
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

        {/* Gallery Modal Preview */}
        <div className="modal fade" id="galleryPreview" data-bs-backdrop="static" tabIndex="-1" aria-hidden="true">
          <div className="modal-dialog modal-lg col-8">
            <div className="modal-content rounded-0 p-3">
              <div className="modal-header border-0">
                <h4 className="modal-title heading-poppin text-dark-accent">Gallery Pictures</h4>
                <button type="button" className="btn-close" data-bs-dismiss="modal" onClick={() => setSelectedAlbum([])}></button>
              </div>
              <div className="modal-body">
                <div id="carouselExampleIndicators" className="carousel slide">
                  <div className="carousel-indicators">
                    {selectedAlbum?.albumPhotosPaths?.map((_, idx) => (
                      <button key={idx} type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to={idx} className={idx === 0 ? "active" : ""} aria-label={`Slide ${idx + 1}`}></button>
                    ))}
                  </div>
                  <div className="carousel-inner">
                    {selectedAlbum?.albumPhotosPaths?.map((photo, index) => (
                      <div key={index} className={`carousel-item ${index === 0 ? "active" : ""}`}>
                        <img src={`${webMediaURL}/${photo}`} className="d-block w-100" alt={`Photo ${index + 1}`} style={{ height: '80vh', objectFit: 'cover', objectPosition: 'center' }}/>
                        <div className="carousel-caption d-none d-md-block">
                          <h4>{ selectedAlbum.albumTitle }</h4>
                          <p>{ `Posted on ${returnDate(selectedAlbum.postedAt)}` }</p>
                        </div>
                      </div>
                    ))}
                  </div>
                  <button className="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                    <span className="carousel-control-prev-icon" aria-hidden="true"></span>
                  </button>
                  <button className="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                    <span className="carousel-control-next-icon" aria-hidden="true"></span>
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>
    </>
  );
};

export default Gallery;