import { Link } from "react-router-dom";
import React, { useEffect, useRef, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { Typewriter } from "react-simple-typewriter";
import Carousel from 'bootstrap/js/dist/carousel';

import { getBillboardPosts } from "../features/billboardSlice";

const BillboardHighlights = () => {
  const dispatch = useDispatch();
  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

  const [activeIndex, setActiveIndex] = useState(0);
  const [isLoading, setIsLoading] = useState(true);
  const [deviceClass, setDeviceClass] = useState('desktop');
  const carouselRef = useRef(null);
  const carouselInstanceRef = useRef(null);

  const { billboards } = useSelector((state) => state.billboards);

  // Detect device type based on screen width
  useEffect(() => {
    const checkDevice = () => {
      const width = window.innerWidth;
      
      if (width < 576) {
        setDeviceClass('small');
      } 
      else if (width >= 576 && width < 992) {
        setDeviceClass('medium');
      } 
      else {
        setDeviceClass('large');
      }
    };
    
    checkDevice();
    window.addEventListener('resize', checkDevice);
    
    return () => window.removeEventListener('resize', checkDevice);
  }, []);

  useEffect(() => {
    setIsLoading(true);
    dispatch(getBillboardPosts()).finally(() => setIsLoading(false));
  }, [dispatch]);

  // Initialize carousel with JavaScript
  useEffect(() => {
    if (carouselRef.current && !carouselInstanceRef.current) {
      carouselInstanceRef.current = new Carousel(carouselRef.current, {
        interval: 10000,
        ride: 'carousel',
        pause: false,
        wrap: true,
        touch: true
      });
    }

    return () => {
      if (carouselInstanceRef.current) {
        carouselInstanceRef.current.dispose();
        carouselInstanceRef.current = null;
      }
    };
  }, []);

  // Restart carousel when items change
  useEffect(() => {
    if (carouselInstanceRef.current) {
      carouselInstanceRef.current.dispose();
      carouselInstanceRef.current = null;
      
      if (carouselRef.current) {
        carouselInstanceRef.current = new Carousel(carouselRef.current, {
          interval: 10000,
          ride: 'carousel',
          pause: false,
          wrap: true,
          touch: true
        });
      }
    }
  }, [billboards]);

  const renderCarouselItem = (item, index) => (
    <div
      key={item.billboardID || index}
      className={`carousel-item ${index === 0 ? "active" : ""}`}
    >
      {/* Image Container */}
      <div className="carousel-image-container" style={{
        width: '100%',
        height: deviceClass === 'large' ? '70vh' : '100vh',
        minHeight: deviceClass !== 'large' ? '100%' : 'auto',
        overflow: 'hidden',
        position: 'relative',
        backgroundColor: '#f0f0f0'
      }}>
        <img
          src={`${webMediaURL}/${item.billboardPhotoPath}`}
          alt={item.billboardTitle}
          className="hero-img"
          style={{ 
            width: '100%',
            height: '100%',
            objectFit: 'cover',
            objectPosition: 'center',
            display: 'block'
          }}
          onError={(e) => {
            e.target.src = '/website-repository/herocarousel/fallback-image.jpg';
          }}
        />
      </div>
      
      {/* OVERLAY - ORIGINAL COLOR - NO GRADIENT, NO BACKGROUND */}
      <div 
        className="carousel-overlay d-flex justify-content-center align-items-end text-center"
        style={{ 
          position: 'absolute', 
          bottom: deviceClass === 'small' ? '0%' : deviceClass === 'medium' ? '0%' : '0%',
          left: '0',
          right: '0',
          width: '100%',
          pointerEvents: 'none',
          zIndex: 2
          /* HAKUNA BACKGROUND - HAKUNA GRADIENT - KAMA ORIGINAL YAKO */
        }}
      >
        <div
          className="carousel-content text-white"
          data-aos="fade-left"
          data-aos-duration={deviceClass === 'large' ? "1500" : "1000"}
          data-aos-delay={deviceClass === 'large' ? "1500" : "1000"}
          style={{
            display: deviceClass === 'small' ? 'none' : 'block',
            marginBottom: deviceClass === 'large' ? '3rem' : '1.5rem',
            ...(deviceClass === 'medium' && {
              paddingLeft: '20px',
              paddingRight: '20px',
              maxWidth: '90%',
              margin: '0 auto',
              marginBottom: '2rem'
            })
          }}
        >
          <div
            className="hero-text"
            dangerouslySetInnerHTML={{ __html: item.billboardBody }}
            style={{
              color: 'white',
              textShadow: '2px 2px 4px rgba(0,0,0,0.5)',
              ...(deviceClass === 'medium' && {
                display: '-webkit-box',
                WebkitLineClamp: '2',
                WebkitBoxOrient: 'vertical',
                overflow: 'hidden',
                textOverflow: 'ellipsis',
                maxHeight: '3em',
                lineHeight: '1.5em',
                fontSize: '1.1rem'
              }),
              ...(deviceClass === 'large' && {
                fontSize: '1.25rem'
              })
            }}
          />
        </div>
      </div>
    </div>
  );

  const renderDefaultCarouselItem = () => (
    <div className="carousel-item active position-relative">
      {/* Image Container */}
      <div className="carousel-image-container" style={{
        width: '100%',
        height: deviceClass === 'large' ? '70vh' : '100vh',
        minHeight: deviceClass !== 'large' ? '100%' : 'auto',
        overflow: 'hidden',
        position: 'relative',
        backgroundColor: '#f0f0f0'
      }}>
        <img
          src={`/website-repository/herocarousel/jengo.jpeg`}
          alt="Default"
          className="hero-img"
          style={{ 
            width: '100%',
            height: '100%',
            objectFit: 'cover',
            objectPosition: 'center',
            display: 'block'
          }}
        />
      </div>

      {/* OVERLAY - ORIGINAL COLOR - NO GRADIENT, NO BACKGROUND */}
      <div 
        className="carousel-overlay d-flex justify-content-center align-items-end text-center w-100"
        style={{ 
          position: 'absolute', 
          bottom: deviceClass === 'small' ? '5%' : deviceClass === 'medium' ? '7%' : '9%',
          left: '0',
          right: '0',
          pointerEvents: 'none',
          zIndex: 2
          /* HAKUNA BACKGROUND - HAKUNA GRADIENT - KAMA ORIGINAL YAKO */
        }}
      >
        <div
          className="carousel-content text-white"
          data-aos="fade-left"
          data-aos-duration={deviceClass === 'large' ? "1000" : "800"}
          data-aos-delay={deviceClass === 'large' ? "4000" : "3000"}
          style={{
            display: deviceClass === 'small' ? 'none' : 'block',
            marginBottom: deviceClass === 'large' ? '3rem' : '1.5rem',
            ...(deviceClass === 'medium' && {
              paddingLeft: '20px',
              paddingRight: '20px',
              maxWidth: '90%',
              margin: '0 auto',
              marginBottom: '2rem'
            })
          }}
        >
          <p 
            className="hero-text"
            style={{
              color: 'white',
              textShadow: '2px 2px 4px rgba(0,0,0,0.5)',
              ...(deviceClass === 'medium' && {
                display: '-webkit-box',
                WebkitLineClamp: '2',
                WebkitBoxOrient: 'vertical',
                overflow: 'hidden',
                textOverflow: 'ellipsis',
                maxHeight: '3em',
                lineHeight: '1.5em',
                fontSize: '1.1rem'
              }),
              ...(deviceClass === 'large' && {
                fontSize: '1.25rem'
              })
            }}
          >
            Ujenzi wa jengo la Ofisi za Tume ya Utumishi wa Mahakama unaoendelea jijini Dodoma unaelekea ukingoni ambapo hivi sasa jengo hilo limefikia asilimia 96 ikiwa ni hatua ya umaliziwaji wa jengo hilo.
          </p>
        </div>
      </div>
    </div>
  );

  if (isLoading) {
    return (
      <section id="hero" className="hero-carousel">
        <div 
          className="d-flex align-items-center justify-content-center bg-light"
          style={{ 
            width: '100%',
            height: deviceClass === 'large' ? '70vh' : '100vh',
            minHeight: deviceClass !== 'large' ? '100%' : 'auto'
          }}
        >
          <div className="spinner-border text-primary" role="status">
            <span className="visually-hidden">Loading...</span>
          </div>
        </div>
      </section>
    );
  }

  const visibleBillboards = billboards?.filter((b) => b.showOnCarouselDisplay) || [];
  const hasCarouselItems = visibleBillboards.length > 0;

  return (
    <section id="hero" className="hero-carousel overflow-hidden">
      <div
        id="hero-carousel"
        ref={carouselRef}
        className="carousel slide carousel-fade"
        data-bs-ride="carousel"
        data-bs-interval="10000"
        data-bs-touch="true"
      >
        <div className="carousel-inner">
          {hasCarouselItems
            ? visibleBillboards.map(renderCarouselItem)
            : renderDefaultCarouselItem()}
        </div>

        {/* Navigation arrows */}
        {(hasCarouselItems ? visibleBillboards.length > 1 : true) && (
          <>
            <button
              className="carousel-control-prev"
              type="button"
              data-bs-target="#hero-carousel"
              data-bs-slide="prev"
              style={{ zIndex: 10 }}
            >
              <span className="carousel-control-prev-icon" aria-hidden="true" />
              <span className="visually-hidden">Previous</span>
            </button>

            <button
              className="carousel-control-next"
              type="button"
              data-bs-target="#hero-carousel"
              data-bs-slide="next"
              style={{ zIndex: 10 }}
            >
              <span className="carousel-control-next-icon" aria-hidden="true" />
              <span className="visually-hidden">Next</span>
            </button>
          </>
        )}
      </div>
      
      {/* CSS for full coverage */}
      <style>{`
        .carousel-item {
          transition: transform 0.6s ease-in-out;
        }
        
        .carousel-image-container {
          background-color: #e0e0e0;
        }
        
        .hero-img {
          transition: opacity 0.3s ease;
        }
        
        /* Small devices */
        @media (max-width: 575px) {
          .carousel-image-container {
            height: 35vh !important;
            min-height: 100% !important;
          }
          
          .carousel-item {
            height: 35vh;
          }
          
          .carousel-inner {
            height: 35vh;
          }
          
          #hero-carousel {
            height: 35vh;
          }
          
          .hero-carousel {
            height: 35vh;
          }
          
          .carousel-control-prev,
          .carousel-control-next {
            width: 15%;
            opacity: 0.9;
            z-index: 15;
          }
        }
        
        /* Medium devices */
        @media (min-width: 576px) and (max-width: 991px) {
          .carousel-image-container {
            height: 55vh !important;
            min-height: 90% !important;
          }
          
          .carousel-item {
            height: 55vh;
          }
          
          .carousel-inner {
            height: 55vh;
          }
          
          #hero-carousel {
            height: 55vh;
          }
          
          .hero-carousel {
            height: 55vh;
          }
        }
        
        /* Large devices */
        @media (min-width: 992px) {
          .carousel-image-container {
            height: 75vh !important;
          }
        
          .carousel-inner {
            height: 75vh;
          }
          
          .hero-carousel {
            height: 75vh;
          }
        }
      `}</style>
    </section>
  );
};

export default BillboardHighlights;