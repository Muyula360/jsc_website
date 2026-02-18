import React, { useState } from "react";
import { Link } from "react-router-dom";


import RoleForm from "../components/RolesForm";


const ContentsMgrRoles = () => {

  const [search, setSearch] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage, setItemsPerPage] = useState(5);
  const data = [
    {
      Serial: 11,
      description: "Oversees content creation and updates for the official website of the High Court of Tanzania - Dodoma.",
      level: "I",
      name: "Content Manager",
    },
    {
      Serial: 12,
      description: "Manages administrative access, security, and overall functionality of the official website for the High Court of Tanzania - Dar es Salaam.",
      level: "I",
      name: "Administrator",
    },
    {
      Serial: 13,
      description: "Ensures proper organization of legal documents and updates for the official website of the High Court of Tanzania - Arusha.",
      level: "II",
      name: "Content Manager",
    },
    {
      Serial: 14,
      description: "Oversees online judicial communications and supervises website accessibility for the High Court of Tanzania - Mwanza.",
      level: "II",
      name: "Administrator",
    },
    {
      Serial: 15,
      description: "Coordinates digital resources and ensures website optimization for the High Court of Tanzania - Mbeya.",
      level: "II",
      name: "Content Manager",
    },
];


  

  // Calculate total items
  const totalItems = data.length;

  // Filter data based on search query
  const filteredData = data.filter(
    (item) =>
      item.description.toLowerCase().includes(search.toLowerCase()) ||
      item.name.toLowerCase().includes(search.toLowerCase()) 
  );

  const startItem = (currentPage - 1) * itemsPerPage + 1;
  const endItem = Math.min(currentPage * itemsPerPage, filteredData.length);

  // Determine items for the current page
  const currentItems = filteredData.slice(startItem - 1, endItem);

  const totalPages = Math.ceil(filteredData.length / itemsPerPage);

  const handlePageChange = (pageNumber) => {
    if (pageNumber >= 1 && pageNumber <= totalPages) {
      setCurrentPage(pageNumber);
    }
  };

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

  return (
    <div className="container-fluid">
         <div className="d-flex justify-content-between align-items-center mb-3">
                   <h5><strong>Access Control & Roles</strong></h5>
                   <button type="button" className="btn btn-danger px-3 pe-4" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                   <i className="bi bi-plus"></i> Add Role
                   </button>
                   {/* modal starts         */} 
                   <div className="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel1" aria-hidden="true">
                     <RoleForm />
                   </div>
                   {/* modal ends */}
               </div>
      <div className="card">
        <div className="card-body">
        
          <div className="d-flex justify-content-between align-items-center mb-3">
            <input
              type="text"
              className="form-control me-2"
              style={{ width: "45%" }}
              placeholder="Search ..."
              value={search}
              onChange={(e) => setSearch(e.target.value)}
            />
            <div className="d-flex justify-content-between align-items-center">
              <span className="me-4">Items per page:</span>
              <select
                className="form-select form-control items-per-page-select"
                value={itemsPerPage}
                onChange={(e) => {
                  setItemsPerPage(Number(e.target.value));
                  setCurrentPage(1); // Reset to the first page
                }}
              >
                <option value={5}>5</option>
                <option value={10}>10</option>
                <option value={15}>15</option>
              </select>
            </div>
          </div>

          <div className="row">
            <div className="col-12">
              <div className="card p-0 px-2 mb-3">
                <table className="table table-hover table-responsive align-middle m-0">
                  <thead>
                    <tr>
                      <th width="3%" className="align-middle">Sn</th>
                      <th width="10%" className="align-middle">Role Name</th>
                      <th width="10%" className="align-middle">Role Level</th>
                      <th width="40%" className="align-middle">Description</th>    
                    </tr>
                  </thead>
                  <tbody>
                    {currentItems.map((item, index) => (
                      <tr key={index}>
                        <td>{item.Serial}</td>
                        <td>{item.name}</td>
                        <td>{item.level}</td>
                        <td>{item.description}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>

              <nav
                aria-label="Page navigation example"
                className="d-flex justify-content-between align-items-center mt-1"
              >
                <span>
                  Showing {startItem} - {endItem} of {filteredData.length} items
                </span>
                <ul className="pagination mb-0">
                  <li className="page-item">
                    <button
                      className="page-link btn-sm text-dark-emphasis"
                      onClick={() => handlePageChange(currentPage - 1)}
                      disabled={currentPage === 1}
                    >
                      <b>
                        <Icons.ChevronDoubleLeft /> Prev
                      </b>
                    </button>
                  </li>
                  {setupPagination()}
                  <li className="page-item">
                    <button
                      className="page-link btn-sm text-dark-emphasis"
                      onClick={() => handlePageChange(currentPage + 1)}
                      disabled={currentPage === totalPages}
                    >
                      <b>
                        Next <Icons.ChevronDoubleRight />
                      </b>
                    </button>
                  </li>
                </ul>
              </nav>
            </div>
          </div>
        </div>
      </div>
    </div>

    
  );
};

export default ContentsMgrRoles
