import React, { useState, useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";
import { formatTableDate, returnDate } from "../utils/dateUtils";
import { toast } from "react-toastify";


import { getVacancies, deleteVacancy, reset, deleteReset  } from "../features/vacanciesSlice";
import VacancyForm from "../components/VacancyForm";


const ContentsMgrVacancies = () => {

  const dispatch = useDispatch();
  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

  const { vacancies, isLoading, deleteLoading, isSuccess, deleteSuccess, isError, deleteError } = useSelector((state) => state.vacancies);

  const [vacanciesList, setVacanciesList] = useState([]);
  const [search, setSearch] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [vacanciesPerPage, setVacanciesPerPage] = useState(5);
  const [selectedVacancy, setSelectedVacancy] = useState([]);


  // get vacancies list when this page/component loads
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
    [item.worktStation, item.vacancyTitle, item.postedBy]
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

  
  // delete vacancy (when user clicks delete vacancy this function is invoked)
  const handleDelete = (id) => {
    dispatch(deleteVacancy(id))
      .unwrap()
      .then(() => toast.success("Vacancy deleted successfully"))
      .catch(() => toast.error("Failed to delete vacancies post"));
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


  // Vacancy&Updates UI
  return (
    <div className="container-fluid py-3">
      <div className="d-flex justify-content-between align-items-center mb-4">
        <h5 className="m-0">
          <i className="bi bi-list-stars me-2"></i> Vacancies
        </h5>
        <button type="button" className='btn btn-accent rounded-1' data-bs-toggle="modal" data-bs-target="#vacanciesUpdatesForm" >
          <i className="bi bi-pencil-fill me-1"></i> Post Vacancy
        </button>
      </div>


      {/* Vacancy&Updates Form Modal */}
      <div className="modal fade" id="vacanciesUpdatesForm" data-bs-backdrop="static" data-bs-keyboard="false" tabIndex="-1" aria-labelledby="vacanciesUpdatesFormLabel" aria-hidden="true" >
        <VacancyForm editingVacancy={ selectedVacancy.vacancyID ? selectedVacancy : null } />
      </div>


      {/* Vacancy&Updates Delete Alert Modal */}
      <div className="modal fade" id="deleteVacancyAlert" data-bs-backdrop="static" data-bs-keyboard="false" tabIndex="-1" aria-labelledby="deleteVacancyAlertLabel" aria-hidden="true">
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
                  <button type="button" className="btn btn-outline-danger btn-sm" disabled> <i className="bi bi-trash"></i> Delete Vacancy </button>
                  <button type="button" className="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal" onClick={() => { setSelectedVacancy([]); dispatch(deleteReset()); }}> <i className="bi bi-x"></i> Cancel </button>          
                </div>
              </>
            ) : deleteSuccess ? (
              <>
                <div className="modal-body bg-light text-center rounded-2 py-4 px-3">
                  <div className="d-flex flex-column justify-content-center align-items-center">
                    <i className="bi bi-check-circle-fill fs-1"></i>
                    <span className="">Vacancy deleted successfully!</span>
                  </div>
                </div>
                <div className="modal-footer border-0 px-0">
                  <button type="button" className="btn btn-outline-danger btn-sm" disabled> <i className="bi bi-trash"></i> Delete Vacancy </button>
                  <button type="button" className="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal" onClick={() => { setSelectedVacancy([]); dispatch(deleteReset()); }}> <i className="bi bi-x"></i> Cancel </button>          
                </div>
              </>
            ) : (
              <>
                <div className="modal-body bg-light text-center rounded-2 py-4 px-3">
                  <h6 className="text-heading fw-semibold mb-3">{ ` "${selectedVacancy.vacancyTitle}" ` }</h6>
                  <small className="text-danger">This vacancy post will be permanently removed. Do you want to proceed?</small>
                </div>
                <div className="modal-footer border-0 px-0">
                  <button type="button" className="btn btn-outline-danger btn-sm" onClick={() => handleDelete(selectedVacancy.vacancyID)}><i className="bi bi-trash"></i> Delete Vacancy </button>
                  <button type="button" className="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal" onClick={() => { setSelectedVacancy([]); dispatch(deleteReset()); }}> <i className="bi bi-x"></i> Cancel </button>          
                </div>
              </>
            )}

          </div>
        </div>
      </div>


      {/* Vacancy&Updates Display */}   
      <div className="card border-0 shadow-sm">
        <div className="card-body py-5 px-4">
          {/* Search & Filter */}
          <div className="d-flex justify-content-between align-items-center mb-3 flex-wrap">
            <input type="text" className="form-control w-50 rounded-1 fs-14 me-2" placeholder="Search Vacancy ..." value={search} onChange={(e) => setSearch(e.target.value)} />
            <div className="d-flex align-items-center">
              <span className="me-2">Show</span>
              <select className="form-select form-select-sm" value={vacanciesPerPage} onChange={(e) => { setVacanciesPerPage(Number(e.target.value)); setCurrentPage(1); }} >
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
                  <th style={{ width: "3%" }}><h6 className="text-heading fw-semibold text-center"><i className="bi bi-sort-up-alt fs-20"></i></h6></th>
                  <th style={{ width: "21%" }}><h6 className="text-heading fw-semibold">Vacancy Title</h6></th>
                  <th style={{ width: "10%" }}><h6 className="text-heading fw-semibold">Positions</h6></th>
                  <th style={{ width: "10%" }}><h6 className="text-heading fw-semibold">Open</h6></th>
                  <th style={{ width: "10%" }}><h6 className="text-heading fw-semibold">Close</h6></th>
                  <th style={{ width: "12%" }}><h6 className="text-heading fw-semibold">Posted By</h6></th>
                  <th style={{ width: "12%" }}><h6 className="text-heading fw-semibold">Posted On</h6></th>
                  <th style={{ width: "7%" }}><h6 className="text-heading fw-semibold">Status</h6></th>
                  <th style={{ width: "5%" }} className="text-end"></th>
                </tr>
              </thead>
              <tbody>
                {currentItems.map((item, index) => (
                  <tr key={item.vacancyID || index}>
                    <td><i className="bi bi-file-earmark-pdf text-accent fs-20"></i></td>
                    <td>{item.vacancyTitle}</td>
                    <td>{item.vacantPositions}</td>
                    <td>{returnDate(item.openDate)}</td>
                    <td>{returnDate(item.closeDate)}</td>
                    <td>{item.postedBy}</td>
                    <td>{formatTableDate(item.postedAt)}</td>
                    <td><span className="badge bg-success">Posted</span></td>
                    <td className="text-end">
                      <div className="btn-group">
                        <button className="btn btn-sm btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#vacanciesUpdatesForm" title="Edit" onClick={() => setSelectedVacancy(item)} >
                          <i className="bi bi-pencil"></i>
                        </button>
                        <button className="btn btn-sm btn-outline-danger" title="Delete" data-bs-toggle="modal" data-bs-target="#deleteVacancyAlert" onClick={() => setSelectedVacancy(item)} >
                          <i className="bi bi-trash"></i>
                        </button>
                      </div>
                    </td>
                  </tr>
                ))}
                {currentItems.length === 0 && (
                  <tr>
                    <td colSpan="9" className="text-center py-3">
                      No Vacancies updates found.
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

export default ContentsMgrVacancies
