import React, { useState, useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";
import { formatTableDate, returnDate } from "../utils/dateUtils";
import { toast } from "react-toastify";


import { getUsers, deleteUser, deleteReset } from "../features/userSlice";
import UserForm from "../components/UserForm";


const ContentsMgrUsers = () => {

  const dispatch = useDispatch();
  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

  const { users, isLoading, deleteLoading, isSuccess, deleteSuccess, isError, deleteError, message } = useSelector((state) => state.users);

  const [usersList, setUserList] = useState([]);
  const [search, setSearch] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [usersPerPage, setUserPerPage] = useState(5);
  const [selectedUser, setSelectedUser] = useState([]);


  // get users list when this page/component loads
  useEffect(() => {
    dispatch(getUsers());
  }, [dispatch]);

  
  // after fetching users successfully assign fetched users to the userslist array
  useEffect(() => {
    if (isSuccess) {
      setUserList(users);
    }
    if (isError) {
      toast.error("Failed to fetch users.");
    }
  }, [users, isSuccess, isError]);


  // Search + Filter
  const filteredData = usersList.filter((item) =>
    [item.userfname, item.userMidname, item.userSurname, item.userEmail, item.userRole, item.worktStation, item.userStatus]
      .join(" ")
      .toLowerCase()
      .includes(search.toLowerCase())
  );

  const totalItems = filteredData.length;
  const totalPages = Math.ceil(totalItems / usersPerPage);
  const startItem = (currentPage - 1) * usersPerPage + 1;
  const endItem = Math.min(currentPage * usersPerPage, totalItems);
  const currentItems = filteredData.slice(startItem - 1, endItem);

  const handlePageChange = (pageNumber) => {
    if (pageNumber >= 1 && pageNumber <= totalPages) {
      setCurrentPage(pageNumber);
    }
  };

  // delete User (when user clicks delete User this function is invoked)
  const handleDelete = (id) => {
    dispatch(deleteUser(id))
      .unwrap()
      .then(() => toast.success("User deleted successfully"))
      .catch(() => toast.error("Failed to delete user: " + selectedUser.userEmail));
  };

  // users pagination
  const renderPagination = () => {
    return Array.from({ length: totalPages }, (_, i) => i + 1).map((page) => (
      <li key={page} className={`page-item ${currentPage === page ? "active" : ""}`} >
        <button className="page-link btn-sm" onClick={() => handlePageChange(page)} >
          {page}
        </button>
      </li>
    ));
  };


  // users UI
  return (
    <div className="container-fluid py-3">
      <div className="d-flex justify-content-between align-items-center mb-4">
        <h5 className="m-0">
          <i className="bi bi-list-stars me-2"></i> System User
        </h5>
        <button type="button" className='btn btn-accent rounded-1' data-bs-toggle="modal" data-bs-target="#usersUpdatesForm" >
          <i className="bi bi-person-plus me-1"></i> Create User
        </button>
      </div>


      {/* User Form Modal */}
      <div className="modal fade" id="usersUpdatesForm" data-bs-backdrop="static" data-bs-keyboard="false" tabIndex="-1" aria-labelledby="usersUpdatesFormLabel" aria-hidden="true" >
        <UserForm editingUser={ selectedUser.userID ? selectedUser : null } />
      </div>


      {/* User Delete Alert Modal */}
      <div className="modal fade" id="deleteUserAlert" data-bs-backdrop="static" data-bs-keyboard="false" tabIndex="-1" aria-labelledby="deleteUserAlertLabel" aria-hidden="true">
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
                  <button type="button" className="btn btn-outline-danger btn-sm" disabled>
                    <i className="bi bi-trash"></i> Delete User
                  </button>
                  <button type="button" className="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal" onClick={() => { setSelectedUser([]); dispatch(deleteReset()); }}>
                    <i className="bi bi-x"></i> Cancel
                  </button>
                </div>
              </>
            ) : deleteSuccess ? (
              <>
                <div className="modal-body bg-light text-center rounded-2 py-4 px-3">
                  <div className="d-flex flex-column justify-content-center align-items-center">
                    <i className="bi bi-check-circle-fill fs-1 text-success"></i>
                    <span className="">User deleted successfully!</span>
                  </div>
                </div>
                <div className="modal-footer border-0 px-0">
                  <button type="button" className="btn btn-outline-danger btn-sm" disabled>
                    <i className="bi bi-trash"></i> Delete User
                  </button>
                  <button type="button" className="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal" onClick={() => { setSelectedUser([]); dispatch(deleteReset()); }}>
                    <i className="bi bi-x"></i> Cancel
                  </button>
                </div>
              </>
            ) : deleteError ? (
              <>
                <div className="modal-body bg-light text-center rounded-2 py-4 px-3">
                  <div className="d-flex flex-column justify-content-center align-items-center">
                    <i className="bi bi-x-circle-fill fs-1 text-danger"></i>
                    <span className="text-danger">Failed to delete user.</span>
                    <small className="text-muted">{message}</small>
                  </div>
                </div>
                <div className="modal-footer border-0 px-0">
                  <button type="button" className="btn btn-outline-danger btn-sm" disabled>
                    <i className="bi bi-trash"></i> Delete User
                  </button>
                  <button type="button" className="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal" onClick={() => { setSelectedUser([]); dispatch(deleteReset()); }}>
                    <i className="bi bi-x"></i> Cancel
                  </button>
                </div>
              </>
            ) : (
              <>
                <div className="modal-body bg-light text-center rounded-2 py-4 px-3">
                  <h6 className="text-heading fw-semibold mb-3">{` "${selectedUser.userEmail}" `}</h6>
                  <small className="text-danger">This user will be permanently removed. Do you want to proceed?</small>
                </div>
                <div className="modal-footer border-0 px-0">
                  <button type="button" className="btn btn-outline-danger btn-sm" onClick={() => handleDelete(selectedUser.userID)}>
                    <i className="bi bi-trash"></i> Delete User
                  </button>
                  <button type="button" className="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal" onClick={() => { setSelectedUser([]); dispatch(deleteReset()); }}>
                    <i className="bi bi-x"></i> Cancel
                  </button>
                </div>
              </>
            )}

          </div>
        </div>
      </div>


      {/* Users Display */}   
      <div className="card border-0 shadow-sm">
        <div className="card-body py-5 px-4">
          {/* Search & Filter */}
          <div className="d-flex justify-content-between align-items-center mb-3 flex-wrap">
            <input type="text" className="form-control w-50 rounded-1 fs-14 me-2" placeholder="Search User ..." value={search} onChange={(e) => setSearch(e.target.value)} />
            <div className="d-flex align-items-center">
              <span className="me-2">Show</span>
              <select className="form-select form-select-sm" value={usersPerPage} onChange={(e) => { setUserPerPage(Number(e.target.value)); setCurrentPage(1); }} >
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
                  <th style={{ width: "25%" }}><h6 className="text-heading fw-semibold">Fullname</h6></th>
                  <th style={{ width: "25%" }}><h6 className="text-heading fw-semibold">Email</h6></th>
                  <th style={{ width: "15%" }}><h6 className="text-heading fw-semibold">Work station</h6></th>
                  <th style={{ width: "10%" }}><h6 className="text-heading fw-semibold">Role</h6></th>
                  <th style={{ width: "7%" }}><h6 className="text-heading fw-semibold">Status</h6></th>
                  <th style={{ width: "10%" }}><h6 className="text-heading fw-semibold">Created Date</h6></th>
                  <th style={{ width: "5%" }} className="text-end"></th>
                </tr>
              </thead>
              <tbody>
                {currentItems.map((item, index) => (
                  <tr key={item.userID || index}>
                    <td><span className="fw-semibold">{index + 1}</span></td>
                    <td>{item.userfname} {item.userMidname} {item.userSurname}</td>
                    <td>{item.userEmail}</td>
                    <td>{item.worktStation}</td>
                    <td>{item.userRole}</td>
                    <td><span className="badge bg-success">{item.userStatus}</span></td>
                    <td>{formatTableDate(item.userCreatedAt)}</td>  
                    <td className="text-end">
                      <div className="btn-group">
                        <button className="btn btn-sm btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#usersUpdatesForm" title="Edit" onClick={() => setSelectedUser(item)} >
                          <i className="bi bi-pencil"></i>
                        </button>
                        <button className="btn btn-sm btn-outline-danger" title="Delete" data-bs-toggle="modal" data-bs-target="#deleteUserAlert" onClick={() => setSelectedUser(item)} >
                          <i className="bi bi-trash"></i>
                        </button>
                      </div>
                    </td>
                  </tr>
                ))}
                {currentItems.length === 0 && (
                  <tr>
                    <td colSpan="8" className="text-center py-3">
                      No users Updates Found.
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

export default ContentsMgrUsers
