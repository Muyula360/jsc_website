import { Link } from "react-router-dom";
import React, { useState, useEffect } from "react";
import { useDispatch, useSelector  } from 'react-redux';

import { returnDate } from '../utils/dateUtils';
import { capitalize } from '../utils/stringManipulation';
import { getAnnouncements } from "../features/announcementSlice";


const Announcementlist = () => {

    const dispatch = useDispatch();
    
    const [newsData, setNewsData] = useState([]);
 
    const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

    const { announcements, isLoading, isSuccess, isError, message } = useSelector( state => state.announcements );


    // announcement list useeffect (when this components loads fetch from API)
    useEffect(() => {

        dispatch( getAnnouncements() );
        
        if(isSuccess){
           setNewsData(announcements);
        }

    },[ dispatch, isSuccess ]);


    
    // handle announcement click (when user clicks an annnouncement)
    const handleClick = (announcement) => {
        if (announcement.hasAttachment && announcement.attachmentPath) {
            const fullPath = `${webMediaURL}/${announcement.attachmentPath}`;
            window.open(fullPath, "_blank");
        }
    };


    const rowsPerPage = 5; // Number of announcements per page
    const [currentPage, setCurrentPage] = useState(1);
    const [searchQuery, setSearchQuery] = useState(''); // Search query state

    const totalAnnouncements = newsData.length;
    const startItem = (currentPage - 1) * rowsPerPage + 1;
    const endItem = Math.min(currentPage * rowsPerPage, totalAnnouncements);

    // Filter announcements based on the search query
    const filterednewsData = newsData.filter(announcement => 
        announcement.announcementTitle.toLowerCase().includes(searchQuery.toLowerCase()) ||
        announcement.postedAt.toLowerCase().includes(searchQuery.toLowerCase())
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


    return (

        <div className="container mb-5">

        {/* Search Bar */}
        <div className="px-3 mb-3">
            <input type="text" className="form-control" placeholder="Search announcement ..." value={searchQuery} onChange={(e) => setSearchQuery(e.target.value)} />
        </div>

        <div className="card hover-border rounded-3 my-4">
            <div className="card-body px-2">
            
                {
                    filterednewsData.slice(startIndex, endIndex).map((announcement, index) => (
                        <div className="col-12 my-2" key={index}>
                            <div className="d-flex bg-light rounded-2 p-3">
                                <div><i className="bi bi-bell-fill text-heading-secondary announcement-vibrating-bell"></i></div>
                                <div className="text-heading w-100 fs-14 mx-2"> <Link className="text-heading" onClick={() => handleClick(announcement)}>{ announcement.announcementTitle }</Link> </div>
                                <div className="text-heading-secondary text-center fs-12"><span>{ returnDate(announcement.postedAt) }</span></div>
                            </div>
                        </div>      
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

export default Announcementlist;
