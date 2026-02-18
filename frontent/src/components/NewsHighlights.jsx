import { Link } from 'react-router-dom';
import React, { useState, useEffect, useContext } from "react";
import { useDispatch, useSelector } from 'react-redux';
import { formatDate } from '../utils/dateUtils';
import { getNewsupdates } from "../features/newsUpdateSlice";
import slugify from 'slugify';
import { LanguageContext } from '../context/Language'; // Adjust path as needed

const NewsHighlights = () => {
  const dispatch = useDispatch();
  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

  const { language } = useContext(LanguageContext);

  // Translations (consistent with AnnouncementsHighlight pattern)
  const translations = {
    sw: {
      title: "Habari Mbalimbali",
      loading: "Inapakia ...",
      retrievingNews: "Inaleta habari mbalimbali",
      errorTitle: "Hitilafu 521",
      errorSubtitle: "Seva ya wavuti haifanyi kazi",
      errorMessage: "Tunapata shida kuunganisha na seva. Tafadhali jaribu tena baadaye.",
      noNews: "Hakuna habari mpya kwa sasa.",
      readMore: "Soma Zaidi",
      datePrefix: "Tarehe: ",
      checkBackLater: "Angalia tena baadaye kwa habari mpya."
    },
    en: {
      title: "News & Updates",
      loading: "Loading ...",
      retrievingNews: "Retrieving news and updates",
      errorTitle: "Error 521",
      errorSubtitle: "Web server is down",
      errorMessage: "We are having trouble connecting to the server. Please try again later.",
      noNews: "No news available at the moment.",
      readMore: "Read More",
      datePrefix: "Date: ",
      checkBackLater: "Check back later for new updates."
    }
  };

  // Use Swahili as fallback if language is missing or invalid
  const t = translations[language] || translations.sw;

  const { newsupdates, isLoading, isSuccess, isError, message } = useSelector((state) => state.newsUpdates);

  useEffect(() => {
    dispatch(getNewsupdates());
  }, [dispatch]);

  return (
    <>
      <h5 className='fw-bold text-center text-md-start mb-5 text-dark'>
        {t.title}
      </h5>

      <div>
        <div className="card-body">
          <div className="list-group list-group-flush">
            {isLoading ? (
              <div className="d-flex flex-column justify-content-center align-items-center py-5 bg-light rounded-2">
                <span
                  className="spinner-border spinner-border-sm"
                  style={{ width: '1.5rem', height: '1.5rem' }}
                ></span>
                <div className="text-center my-4">
                  <h6 className="text-heading">{t.loading}</h6>
                  <p className="text-heading-secondary fs-12">{t.retrievingNews}</p>
                </div>
              </div>
            ) : isSuccess ? (
              newsupdates && newsupdates.length > 0 ? (
                <div>
                  {newsupdates.slice(0, 5).map((news, index) => (
                    <div key={news.newsupdatesID || index} className="mb-2">
                      <Link 
                        className="card d-flex flex-row card-pane border-0" 
                        to={`/newsupdates/${news.newsupdatesID}/${slugify(news.newsTitle || '', { lower: true, strict: true })}`}
                      >
                        {news.coverPhotoPath ? (
                          <img 
                            src={`${webMediaURL}/${news.coverPhotoPath}`} 
                            className="card-img-left ps-2 pt-2" 
                            style={{ 
                              width: '30%', 
                              height: '12dvh', 
                              objectFit: 'cover', 
                              objectPosition: 'top',
                              borderRadius: '4px'
                            }} 
                            alt={news.newsTitle || 'News image'} 
                            onError={(e) => {
                              e.target.onerror = null;
                              e.target.src = 'https://via.placeholder.com/150x80?text=News+Image';
                            }}
                          />
                        ) : (
                          <div 
                            className="card-img-left ps-2 pt-2 d-flex align-items-center justify-content-center bg-light"
                            style={{ 
                              width: '30%', 
                              height: '12dvh',
                              borderRadius: '4px'
                            }}
                          >
                            <i className="bi bi-newspaper text-muted fs-3"></i>
                          </div>
                        )}
                        
                        <div className="card-body d-flex flex-column justify-content-between" style={{ width: '70%' }}>
                          <h6 
                            className="card-title text-heading fs-14 fw-semibold mb-1 news-lines" 
                            title={news.newsTitle}
                          >
                            {news.newsTitle}
                          </h6>

                          <div className="d-flex justify-content-between align-items-center mt-1">
                            <span className="text-danger fs-13">
                              <i className="bi bi-calendar me-1"></i>
                              {formatDate(news.postedAt)}
                            </span>
                          </div>
                        </div>
                      </Link>
                    </div>
                  ))}
                </div>
              ) : (
                <div className="text-center py-4">
                  <div className="bg-light rounded-circle d-inline-flex p-3 mb-3">
                    <i className="bi bi-newspaper text-muted fs-2"></i>
                  </div>
                  <p className="text-muted mb-2">{t.noNews}</p>
                  <small className="text-muted">{t.checkBackLater}</small>
                </div>
              )
            ) : (
                <div className="card-pane">
                     <div className="alert alert-info text-center border-0 w-100">
                      <div className="m-auto p-3 w-75 text-danger" style={{ backgroundColor: 'transparent' }}>
                        <h5 className="card-title fw-semibold">{t.errorTitle}</h5>
                        <h6 className="card-title fw-semibold mb-3">{t.errorSubtitle}</h6>
                        <p className="text-secondary fs-13">{t.errorMessage}</p>
                      </div>
                    </div>
                </div>
            )}
          </div>
        </div>
      </div>
    </>
  );
};

export default NewsHighlights;