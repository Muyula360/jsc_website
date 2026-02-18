import { Link, useNavigate } from 'react-router-dom';
import { useState, useEffect } from 'react';
import { useDispatch, useSelector } from "react-redux";

const ContentsMgrSidebars = ({ isMinimized, isMobile }) => {
  const [activeMenu, setActiveMenu] = useState(null);
  const [isHovered, setIsHovered] = useState(false);
  
  const { validatedUser, isLoading, isSuccess, isError, message } = useSelector((state) => state.authValidation);

  // Toggle menu - closes others when opening a new one
  const toggleMenu = (menuId) => {
    if (activeMenu === menuId) {
      setActiveMenu(null); // Close if same menu clicked
    } else {
      setActiveMenu(menuId); // Open new menu, close others
    }
  };

  // Close menus when switching to mobile
  useEffect(() => {
    if (isMobile) {
      setActiveMenu(null);
    }
  }, [isMobile]);

  // Mobile view - always icon-only with auto scroll
  if (isMobile) {
    return (
      <nav 
        className="sidebar sidebar-offcanvas text-muted" 
        id="sidebar" 
        style={{ 
          width: "70px", 
          height: "100%", 
          position: "fixed",
          top: "70px",
          left: 0,
          overflowY: "auto", // Auto scroll on mobile
          overflowX: "hidden",
          zIndex: 100,
          WebkitOverflowScrolling: "touch",
          boxShadow: "2px 0 5px rgba(0,0,0,0.1)"
        }}
      >
        <ul className="nav" style={{ flexDirection: "column" }}>
          {/* Website View Icon */}
          <li className="nav-item" style={{ width: "100%" }}>
            <Link 
              className="nav-link" 
              to="../" 
              target="_blank" 
              rel="noopener noreferrer"
              style={{ 
                display: "flex", 
                justifyContent: "center", 
                padding: "15px 0",
                textAlign: "center"
              }}
              title="Website View"
            >
              <i className="bi bi-display" style={{ fontSize: "1.25rem" }}></i>
            </Link>
          </li>

          {/* Dashboard Icon */}
          <li className="nav-item" style={{ width: "100%" }}>
            <Link 
              className="nav-link" 
              to="../webcontentsmgr"
              style={{ 
                display: "flex", 
                justifyContent: "center", 
                padding: "15px 0",
                textAlign: "center"
              }}
              title="Dashboard"
            >
              <i className="bi bi-speedometer" style={{ fontSize: "1.25rem" }}></i>
            </Link>
          </li>

          {/* Web Contents Icon */}
          <li className="nav-item" style={{ width: "100%" }}>
            <a 
              className="nav-link" 
              style={{ 
                display: "flex", 
                justifyContent: "center", 
                padding: "15px 0",
                textAlign: "center",
                cursor: "pointer"
              }}
              title="Web Contents"
            >
              <i className="bi bi-globe2" style={{ fontSize: "1.25rem" }}></i>
            </a>
          </li>

          {/* Static Contents Icon */}
          <li className="nav-item" style={{ width: "100%" }}>
            <a 
              className="nav-link" 
              style={{ 
                display: "flex", 
                justifyContent: "center", 
                padding: "15px 0",
                textAlign: "center",
                cursor: "pointer"
              }}
              title="Static Contents"
            >
              <i className="bi bi-ui-checks-grid" style={{ fontSize: "1.25rem" }}></i>
            </a>
          </li>

          {/* User Management Icon */}
          <li className="nav-item" style={{ width: "100%" }}>
            <a 
              className="nav-link" 
              style={{ 
                display: "flex", 
                justifyContent: "center", 
                padding: "15px 0",
                textAlign: "center",
                cursor: "pointer"
              }}
              title="User Management"
            >
              <i className="bi bi-person-fill-gear" style={{ fontSize: "1.25rem" }}></i>
            </a>
          </li>
        </ul>
      </nav>
    );
  }

  // Desktop view - Same scroll behavior as content wrapper
  const sidebarWidth = isMinimized ? "70px" : "250px";
  
  return (
    <nav 
      className="sidebar sidebar-offcanvas text-muted" 
      id="sidebar" 
      style={{ 
        width: sidebarWidth, 
        height: "100%", 
        position: "fixed",
        top: "70px",
        left: 0,
        overflowY: isMinimized ? (isHovered ? "auto" : "hidden") : (isHovered ? "auto" : "hidden"), // Same behavior regardless of minimized state
        overflowX: "hidden",
        zIndex: 100,
        transition: "all 0.3s ease",
        boxShadow: "2px 0 5px rgba(0,0,0,0.05)"
      }}
      onMouseEnter={() => setIsHovered(true)}
      onMouseLeave={() => {
        setIsHovered(false);
        if (isMinimized) {
          setActiveMenu(null);
        }
      }}
    >
      <ul className="nav" style={{ flexDirection: "column" }}>
        {!isMinimized && (
          <li className="nav-item nav-profile">
            <div className="nav-link">
              <div className="profile-image">
                <img src="/userProfilePic.png" alt="Profile" />
              </div>
              <div className="profile-name">
                <h6 className="text-heading fw-semibold mb-1">{ isSuccess && `Welcome ${validatedUser.userfname}` }</h6>
                <span className="text-heading-secondary fs-14">{ isSuccess && validatedUser.userRole }</span>
              </div>
            </div>
          </li>
        )}

        {/* Website View */}
        <li className="nav-item">
          <Link 
            className="nav-link" 
            to="../" 
            target="_blank" 
            rel="noopener noreferrer"
            title={isMinimized ? "Website View" : ""}
            style={isMinimized ? { 
              display: "flex", 
              justifyContent: "center", 
              padding: "15px 0",
              textAlign: "center"
            } : {}}
          >
            <i className="bi bi-display menu-icon"></i>
            {!isMinimized && <span className="menu-title">Website View</span>}
          </Link>
        </li>
        
        {/* Dashboard */}
        <li className="nav-item">
          <Link 
            className="nav-link" 
            to="../webcontentsmgr"
            title={isMinimized ? "Dashboard" : ""}
            style={isMinimized ? { 
              display: "flex", 
              justifyContent: "center", 
              padding: "15px 0",
              textAlign: "center"
            } : {}}
          >
            <i className="bi bi-speedometer menu-icon"></i>
            {!isMinimized && <span className="menu-title">Dashboard</span>}
          </Link>
        </li>

        {/* Web Contents - Accordion */}
        <li className="nav-item">
          <a 
            className={`nav-link ${activeMenu === 'webContents' ? 'active' : ''}`} 
            onClick={(e) => {
              e.preventDefault();
              if (!isMinimized) {
                toggleMenu('webContents');
              }
            }}
            style={{ 
              cursor: 'pointer',
              ...(isMinimized ? { 
                display: "flex", 
                justifyContent: "center", 
                padding: "15px 0",
                textAlign: "center"
              } : {})
            }}
            title={isMinimized ? "Web Contents" : ""}
          >
            <i className="bi bi-globe2 menu-icon"></i>
            {!isMinimized && (
              <>
                <span className="menu-title">Web Contents</span>
                <i className={`menu-arrow text-muted ${activeMenu === 'webContents' ? 'rotate-180' : ''}`}></i>
              </>
            )}
          </a>
          {!isMinimized && (
            <div 
              className={`collapse ${activeMenu === 'webContents' ? 'show' : ''}`} 
              id="ui-basic"
              style={{ transition: 'all 0.3s ease' }}
            >
              <ul className="nav flex-column sub-menu">
                <li className="nav-item">
                  <Link className="nav-link" to="billboard">Billboard Posts</Link>
                </li>
                <li className="nav-item">
                  <Link className="nav-link" to="newsupdates">News & Updates</Link>
                </li>
                <li className="nav-item">
                  <Link className="nav-link" to="announcements">Announcements</Link>
                </li>
                <li className="nav-item">
                  <Link className="nav-link" to="speeches">Speeches</Link>
                </li>
                <li className="nav-item">
                  <Link className="nav-link" to="managementLeaders">Management Leaders</Link>
                </li>
                <li className="nav-item">
                  <Link className="nav-link" to="publications">Publications</Link>
                </li>
                <li className="nav-item">
                  <Link className="nav-link" to="vacancies">Vacancies</Link>
                </li>
                <li className="nav-item">
                  <Link className="nav-link" to="tenders">Tender</Link>
                </li>
                <li className="nav-item">
                  <Link className="nav-link" to="gallery">Gallery</Link>
                </li>
              </ul>
            </div>
          )}
        </li>

        {/* Static Contents - Accordion */}
        <li className="nav-item">
          <a 
            className={`nav-link ${activeMenu === 'staticContents' ? 'active' : ''}`} 
            onClick={(e) => {
              e.preventDefault();
              if (!isMinimized) {
                toggleMenu('staticContents');
              }
            }}
            style={{ 
              cursor: 'pointer',
              ...(isMinimized ? { 
                display: "flex", 
                justifyContent: "center", 
                padding: "15px 0",
                textAlign: "center"
              } : {})
            }}
            title={isMinimized ? "Static Contents" : ""}
          >
            <i className="bi bi-ui-checks-grid menu-icon"></i>
            {!isMinimized && (
              <>
                <span className="menu-title">Static Contents</span>
                <i className={`menu-arrow text-muted ${activeMenu === 'staticContents' ? 'rotate-180' : ''}`}></i>
              </>
            )}
          </a>
          {!isMinimized && (
            <div 
              className={`collapse ${activeMenu === 'staticContents' ? 'show' : ''}`} 
              id="ui-basic2"
              style={{ transition: 'all 0.3s ease' }}
            >
              <ul className="nav flex-column sub-menu">
                <li className="nav-item">
                  <Link className="nav-link" to="faqs">FaQs</Link>
                </li>
                <li className="nav-item">
                  <Link className="nav-link" to="corevalues">Core Values</Link>
                </li>
              </ul>
            </div>
          )}
        </li>

        {/* User Management - Accordion */}
        <li className="nav-item">
          <a 
            className={`nav-link ${activeMenu === 'userManagement' ? 'active' : ''}`} 
            onClick={(e) => {
              e.preventDefault();
              if (!isMinimized) {
                toggleMenu('userManagement');
              }
            }}
            style={{ 
              cursor: 'pointer',
              ...(isMinimized ? { 
                display: "flex", 
                justifyContent: "center", 
                padding: "15px 0",
                textAlign: "center"
              } : {})
            }}
            title={isMinimized ? "User Management" : ""}
          >
            <i className="bi bi-person-fill-gear menu-icon"></i>
            {!isMinimized && (
              <>
                <span className="menu-title">User Management</span>
                <i className={`menu-arrow text-muted ${activeMenu === 'userManagement' ? 'rotate-180' : ''}`}></i>
              </>
            )}
          </a>
          {!isMinimized && (
            <div 
              className={`collapse ${activeMenu === 'userManagement' ? 'show' : ''}`} 
              id="ui-basics"
              style={{ transition: 'all 0.3s ease' }}
            >
              <ul className="nav flex-column sub-menu">
                <li className="nav-item">
                  <Link className="nav-link" to="users">System Users</Link>
                </li>
              </ul>
            </div>
          )}
        </li>
      </ul>
    </nav>
  );
}

export default ContentsMgrSidebars;