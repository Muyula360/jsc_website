import { Link, useParams } from 'react-router-dom';
import React, { useState, useEffect } from "react";
import { useDispatch, useSelector } from 'react-redux';
import Slider from "react-slick";
import slugify from 'slugify';

import NewsHighlights from '../components/NewsHighlights';
import { returnDate } from '../utils/dateUtils';
import { getNewsupdates } from "../features/newsUpdateSlice";

const NewsUpdatesPreview = () => {
  const dispatch = useDispatch();
  const { id, slug } = useParams();   // grab both ID and slug
  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

  const { newsupdates, isLoading, isError } = useSelector((state) => state.newsUpdates);
  const [selectedNews, setSelectedNews] = useState(null);

  useEffect(() => {
    dispatch(getNewsupdates());
  }, [dispatch]);

  useEffect(() => {
    if (newsupdates && newsupdates.length > 0) {
      // find by ID (unique)
      const news = newsupdates.find(n => n.newsupdatesID === id);

      // optional: verify slug matches
      if (news && slugify(news.newsTitle) === slug) {
        setSelectedNews(news);
      } else {
        setSelectedNews(news); // still show by ID even if slug mismatch
      }
    }
  }, [newsupdates, id, slug]);

  const settings = {
    infinite: true,
    speed: 1000,
    slidesToShow: 1,
    slidesToScroll: 1,
    autoplay: true,
    autoplaySpeed: 5000,
  };

  return (
    <>
      {selectedNews ? (
        <>
          <div className='position-relative'>
            {/* Page banner */}
            <div className='page-banner'>
              <div className='container d-flex flex-column justify-content-center' style={{ height: '200px' }}>
                <h2 className='text-white fw-bold'>News & Updates</h2>
                <nav aria-label='breadcrumb'>
                  <ol className='breadcrumb'>
                    <li className='breadcrumb-item'><Link to='/'>Home</Link></li>
                    <li className='breadcrumb-item'><Link to='/newsupdates'>Latest News</Link></li>
                    <li className='breadcrumb-item active' aria-current='page'>News Preview</li>
                  </ol>
                </nav>
              </div>
            </div>

            {/* Title */}
            <div className="position-absolute top-100 start-50 translate-middle bg-white shadow-sm rounded-1 p-3" style={{ width: '60%' }}>
              <div className="px-3 py-2 text-center">
                <span className='text-secondary'>
                  <small className='me-1'>{selectedNews.postedBy}</small> | <small className='ms-1'>{returnDate(selectedNews.postedAt)}</small>
                </span>
                <h4 className="card-title heading-poppin text-dark-accent fw-bold mt-3">{selectedNews.newsTitle}</h4>
              </div>
            </div>
          </div>

          <div className="container px-0 py-5 my-5">
            {/* Pictures */}
            <div className='mb-3 position-relative'>
              <Slider {...settings}>
                {selectedNews.supportingPhotosPaths.map((supportingPhoto, index) => (
                  <div key={index}>
                    <div className="position-relative">
                      <img
                        src={`${webMediaURL}/${supportingPhoto}`}
                        className="card-img-top rounded-1"
                        style={{ height: '50dvh', objectFit: 'cover' }}
                        alt="News Picture"
                      />
                    </div>
                  </div>
                ))}
              </Slider>
            </div>

            {/* News body */}
            <div className="card border-0 shadow-sm rounded-0 mx-auto" style={{ marginTop: '-90px', maxWidth: '1050px', zIndex: 10, position: 'relative' }}>
              <div className="card-body py-4 px-5">
                <div className="text-justify" dangerouslySetInnerHTML={{ __html: selectedNews.newsDesc }} />
              </div>
            </div>
          </div>
        </>
      ) : isLoading ? (
        <div className="text-center py-5">Loading...</div>
      ) : isError ? (
        <div className="text-center py-5 text-danger">Error loading news.</div>
      ) : (
        <div className="text-center py-5 text-muted">News not found.</div>
      )}
    </>
  );
};

export default NewsUpdatesPreview;
