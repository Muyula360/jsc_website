import { Link } from "react-router-dom";
import React, { useState, useEffect } from "react";
import { useDispatch, useSelector  } from 'react-redux';

import { getVacancies } from "../features/vacanciesSlice";
import {  formatTableDate, returnDate } from "../utils/dateUtils";


const VacanciesList = () => {

    const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

    const dispatch = useDispatch();
    const { vacancies, isLoading, isSuccess, isError, message } = useSelector( state => state.vacancies );
    
    const [ vacanciesList, setVacanciesList ] = useState([]);
 

    // vacancies list page useeffect (when this components loads fetch vacancies from API)
    useEffect(() => {

        dispatch( getVacancies() );
        
        if(isSuccess){
           setVacanciesList(vacancies);
        }

    },[ dispatch, isSuccess ]);

    const rowsPerPage = 4; // Number of Vacancies per page
    const [currentPage, setCurrentPage] = useState(1);
    const [searchQuery, setSearchQuery] = useState(''); // Search query state

    const totalVacancies = vacanciesList.length;
    const startItem = (currentPage - 1) * rowsPerPage + 1;
    const endItem = Math.min(currentPage * rowsPerPage, totalVacancies);

    // Filter Vacancies based on the search query
    const filteredVacancies = vacanciesList.filter(vacancy => 
        vacancy.vacantPositions?.toString().includes(searchQuery) ||
        vacancy.vacancyTitle.toLowerCase().includes(searchQuery.toLowerCase()) ||
        vacancy.vacancyDesc.toLowerCase().includes(searchQuery.toLowerCase()) ||
        vacancy.worktStation.toLowerCase().includes(searchQuery.toLowerCase())
    );


    const setupPagination = () => {
        const pageCount = Math.ceil(filteredVacancies.length / rowsPerPage);
        return Array.from({ length: pageCount }, (_, i) => (
            <li key={i + 1} className={`page-item ${i + 1 === currentPage ? 'active' : ''}`}>
                <button className="page-link btn-sm" onClick={() => setCurrentPage(i + 1)}>
                    {i + 1}
                </button>
            </li>
        ));
    };


    const startIndex = (currentPage - 1) * rowsPerPage;
    const endIndex = startIndex + rowsPerPage;


    return (

        <div className="container mb-5">

        {/* Search Bar */}
        <div className=" mb-3 px-3">
            <input type="text" className="form-control " placeholder="Search vacancy ..." value={searchQuery} onChange={(e) => setSearchQuery(e.target.value)} />
        </div>

        <div className="card hover-border rounded-3">
            <div className="card-body px-4">
            
                {
                    filteredVacancies.slice(startIndex, endIndex).map((vacancy, index) => (
                     
                        <div key={ index } className="bg-light rounded-3 mb-2">
                            <div className="p-4">
                                <div className="d-flex justify-content-between">
                                    <div className="w-75">
                                        <h6 className='text-heading fw-semibold mb-1'> { vacancy.vacancyTitle } </h6>
                                        <small className="text-heading-secondary fs-15"> Deadline for the application is { formatTableDate(vacancy.closeDate) } </small>
                                    </div>
                                    <div>
                                        <button className="btn btn-accent rounded-2">Apply now <i className="bi bi-arrow-up-right-square ms-1"></i></button>
                                    </div>
                                </div>

                                <div className="text-justify fs-14 my-3" dangerouslySetInnerHTML={{ __html: vacancy.vacancyDesc }} />
                
                                <div className="d-flex justify-content-between align-items-center">
                                    <small className='text-heading-secondary'><b>From </b> { vacancy.worktStation } </small>
                                    <small className='text-heading-secondary'><b>Posted On</b> { returnDate(vacancy.postedAt) } </small>                
                                </div>
                            </div>
                        </div>
                        
                    ))

                }

            </div>
        </div>


        <nav aria-label="Page navigation example" className="d-flex justify-content-between align-items-center mt-3">
            <span>
                Showing {startItem} - {endItem} of {filteredVacancies.length} items
            </span>
            <ul className="pagination mb-0">
                <li className="page-item">
                    <button className="page-link btn-sm" onClick={() => setCurrentPage(currentPage - 1)} disabled={currentPage === 1} >
                        <i className="bi bi-chevron-double-left"></i> Prev
                    </button>
                </li>
                {setupPagination()}
                <li className="page-item">
                    <button className="page-link btn-sm" onClick={() => setCurrentPage(currentPage + 1)} disabled={currentPage === Math.ceil(filteredVacancies.length / rowsPerPage)} >
                        Next <i className="bi bi-chevron-double-right"></i>
                    </button>
                </li>
            </ul>
        </nav>

           
        </div>
    );
};

export default VacanciesList