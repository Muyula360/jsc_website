import React, { useState, useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";
import { formatTableDate } from "../utils/dateUtils";
import { toast } from "react-toastify";


import { getAlbums, deleteAlbum, reset, deleteReset } from "../features/gallerySlice";
import GalleryForm from "../components/GalleryForm";


const ContentsMgrGallery = () => {

  const dispatch = useDispatch();
  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

  const { galleries, isLoading, deleteLoading, isSuccess, deleteSuccess, isError, deleteError } = useSelector((state) => state.gallery);

  const [galleryList, setGallerylist] = useState([]);
  const [search, setSearch] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [galleriesPerPage, setGalleriesPerPage] = useState(5);
  const [selectedGallery, setSelectedGallery] = useState([]);


  // get galleries list when this page/component loads
  useEffect(() => {
    dispatch(getAlbums());
  }, [dispatch]);


  // after fetching galleries successfully assign fetched galleries list to the gallerieslist array
  useEffect(() => {
    if (isSuccess) {
      setGallerylist(galleries);
    }
    if (isError) {
      toast.error("Failed to fetch galleries updates.");
    }
  }, [galleries, isSuccess, isError]);


  // Search + Filter
  const filteredData = galleryList.filter((item) =>
    [item.worktStation, item.albumTitle, item.postedBy]
      .join(" ")
      .toLowerCase()
      .includes(search.toLowerCase())
  );

  const totalItems = filteredData.length;
  const totalPages = Math.ceil(totalItems / galleriesPerPage);
  const startItem = (currentPage - 1) * galleriesPerPage + 1;
  const endItem = Math.min(currentPage * galleriesPerPage, totalItems);
  const currentItems = filteredData.slice(startItem - 1, endItem);

  const handlePageChange = (pageNumber) => {
    if (pageNumber >= 1 && pageNumber <= totalPages) {
      setCurrentPage(pageNumber);
    }
  };

  // delete gallery album (when user clicks delete album this function is invoked)
  const handleDelete = (id) => {
    dispatch(deleteAlbum(id))
      .unwrap()
      .then(() => toast.success("Album deleted successfully"))
      .catch(() => toast.error("Failed to delete album"));
  };

  // gallery pagination
  const renderPagination = () => {
    return Array.from({ length: totalPages }, (_, i) => i + 1).map((page) => (
      <li key={page} className={`page-item ${currentPage === page ? "active" : ""}`} >
        <button className="page-link btn-sm" onClick={() => handlePageChange(page)} >
          {page}
        </button>
      </li>
    ));
  };


  // Gallery UI
  return (
    <div className="container-fluid py-3">
      <div className="d-flex justify-content-between align-items-center mb-4">
        <h5 className="m-0">
          <i className="bi bi-list-stars me-2"></i> Judiciary Gallery
        </h5>
        <button type="button" className='btn btn-accent rounded-1' data-bs-toggle="modal" data-bs-target="#galleryForm" >
          <i className="bi bi-pencil-fill me-1"></i> Post Album
        </button>
      </div>


      {/* Gallery Form Modal */}
      <div className="modal fade" id="galleryForm" data-bs-backdrop="static" data-bs-keyboard="false" tabIndex="-1" aria-labelledby="galleryFormLabel" aria-hidden="true" >
        <GalleryForm editingNews={ selectedGallery.galleryID ? selectedGallery : null } />
      </div>


      {/* Gallery Delete Alert Modal */}
      <div className="modal fade" id="deleteAlbumAlert" data-bs-backdrop="static" data-bs-keyboard="false" tabIndex="-1" aria-labelledby="deleteAlbumAlertLabel" aria-hidden="true">
        <div className="modal-dialog modal-dialog-centered">
          <div className="modal-content py-3 px-4">
            <div className="modal-header border-0">
              <h1 className="modal-title fs-5" id="exampleModalLabel"></h1>
            </div>
            
            {deleteLoading ? (
              <>
                <div className="modal-body bg-light text-center rounded-2 py-4 px-3">
                  <div className="d-flex flex-column justify-content-center align-items-center">
                    <span className='spinner-border spinner-border-sm mb-4' style={{ width: '2rem', height: '2rem' }}></span>
                    <span className="">Deleting ...</span>
                  </div>
                </div>
                <div className="modal-footer border-0 px-0">
                  <button type="button" className="btn btn-outline-danger btn-sm" disabled> <i className="bi bi-trash"></i> Delete News </button>
                  <button type="button" className="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal" onClick={() => { setSelectedGallery([]); dispatch(deleteReset()); }}><i className="bi bi-x"></i> Cancel </button>          
                </div>
              </>
            ) : deleteSuccess ? (
              <>
                <div className="modal-body bg-light text-center rounded-2 py-4 px-3">
                  <div className="d-flex flex-column justify-content-center align-items-center">
                    <i className="bi bi-check-circle-fill fs-1"></i>
                    <span className="">News deleted successfully!</span>
                  </div>
                </div>
                <div className="modal-footer border-0 px-0">
                  <button type="button" className="btn btn-outline-danger btn-sm" disabled> <i className="bi bi-trash"></i> Delete News </button>
                  <button type="button" className="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal" onClick={() => { setSelectedGallery([]); dispatch(deleteReset()); }}> <i className="bi bi-x"></i> Cancel </button>          
                </div>
              </>
            ) : (
              <>
                <div className="modal-body bg-light text-center rounded-2 py-4 px-3">
                  <h6 className="text-heading fw-semibold mb-3">{ ` "${selectedGallery.albumTitle}" ` }</h6>
                  <small className="text-danger">This gallery album will be permanently removed. Do you want to proceed?</small>
                </div>
                <div className="modal-footer border-0 px-0">
                  <button type="button" className="btn btn-outline-danger btn-sm" onClick={() => handleDelete(selectedGallery.galleryID)}><i className="bi bi-trash"></i> Delete Album </button>
                  <button type="button" className="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal" onClick={() => { setSelectedGallery([]); dispatch(deleteReset()); }}> <i className="bi bi-x"></i> Cancel </button>          
                </div>
              </>
            )}

          </div>
        </div>
      </div>


      {/* Gallery Display */}   
      <div className="card border-0 shadow-sm">
        <div className="card-body py-5 px-4">
          {/* Search & Filter */}
          <div className="d-flex justify-content-between align-items-center mb-3 flex-wrap">
            <input type="text" className="form-control w-50 rounded-1 fs-14 me-2" placeholder="Search Album ..." value={search} onChange={(e) => setSearch(e.target.value)} />
            <div className="d-flex align-items-center">
              <span className="me-2">Show</span>
              <select className="form-select form-select-sm" value={galleriesPerPage} onChange={(e) => { setGalleriesPerPage(Number(e.target.value)); setCurrentPage(1); }} >
                {[5, 10, 15].map((num) => (
                  <option key={num} value={num}>
                    {num}
                  </option>
                ))}
              </select>
            </div>
          </div>

          {/* Table */}
          <div className="table-responsive mt-4">
            <table className="table table-hover align-middle">
              <thead className="">
                <tr>
                  <th style={{ width: "10%" }}><h6 className="text-heading fw-semibold text-center"><i className="bi bi-sort-up-alt fs-20"></i></h6></th>
                  <th style={{ width: "25%" }}><h6 className="text-heading fw-semibold">Album Title</h6></th>
                  <th style={{ width: "15%" }}><h6 className="text-heading fw-semibold">Image Counts</h6></th>
                  <th style={{ width: "13%" }}><h6 className="text-heading fw-semibold">Posted By</h6></th>
                  <th style={{ width: "10%" }}><h6 className="text-heading fw-semibold">Station</h6></th>
                  <th style={{ width: "13%" }}><h6 className="text-heading fw-semibold">Posted On</h6></th>
                  <th style={{ width: "8%" }}><h6 className="text-heading fw-semibold">Status</h6></th>
                  <th style={{ width: "5%" }} className="text-end"></th>
                </tr>
              </thead>
              <tbody>
                {currentItems.map((item, index) => (
                  <tr key={item.galleryID || index}>
                    <td> 
                      <img src={`${webMediaURL}/${item.albumCoverPhotoPath}`} className="rounded-1" style={{ width: "100%", height: "50px", objectFit: "cover" }}  alt="News Cover Photo" />
                    </td>
                    <td>{item.albumTitle}</td>
                    <td>{item.albumPhotoCount}</td>
                    <td>{item.postedBy}</td>
                    <td>{item.worktStation}</td>
                    <td>{formatTableDate(item.postedAt)}</td>
                    <td><span className="badge bg-success">Posted</span></td>
                    <td className="text-end">
                      <div className="btn-group">
                        <button className="btn btn-sm btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#galleryForm" title="Edit" onClick={() => setSelectedGallery(item)} >
                          <i className="bi bi-pencil"></i>
                        </button>
                        <button className="btn btn-sm btn-outline-danger" title="Delete" data-bs-toggle="modal" data-bs-target="#deleteAlbumAlert" onClick={() => setSelectedGallery(item)} >
                          <i className="bi bi-trash"></i>
                        </button>
                      </div>
                    </td>
                  </tr>
                ))}
                {currentItems.length === 0 && (
                  <tr>
                    <td colSpan="8" className="text-center py-3">
                      No gallery albums updates found.
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
  );
};


export default ContentsMgrGallery
