import { useState, useEffect } from 'react';
import { Outlet, useNavigate } from "react-router-dom";
import { useDispatch, useSelector } from "react-redux";

import ContentsMgrNavbars from '../components/ContentsMgrNavbars';
import ContentsMgrSidebars from '../components/ContentsMgrSidebars';
import ContentsMgrFooters from '../components/ContentsMgrFooter';

import { authTokenValidation } from '../features/authValidationSlice';

const ContentsmgrLayout = () => {
  const dispatch = useDispatch();
  const navigate = useNavigate();

  const { isLoading, isSuccess, isError } = useSelector((state) => state.authValidation);
  const [isSidebarMinimized, setIsSidebarMinimized] = useState(false);
  const [isMobile, setIsMobile] = useState(window.innerWidth <= 768);

  const toggleSidebar = () => {
    setIsSidebarMinimized(!isSidebarMinimized);
  };

  // Check for mobile view on resize
  useEffect(() => {
    const handleResize = () => {
      const mobile = window.innerWidth <= 768;
      setIsMobile(mobile);
      // Auto-minimize sidebar on mobile
      if (mobile) {
        setIsSidebarMinimized(true);
      }
    };

    window.addEventListener('resize', handleResize);
    // Initial check
    handleResize();

    return () => window.removeEventListener('resize', handleResize);
  }, []);

  useEffect(() => {
    dispatch(authTokenValidation());
  }, [dispatch]);

  useEffect(() => {
    if (!isLoading && isError) {
      navigate('/login');
    }
  }, [isLoading, isError, navigate]);

  if (isLoading) {
    return (
      <div className="d-flex flex-column justify-content-center align-items-center py-5 bg-light rounded-2" style={{ height: '100dvh' }}>
        <div>
          <div className="mb-4">
            <img src="/logo.png" width="150" alt="Judiciary of Tanzania" />
          </div>
          <div className="text-center">
            <div className="spinner-grow text-danger mx-1" role="status">
              <span className="visually-hidden">Loading...</span>
            </div>
            <div className="spinner-grow text-danger mx-1" role="status">
              <span className="visually-hidden">Loading...</span>
            </div>
            <div className="spinner-grow text-danger mx-1" role="status">
              <span className="visually-hidden">Loading...</span>
            </div>
          </div>
        </div>
      </div>
    );
  }

  if (isSuccess) {
    return (
      <div className="container-scroller">
        <ContentsMgrNavbars 
          toggleSidebar={toggleSidebar} 
          isMinimized={isSidebarMinimized}
          isMobile={isMobile} 
        />
        <div className="container-fluid page-body-wrapper mb-0">
          <ContentsMgrSidebars 
            isMinimized={isSidebarMinimized} 
            isMobile={isMobile}
          />
          <div 
            className="main-panel" 
            style={{ 
              marginLeft: isMobile 
                ? '70px' // Fixed width for mobile icon sidebar
                : isSidebarMinimized 
                  ? '70px' 
                  : '250px',
              width: isMobile
                ? 'calc(100% - 70px)'
                : isSidebarMinimized 
                  ? 'calc(100% - 70px)' 
                  : 'calc(100% - 250px)',
              transition: 'all 0.3s ease',
              minHeight: '100vh',
              position: 'relative'
            }}
          >
            <div 
              className="content-wrapper" 
              style={{ 
                height: isMobile 
                  ? 'calc(100vh - 120px)' // Adjust for mobile
                  : 'calc(100vh - 70px)',
                overflowY: 'auto',
                overflowX: 'hidden',
                padding: isMobile ? '15px' : '20px',
                WebkitOverflowScrolling: 'touch' // Smooth scrolling on iOS
              }}
            >
              <Outlet />
            </div>
          </div>
        </div>
        <ContentsMgrFooters />
      </div>
    );
  }

  // If not loading and not success, redirect to login
  if (!isLoading && !isSuccess) {
    navigate('/login');
  }

  return null;
};

export default ContentsmgrLayout;