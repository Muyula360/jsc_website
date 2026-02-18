import { Link } from "react-router-dom";
import React, { useState, useEffect } from "react";
import { useDispatch, useSelector  } from 'react-redux';

import { formatDate } from '../utils/dateUtils';
import { getNewsupdates } from "../features/newsUpdateSlice";


const NewsList = () => {

    const dispatch = useDispatch();
    
    const [newsData, setNewsData] = useState([]);

    
    const { newsupdates, isLoading, isSuccess, isError } = useSelector((state) => state.newsUpdates);

    // newsupdates page useeffect (when this components loads fetch news from API)
    useEffect(() => {

        dispatch( getNewsupdates() );
        
        if(isSuccess){
           setNewsData(newsupdates);
        }

    },[ dispatch, isSuccess ]);


    const rowsPerPage = 3; // Number of news per page
    const [currentPage, setCurrentPage] = useState(1);
    const [searchQuery, setSearchQuery] = useState(''); // Search query state

    const totalnewsData = newsData.length;
    const startItem = (currentPage - 1) * rowsPerPage + 1;
    const endItem = Math.min(currentPage * rowsPerPage, totalnewsData);

    // Filter newsData based on the search query
    const filterednewsData = newsData.filter(news => 
        news.newsTitle.toLowerCase().includes(searchQuery.toLowerCase()) ||
        news.postedBy.toLowerCase().includes(searchQuery.toLowerCase()) ||
        news.postedAt.toLowerCase().includes(searchQuery.toLowerCase())
    );


    const setupPagination = () => {
        const pageCount = Math.ceil(filterednewsData.length / rowsPerPage);
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


    const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;


    return (

        <div className="container mb-5">

        {/* Search Bar */}
        <div className="px-3 mb-3">
            <input type="text" className="form-control" placeholder="Search news ..." value={searchQuery} onChange={(e) => setSearchQuery(e.target.value)} />
        </div>

        <div className="card hover-border rounded-3  my-4">
            <div className="card-body px-4">
            
                {
                    filterednewsData.slice(startIndex, endIndex).map((news, index) => (
                     
                        <Link  key={ index } to={ `/newsupdates/${news.newsupdatesID}`} >
                        <div className="row bg-light gx-3 rounded-3 py-3 px-2 mb-2">
                            <div className="col-12 col-lg-4 col-md-5 col-xl-4">
                                <img src={ `${webMediaURL}/${news.coverPhotoPath}` } className="rounded-2" style={{ width:'100%', height:'130px', objectFit: 'cover' }} alt="News Cover Photo" />
                            </div>
                            <div className="col-12 col-lg-8 col-md-7 col-xl-8 d-flex align-content-between flex-wrap py-2">
                                <div>
                                    <h6 className="text-heading fs-16"> { news.newsTitle } </h6>
                                    <p className="text-heading-secondary fs-15">From: { news.worktStation }</p>
                                </div>

                                <div className="d-flex justify-content-between w-100">
                                    <small className="text-muted">By { news.postedBy }</small>
                                    <small className="text-muted"><i className="bi bi-clock"></i> { formatDate(news.postedAt) } </small>
                                </div>
                            </div>
                        </div>
                        </Link>
                        
                    ))

                }

            </div>
        </div>

        <nav aria-label="Page navigation example" className="container d-flex justify-content-center align-items-center">
            <ul className="pagination mb-0">
                <li className="page-item">
                    <button className="page-link btn-sm" onClick={() => setCurrentPage(currentPage - 1)} disabled={currentPage === 1} >
                        <i className="bi bi-chevron-double-left"></i> Prev
                    </button>
                </li>
                {setupPagination()}
                <li className="page-item">
                    <button className="page-link btn-sm" onClick={() => setCurrentPage(currentPage + 1)} disabled={currentPage === Math.ceil(filterednewsData.length / rowsPerPage)} >
                        Next <i className="bi bi-chevron-double-right"></i>
                    </button>
                </li>
            </ul>
        </nav>
           
        </div>
    );

}

export default NewsList