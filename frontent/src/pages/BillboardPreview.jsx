import { Link } from 'react-router-dom';
import { useParams } from "react-router-dom";
import React, { useState, useEffect } from "react";
import { useDispatch, useSelector } from 'react-redux';
import Slider from "react-slick";


import NewsHighlights from '../components/NewsHighlights';
import { returnDate } from '../utils/dateUtils';
import {  getBillboardPosts} from "../features/billboardSlice";


const BillboardPreview = () => {
   
    const dispatch = useDispatch();
    
    const { billboardID } = useParams()
    const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;
     

    const { billboards, isLoading, isSuccess, isError } = useSelector((state) => state.billboards);

    const [ selectedBillboard, setSelectedBillboard ] = useState(null);


    useEffect(() => {
        dispatch( getBillboardPosts() );
    }, [dispatch]);


    useEffect(() => {
        if (billboards && billboards.length > 0) {
            const billboard = billboards.find( billboard => billboard.billboardID === billboardID );
            setSelectedBillboard(billboard);
        }
    }, [billboards, billboardID]);


    // Full Billboard Preview UI
    return (
        <>
        { selectedBillboard ? (
            <>
                <div className='position-relative'>  
                    {/* Page banner */}
                    <div className='page-banner'>
                        <div className='container d-flex flex-column justify-content-center' style={{ height: '200px' }}>
                            <h2 className='text-white fw-bold'>Billboard Post</h2>
                            <nav  aria-label='breadcrumb'>
                                <ol className='breadcrumb'>
                                    <li className='breadcrumb-item'><Link to='/'>Home</Link></li>
                                    <li className='breadcrumb-item active' aria-current='page'>Billboard Post</li>
                                </ol>
                            </nav> 
                        </div> 
                    </div>
            
                    {/* New Title */}
                    <div className="position-absolute top-100 start-50 translate-middle bg-white shadow-sm rounded-1 p-3" style={{ width: '60%'}}>
                        <div className="px-3 py-2 text-center">
                            <span className='text-secondary' data-aos="fade-up" data-aos-duration="1500">
                                <small className='me-1'> {selectedBillboard.postedBy}</small>  |  <small className='ms-1'>{returnDate(selectedBillboard.postedAt)}</small>
                            </span>
                            <h3 className="card-title heading-poppin text-dark-accent fw-bold mt-3" data-aos="fade-right" data-aos-duration="1500">{selectedBillboard.billboardTitle}</h3>  
                        </div>
                    </div>
                </div>
        
                <div className="container px-0 py-5 my-5">
                    {/* Billboard Pictures */}
                    <div className='mb-3 position-relative' data-aos="fade-up" data-aos-duration="1500">
                        <div className="position-relative">
                        <img src={`${webMediaURL}/${selectedBillboard.billboardPhotoPath}`} className="card-img-top rounded-1" style={{ height: '50dvh', objectFit: 'cover' }} alt="News Picture"/>
                        </div>
                    </div>

                    {/* Billboard Card */}
                    <div className="card border-0 shadow-sm rounded-0 mx-auto" data-aos="fade-up" data-aos-duration="1500" style={{ marginTop: '-90px', maxWidth: '1050px', zIndex: 10, position: 'relative' }}>
                        <div className="card-body py-4 px-5" >
                            <div className="text-justify" dangerouslySetInnerHTML={{ __html: selectedBillboard.billboardBody }}/>
                        </div>
                    </div>
                </div>

            </>
        ) : isLoading ? (
            <div className="text-center py-5">Loading...</div>
        ) : isError ? (
            <div className="text-center py-5 text-danger">Error loading news billboard image.</div>
        ) : (
            <div className="text-center py-5 text-muted">Billboard image not found.</div>
        )}
        </>
    )

}

export default BillboardPreview