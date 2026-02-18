import React, { useState, useEffect, useRef } from "react";
import { useDispatch, useSelector } from "react-redux";
import { formatTableDate } from "../utils/dateUtils";
import { toast } from "react-toastify";


import { getBillboardPosts, updateShowOnCarousel, deleteBillboardPost, reset, deleteReset } from "../features/billboardSlice";
import BillboardForm from "../components/BillboardForm";


const ContentsMgrBillboards = () => {

  const billboardModalRef = useRef(null);
  const dispatch = useDispatch();

  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

  const { billboards, isLoading, deleteLoading, isSuccess, deleteSuccess, isError, deleteError } = useSelector((state) => state.billboards);

  const [billboardPosts, setBillboardPosts] = useState([]);
  const [search, setSearch] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [postsPerPage, setPostsPerPage] = useState(5);
  const [selectedBillbordPost, setSelectedBillboardPost] = useState([]);


  // get billboard posts when this page/component loads
  useEffect(() => {
    dispatch(getBillboardPosts());
  }, [dispatch]);
  

  // after fetching news successfully assign fetched billboard posts to the billboardPosts array
  useEffect(() => {
    if (isSuccess) {
      setBillboardPosts(billboards);
    }
    if (isError) {
      toast.error("Failed to fetch news updates.");
    }
  }, [billboards, isSuccess, isError]);


  // effect to listen for the billboardForm hide event (when user cancel the form modal)
  useEffect(() => {

    const modalEl = billboardModalRef.current;

    const handleModalHidden = () => {
      setSelectedBillboardPost([]);
    };

    if (modalEl) {
      modalEl.addEventListener("hidden.bs.modal", handleModalHidden);
    }

    return () => {
      if (modalEl) {
        modalEl.removeEventListener("hidden.bs.modal", handleModalHidden);
      }
    };

  }, []);


  // handle switch change (When user toggle Display switch)
  const handleSwitchToggle = (item) => {

    const show = !item.showOnCarouselDisplay;

    dispatch(updateShowOnCarousel({ billboardID: item.billboardID, showOnCarouselDisplay: show  }))
    .unwrap()
    .then((res) => { toast.success(`Billboard "${item.billboardTitle}" display updated.`); dispatch(getBillboardPosts()); })
    .catch((err) => { toast.error(err || "Failed to update display setting."); });

  };


  // Search + Filter
  const filteredData = billboardPosts.filter((item) =>
    [item.worktStation, item.billboardTitle, item.postedBy]
      .join(" ")
      .toLowerCase()
      .includes(search.toLowerCase())
  );

  const totalItems = filteredData.length;
  const totalPages = Math.ceil(totalItems / postsPerPage);
  const startItem = (currentPage - 1) * postsPerPage + 1;
  const endItem = Math.min(currentPage * postsPerPage, totalItems);
  const currentItems = filteredData.slice(startItem - 1, endItem);

  const handlePageChange = (pageNumber) => {
    if (pageNumber >= 1 && pageNumber <= totalPages) {
      setCurrentPage(pageNumber);
    }
  };

  // delete billboard post (when user clicks delete post this function is invoked)
  const handleDelete = (id) => {
    dispatch(deleteBillboardPost(id))
      .unwrap()
      .then(() => toast.success("Billboard post deleted successfully"))
      .catch(() => toast.error("Failed to delete billboard post"));
  };

  // billboard posts pagination
  const renderPagination = () => {
    return Array.from({ length: totalPages }, (_, i) => i + 1).map((page) => (
      <li key={page} className={`page-item ${currentPage === page ? "active" : ""}`} >
        <button className="page-link btn-sm" onClick={() => handlePageChange(page)} >
          {page}
        </button>
      </li>
    ));
  };


  // Billboards Posts UI
  return (
    <div className="container-fluid py-3">
      <div className="d-flex justify-content-between align-items-center mb-4">
        <h5 className="m-0">
          <i className="bi bi-list-stars me-2"></i> Billboard Posts
        </h5>
        <button type="button" className='btn btn-accent rounded-1' data-bs-toggle="modal" data-bs-target="#billboardForm" >
          <i className="bi bi-pencil-fill me-1"></i> Billboard Post
        </button>
      </div>


      {/* Billboard Form Modal */}
      <div className="modal fade" id="billboardForm" data-bs-backdrop="static" data-bs-keyboard="false" tabIndex="-1" aria-labelledby="billboardFormLabel" aria-hidden="true" ref={billboardModalRef} >
        <BillboardForm editingBillboardPost={ selectedBillbordPost.billboardID ? selectedBillbordPost : null } />
      </div>


      {/* Billboard Delete Alert Modal */}
      <div className="modal fade" id="deleteBillboardPostAlert" data-bs-backdrop="static" data-bs-keyboard="false" tabIndex="-1" aria-labelledby="deleteBillboardPostAlertLabel" aria-hidden="true">
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
                  <button type="button" className="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal" onClick={() => { setSelectedBillboardPost([]); dispatch(deleteReset()); }}><i className="bi bi-x"></i> Cancel </button>          
                </div>
              </>
            ) : deleteSuccess ? (
              <>
                <div className="modal-body bg-light text-center rounded-2 py-4 px-3">
                  <div className="d-flex flex-column justify-content-center align-items-center">
                    <i className="bi bi-check-circle-fill fs-1"></i>
                    <span className="">Billboard post deleted successfully!</span>
                  </div>
                </div>
                <div className="modal-footer border-0 px-0">
                  <button type="button" className="btn btn-outline-danger btn-sm" disabled> <i className="bi bi-trash"></i> Delete News </button>
                  <button type="button" className="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal" onClick={() => { setSelectedBillboardPost([]); dispatch(deleteReset()); }}> <i className="bi bi-x"></i> Cancel </button>          
                </div>
              </>
            ) : (
              <>
                <div className="modal-body bg-light text-center rounded-2 py-4 px-3">
                  <h6 className="text-heading fw-semibold mb-3">{ ` "${selectedBillbordPost.billboardTitle}" ` }</h6>
                  <small className="text-danger">This billboard post will be permanently removed. Do you want to proceed?</small>
                </div>
                <div className="modal-footer border-0 px-0">
                  <button type="button" className="btn btn-outline-danger btn-sm" onClick={() => handleDelete(selectedBillbordPost.billboardID)}><i className="bi bi-trash"></i> Delete News </button>
                  <button type="button" className="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal" onClick={() => { setSelectedBillboardPost([]); dispatch(deleteReset()); }}> <i className="bi bi-x"></i> Cancel </button>          
                </div>
              </>
            )}

          </div>
        </div>
      </div>


      {/* Billboard Posts Display */}   
      <div className="card border-0 shadow-sm">
        <div className="card-body py-5 px-4">
          {/* Search & Filter */}
          <div className="d-flex justify-content-between align-items-center mb-3 flex-wrap">
            <input type="text" className="form-control w-50 rounded-1 fs-14 me-2" placeholder="Search Post ..." value={search} onChange={(e) => setSearch(e.target.value)} />
            <div className="d-flex align-items-center">
              <span className="me-2">Show</span>
              <select className="form-select form-select-sm" value={postsPerPage} onChange={(e) => { setPostsPerPage(Number(e.target.value)); setCurrentPage(1); }} >
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
                  <th style={{ width: "30%" }}><h6 className="text-heading fw-semibold">Post Title</h6></th>
                  <th style={{ width: "15%" }}><h6 className="text-heading fw-semibold">Posted By</h6></th>
                  <th style={{ width: "15%" }}><h6 className="text-heading fw-semibold">Station</h6></th>
                  <th style={{ width: "15%" }}><h6 className="text-heading fw-semibold">Posted On</h6></th>
                  <th style={{ width: "10%" }}><h6 className="text-center fw-semibold">Display</h6></th>
                  <th style={{ width: "5%" }} className="text-end"></th>
                </tr>
              </thead>
              <tbody>
                {currentItems.map((item, index) => (
                  <tr key={item.billboardID || index}>
                    <td> 
                      <img src={`${webMediaURL}/${item.billboardPhotoPath}`} className="rounded-1" style={{ width: "100%", height: "50px", objectFit: "cover" }}  alt="News Cover Photo" />
                    </td>
                    <td>{item.billboardTitle}</td>
                    <td>{item.postedBy}</td>
                    <td>{item.worktStation}</td>
                    <td>{formatTableDate(item.postedAt)}</td>
                    <td className="text-center">
                      <div className="form-check form-switch">
                        <input className="form-check-input switch-dark" type="checkbox" role="switch" id={`showOnCarouselSwitch-${item.billboardID}`} onChange={() => handleSwitchToggle(item)} checked={item.showOnCarouselDisplay}/>
                      </div>
                    </td>
                    <td className="text-end">
                      <div className="btn-group">
                        <button className="btn btn-sm btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#billboardForm" title="Edit" onClick={() => setSelectedBillboardPost(item)} >
                          <i className="bi bi-pencil"></i>
                        </button>
                        <button className="btn btn-sm btn-outline-danger" title="Delete" data-bs-toggle="modal" data-bs-target="#deleteBillboardPostAlert" onClick={() => setSelectedBillboardPost(item)} >
                          <i className="bi bi-trash"></i>
                        </button>
                      </div>
                    </td>
                  </tr>
                ))}
                {currentItems.length === 0 && (
                  <tr>
                    <td colSpan="7" className="text-center py-3">
                      No news updates found.
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


export default ContentsMgrBillboards