import { Link } from "react-router-dom";
import React, { useState, useEffect } from "react";
import { useDispatch, useSelector  } from 'react-redux';

import { getTenders } from "../features/tenderSlice";
import {  formatTableDate, returnDate } from "../utils/dateUtils";


const TenderList = () => {

    const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

    const dispatch = useDispatch();
    const { tenders, isLoading, isSuccess, isError, message } = useSelector( state => state.tenders );
    
    const [ tenderList, setTenderList ] = useState([]);
 

    // tender list page useeffect (when this components loads fetch tenders from API)
    useEffect(() => {

        dispatch( getTenders() );
        
        if(isSuccess){
           setTenderList(tenders);
        }

    },[ dispatch, isSuccess ]);

    const rowsPerPage = 3; // Number of tenders per page
    const [currentPage, setCurrentPage] = useState(1);
    const [searchQuery, setSearchQuery] = useState(''); // Search query state

    const totalTenders = tenderList.length;
    const startItem = (currentPage - 1) * rowsPerPage + 1;
    const endItem = Math.min(currentPage * rowsPerPage, totalTenders);

    // Filter tenders based on the search query
    const filteredTenders = tenderList.filter(tender => 
        tender.tenderNum.toLowerCase().includes(searchQuery.toLowerCase()) ||
        tender.tenderTitle.toLowerCase().includes(searchQuery.toLowerCase()) ||
        tender.tenderer.toLowerCase().includes(searchQuery.toLowerCase())
    );


    const setupPagination = () => {
        const pageCount = Math.ceil(filteredTenders.length / rowsPerPage);
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
            <input type="text" className="form-control " placeholder="Search tender ..." value={searchQuery} onChange={(e) => setSearchQuery(e.target.value)} />
        </div>

        <div className="card hover-border rounded-3">
            <div className="card-body px-4">
            
                {
                    filteredTenders.slice(startIndex, endIndex).map((tender, index) => (
                     
                        <div key={ index } className="row bg-light rounded-3 py-3 px-2 mb-2">
                            <div className="col-12 col-lg-3 col-md-2 col-xl-3">
                                <img src="/JOT LOGO 2.png" alt="" width={100} className='pt-0' />
                            </div>
                            <div className="col-12 col-lg-9 col-md-10 col-xl-9 px-4">
                                <Link> <h6 className='text-heading'>Tender No: <span> { tender.tenderNum } </span></h6> </Link>
                                <h6 className="text-danger fs-14 fw-semibold"> { tender.tenderer } </h6>
                                <p className="text-dark-emphasis">
                                    { tender.tenderTitle }
                                </p>                  
                                <div className="d-flex justify-content-between align-items-center">
                                    <small className='text-heading-secondary'><b>Invitation Date:</b> { returnDate(tender.openDate) } </small>
                                    <small className='text-heading-secondary'><b>Deadline:</b> { returnDate(tender.closeDate) } </small>
                                </div>
                            </div>
                        </div>
                        
                    ))

                }

            </div>
        </div>


        <nav aria-label="Page navigation example" className="d-flex justify-content-between align-items-center mt-3">
            <span>
                Showing {startItem} - {endItem} of {filteredTenders.length} items
            </span>
            <ul className="pagination mb-0">
                <li className="page-item">
                    <button className="page-link btn-sm" onClick={() => setCurrentPage(currentPage - 1)} disabled={currentPage === 1} >
                        <i className="bi bi-chevron-double-left"></i> Prev
                    </button>
                </li>
                {setupPagination()}
                <li className="page-item">
                    <button className="page-link btn-sm" onClick={() => setCurrentPage(currentPage + 1)} disabled={currentPage === Math.ceil(filteredTenders.length / rowsPerPage)} >
                        Next <i className="bi bi-chevron-double-right"></i>
                    </button>
                </li>
            </ul>
        </nav>

           
        </div>
    );
};

export default TenderList
