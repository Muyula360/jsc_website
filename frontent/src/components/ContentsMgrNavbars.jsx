import { Link, useNavigate } from 'react-router-dom';
import { useState, useEffect } from 'react';
import { useDispatch, useSelector } from "react-redux";
import { toast } from "react-toastify";

import { userLogout } from "../features/authSlice";
import { reset } from "../features/authValidationSlice";
import { getUserNotifications } from "../features/notificationSlice";
import { getUserFeedbacks } from "../features/feedbackSlice";


const ContentsMgrNavbars = ({ toggleSidebar, isMinimized, isMobile }) => {

  const dispatch = useDispatch();
  const navigate = useNavigate();


  const { validatedUser, isLoading, isSuccess, isError, message } = useSelector((state) => state.authValidation);

  const notifications = useSelector((state) => state.notifications);
  const feedbacks = useSelector((state) => state.feedbacks);

  const [notificationsList, setNotificationsList] = useState([]);
  const [feedbacksList, setFeedbacksList] = useState([]);


  // get user notifications and feedbacks when navbar mounts
  useEffect(() => {
    dispatch(getUserNotifications());
    dispatch(getUserFeedbacks());
  }, [dispatch]);
  

  // after fetching notifications successfully assign fetched notifications to the notificationsList array
  useEffect(() => {
    if (notifications?.isSuccess) {
      setNotificationsList(notifications.notifications || []);
    }
    if (notifications?.isError) {
      toast.error("Failed to fetch notifications.");
    }
  }, [notifications?.notifications, notifications?.isSuccess, notifications?.isError]);


   // after fetching feedbacks successfully assign fetched feedbacks to the feedbacksList array
  useEffect(() => {
    if (feedbacks?.isSuccess) {
      setFeedbacksList(feedbacks.feedbacks || []);
    }
    if (feedbacks?.isError) {
      toast.error("Failed to fetch feedbacks.");
    }
  }, [feedbacks?.feedbacks, feedbacks?.isSuccess, feedbacks?.isError]);


  // logout function
 const onLogOut = async () => {
  try {
    // Wait for logout thunk to finish
    const resultAction = await dispatch(userLogout());

    if (userLogout.fulfilled.match(resultAction)) {
      // Only reset state and navigate if logout succeeded
      dispatch(reset());
      navigate('/login');
      toast.success("Logged out successfully.");
    } else {
      toast.error(resultAction.payload || "Logout failed");
    }
  } catch (error) {
    toast.error("An error occurred during logout.");
  }
}


  
  return (
    <>
    
      {/* Content Manager Navbar */}
      <nav className="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row default-layout-navbar">
        <div className="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
          <Link className="navbar-brand brand-logo">
            <h4 className="text-accent fw-bold">Contents Manager</h4>
          </Link>
          <Link className="navbar-brand brand-logo-mini">
            <img src="/JOT LOGO 2.png" alt="logo" />
          </Link>
        </div>

        <div className="navbar-menu-wrapper d-flex align-items-stretch">
          <button 
            className="navbar-toggler navbar-toggler align-self-center" 
            type="button" 
            onClick={toggleSidebar}
            title={isMinimized ? "Expand sidebar" : "Minimize sidebar"}
            style={{ border: 'none', background: 'transparent' }}
          >
            <i className={`bi ${isMinimized ? 'bi-arrow-right-square-fill' : 'bi-arrow-left-square-fill'} text-danger`} style={{ fontSize: '1.5rem' }}></i>
          </button>

          <ul className="navbar-nav">
            <li className="nav-item d-none d-md-flex rounded-5">
              <div className="nav-link ">
              </div>
            </li>
          </ul>

          <ul className="navbar-nav navbar-nav-right">

            {/* NOTIFICATIONS - ADDED BACK */}
            <li className="nav-item dropdown">
              <Link 
                className="nav-link count-indicator dropdown-toggle" 
                id="notificationDropdown" 
                to="notifications" 
                role="button" 
                aria-expanded="false"
              >
                <i className="bi bi-bell-fill"></i>
                <span className="count bg-danger">
                  {notificationsList?.filter(item => item?.readStatus === 0)?.length || 0}
                </span>
              </Link>
            </li>

            {/* FEEDBACKS - ADDED BACK */}
            <li className="nav-item dropdown">
              <Link 
                className="nav-link count-indicator dropdown-toggle" 
                id="feedbackDropdown" 
                to="feedbacks" 
                role="button" 
                aria-expanded="false"
              >
                <i className="bi bi-envelope-fill"></i>
                <span className="count bg-danger">
                  {feedbacksList?.filter(item => item?.readStatus === 0)?.length || 0}
                </span>
              </Link>
            </li>

            {/* User Profile Dropdown */}
            <li className="nav-item dropdown">
              <Link 
                className="nav-link dropdown-toggle"  
                id="profileDropdown" 
                href="#" 
                role="button" 
                data-bs-toggle="dropdown" 
                aria-expanded="false" 
              >
                <i className="bi bi-person-circle"></i>
                { isSuccess && validatedUser?.userfname } 
              </Link>
              <div className="dropdown-menu dropdown-menu-right navbar-dropdown p-2" aria-labelledby="profileDropdown" >
                <Link className="dropdown-item" to='myAccount'>
                  <i className="bi bi-person-lines-fill me-1"></i> My Account 
                </Link>
                <Link className="dropdown-item" onClick={ onLogOut }>
                  <i className="bi bi-box-arrow-right me-1"></i> Logout 
                </Link>
              </div>
            </li>

          </ul>
          <button className="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas" >
            <span className="fas fa-bars"></span>
          </button>
        </div>
      </nav>
      {/* End Navbar */}

    </>
  );
}

export default ContentsMgrNavbars;