import { Link } from 'react-router-dom';
import slugify from 'slugify';
import React, { useEffect, useState, useRef, useMemo, useCallback, useContext } from "react";
import { useDispatch, useSelector } from 'react-redux';
import { returnDate } from '../utils/dateUtils';
import { getNewsupdates } from "../features/newsUpdateSlice";
import { LanguageContext } from '../context/Language'; // adjust path as needed

const NewsUpdates = () => {
  const dispatch = useDispatch();
  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

  // Language context
  const { language } = useContext(LanguageContext);

  // Translations (Swahili is the default)
  const translations = {
    sw: {
      moreNews: "Habari Zaidi",
      latestNews: "Habari Mpya",
      loading: "Inapakia ...",
      retrievingNews: "Inaleta Habari",
      errorTitle: "Hitilafu 521",
      errorSubtitle: "Seva ya wavuti haifanyi kazi",
      errorMessage: "Tunapata shida kuunganisha na seva. Tafadhali jaribu tena baadaye.",
      noNews: "Hakuna Habari",
      checkLater: "Tafadhali angalia tena baadaye kwa masasisho.",
      postedBy: "Imewekwa na"
    },
    en: {
      moreNews: "More News",
      latestNews: "Latest News",
      loading: "Loading ...",
      retrievingNews: "Retrieving News",
      errorTitle: "Error 521",
      errorSubtitle: "Web server is down",
      errorMessage: "We are having trouble connecting to the server. Please try again later.",
      noNews: "No News Available",
      checkLater: "Please check back later for updates.",
      postedBy: "Posted By"
    }
  };

  // Use Swahili as fallback if language is missing or invalid
  const t = translations[language] || translations.sw;

  const { newsupdates, isLoading, isError } = useSelector(
    (state) => state.newsUpdates
  );

  const [itemsToShow, setItemsToShow] = useState(3);
  const [displayIndex, setDisplayIndex] = useState(1);
  const [isAnimating, setIsAnimating] = useState(false);
  const autoSlideRef = useRef(null);

  useEffect(() => { dispatch(getNewsupdates()); }, [dispatch]);

  // Responsive itemsToShow
  useEffect(() => {
    const updateItems = () => {
      if (window.innerWidth >= 992) setItemsToShow(3);
      else if (window.innerWidth >= 768) setItemsToShow(2);
      else setItemsToShow(1);
    };
    updateItems();
    window.addEventListener("resize", updateItems);
    return () => window.removeEventListener("resize", updateItems);
  }, []);

  // Fixed card width (keeps layout stable)
  const cardWidth = useMemo(() => {
    if (itemsToShow === 3) return 373;   // desktop
    if (itemsToShow === 2) return 330;   // tablet
    return 320;                          // mobile
  }, [itemsToShow]);

  const defaultCard = {
    isPlaceholder: true,
    newsupdatesID: 'placeholder',
    newsTitle: t.noNews,
    newsDesc: t.checkLater,
    coverPhotoPath: 'website-repository/defaults/news-placeholder.jpg',
    postedAt: new Date(),
    postedBy: t.postedBy
  };

  // Use latest 10 DB rows
  const sliderItems = useMemo(() => {
    if (!newsupdates || newsupdates.length === 0) {
      return [defaultCard, defaultCard, defaultCard];
    }
    const sorted = [...newsupdates].sort(
      (a, b) => new Date(b.postedAt) - new Date(a.postedAt)
    );
    return sorted.slice(0, 10);
  }, [newsupdates, t.noNews, t.checkLater, t.postedBy]);

  // Infinite loop clones (preserve DB ID, add _cloneKey for React)
  const sliderData = useMemo(() => {
    if (!sliderItems.length) return [];
    const first = sliderItems[0];
    const last = sliderItems[sliderItems.length - 1];
    return [
      { ...last, _cloneKey: 'clone-last' },
      ...sliderItems.map((item, i) => ({ ...item, _cloneKey: `item-${i}` })),
      { ...first, _cloneKey: 'clone-first' }
    ];
  }, [sliderItems]);

  // Navigation
  const nextColumn = useCallback(() => {
    if (isAnimating) return;
    setIsAnimating(true);
    setDisplayIndex(prev => prev + 1);
  }, [isAnimating]);

  const prevColumn = useCallback(() => {
    if (isAnimating) return;
    setIsAnimating(true);
    setDisplayIndex(prev => prev - 1);
  }, [isAnimating]);

  // Auto slide
  useEffect(() => {
    autoSlideRef.current = setInterval(() => nextColumn(), 5000);
    return () => clearInterval(autoSlideRef.current);
  }, [nextColumn]);

  // Loop jump after animation
  useEffect(() => {
    if (!isAnimating) return;
    const timeout = setTimeout(() => {
      setIsAnimating(false);
      if (displayIndex >= sliderData.length - 1) setDisplayIndex(1);
      if (displayIndex <= 0) setDisplayIndex(sliderData.length - 2);
    }, 500);
    return () => clearTimeout(timeout);
  }, [displayIndex, isAnimating, sliderData.length]);

  if (isLoading) return (
    <div className="text-center py-5">
      <div className="d-flex flex-column justify-content-center align-items-center py-5 bg-light rounded-2">
        <span className='spinner-border spinner-border-sm' style={{ width: '1.5rem', height: '1.5rem' }}></span>
        <div className="text-center my-4">
          <h6 className="text-heading">{t.loading}</h6>
          <p className="text-heading-secondary fs-12">{t.retrievingNews}</p>
        </div>
      </div>
    </div>
  );

  if (isError) return (
    <div className="text-center py-5 alert alert-info">
      <h5 className='card-title fw-semibold'>{t.errorTitle}</h5>
      <h6 className='card-title fw-semibold mb-3'>{t.errorSubtitle}</h6>
      <p className='text-secondary fs-13'>{t.errorMessage}</p>
    </div>
  );

  const totalSlides = sliderData.length;

  return (
    <div className="container-fluid card-pane my-4 py-4 p-0">
      <div className="container">

        {/* Header */}
        <div className="d-flex justify-content-between align-items-center mb-3" data-aos="fade-right" data-aos-duration="1500">
          <Link to="/newsupdates" className="text-decoration-none text-danger">
            {t.moreNews} <i className="bi bi-arrow-up-right-square ms-1" />
          </Link>
          <h5 className="fw-bold m-0">{t.latestNews}</h5>
          <div>
            <button onClick={prevColumn} className="btn btn-link text-danger" aria-label="previous">
              <i className="bi bi-arrow-left-square fs-4" />
            </button>
            <button onClick={nextColumn} className="btn btn-link text-danger" aria-label="next">
              <i className="bi bi-arrow-right-square fs-4" />
            </button>
          </div>
        </div>

        {/* Slider */}
        <div className="overflow-hidden position-relative" data-aos="fade-up" data-aos-duration="1500" data-aos-delay="100">
          <div
            className="d-flex"
            style={{
              width: `${totalSlides * cardWidth}px`,
              transform: `translateX(-${displayIndex * cardWidth}px)`,
              transition: isAnimating ? 'transform 0.5s ease-in-out' : 'none'
            }}
          >
            {sliderData.map((news) => (
              <div
                key={news._cloneKey || news.newsupdatesID}
                style={{
                  flex: `0 0 ${cardWidth}px`,
                  maxWidth: `${cardWidth}px`,
                  padding: '0 0.3rem',
                  boxSizing: 'border-box'
                }}
              >
                <Link
                  to={`/newsupdates/${news.newsupdatesID}/${slugify(news.newsTitle || '')}`}
                  onClick={e => news.isPlaceholder && e.preventDefault()}
                  className="text-decoration-none h-100 d-block"
                >
                  <div className="news-card-container position-relative border-0 shadow-lg overflow-hidden h-100">

                    {/* Overlay */}
                    <div className="news-full-overlay">
                      <h6 className="fw-bold text-white mb-3">{news.newsTitle}</h6>
                      <div
                        className="small text-white mb-2 news-desc-clamp"
                        dangerouslySetInnerHTML={{ __html: news.newsDesc || '' }}
                      ></div>
                      <div className="overlay-meta d-flex justify-content-between">
                        <span className="small text-white">{returnDate(news.postedAt)}</span>
                        <span className="small text-white"><i>{t.postedBy}</i>: {news.postedBy}</span>
                      </div>
                    </div>

                    {/* Normal */}
                    <div className="news-card-content h-100">
                      <div className="news-image">
                        <img
                          src={`${webMediaURL}/${news.coverPhotoPath}`}
                          alt={news.newsTitle}
                          className="img-fluid w-100"
                        />
                      </div>

                      <div className="px-3 py-3 h-100 d-flex flex-column card-pane">
                        <h6 className="fw-bold text-dark mb-1">{news.newsTitle}</h6>
                        <div className="news-meta d-flex justify-content-between align-items-center border-top py-2 mt-auto">
                          <span className="small text-dark">{returnDate(news.postedAt)}</span>
                          <span className="small text-dark"><i>{t.postedBy}</i>: {news.postedBy}</span>
                        </div>
                      </div>
                    </div>

                  </div>
                </Link>
              </div>
            ))}
          </div>
        </div>

      </div>
    </div>
  );
};

export default NewsUpdates;
