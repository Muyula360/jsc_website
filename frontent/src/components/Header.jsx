// src/components/Header.jsx
import { Link, useNavigate } from "react-router-dom";
import { useContext, useEffect, useRef, useState, useCallback } from "react";
import { LanguageContext } from "../context/Language";
import { useSearch } from "../context/searchContext";

const Header = () => {
  const { language, toggleLanguage } = useContext(LanguageContext);
  const { searchQuery, setSearchQuery } = useSearch();
  const [isSticky, setIsSticky] = useState(false);
  const navbarRef = useRef(null);
  const searchInputRef = useRef(null);
  const navigate = useNavigate();
  const rafRef = useRef(null); // For requestAnimationFrame

  // Handle sticky on scroll - optimized with useCallback and requestAnimationFrame
  const handleScroll = useCallback(() => {
    if (rafRef.current) {
      cancelAnimationFrame(rafRef.current);
    }
    
    rafRef.current = requestAnimationFrame(() => {
      if (!navbarRef.current) return;
      const navbarTop = navbarRef.current.offsetTop;
      const shouldBeSticky = window.scrollY > navbarTop;
      
      if (shouldBeSticky !== isSticky) {
        setIsSticky(shouldBeSticky);
      }
    });
  }, [isSticky]); // Only recreate when isSticky changes

  useEffect(() => {
    window.addEventListener("scroll", handleScroll, { passive: true });
    
    return () => {
      window.removeEventListener("scroll", handleScroll);
      if (rafRef.current) {
        cancelAnimationFrame(rafRef.current);
      }
    };
  }, [handleScroll]); // Only depends on handleScroll

  // Handle search submission
  const handleSearchSubmit = useCallback((e) => {
    e.preventDefault();
    if (searchQuery.trim()) {
      navigate(`/search?q=${encodeURIComponent(searchQuery.trim())}`);
      // Close mobile menu if open
      const collapse = document.getElementById("navbarSupportedContent");
      if (collapse) {
        const bsCollapse = window.bootstrap?.Collapse?.getInstance(collapse);
        bsCollapse?.hide();
      }
    }
  }, [searchQuery, navigate]);

  // Keyboard shortcut for search (Ctrl/Cmd + K)
  useEffect(() => {
    const handleKeyDown = (e) => {
      if ((e.ctrlKey || e.metaKey) && e.key === 'k') {
        e.preventDefault();
        searchInputRef.current?.focus();
      }
    };

    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, []); // Empty dependencies - this should only run once

  // Close mobile menu function - memoized
  const closeMobileMenu = useCallback(() => {
    const collapse = document.getElementById("navbarSupportedContent");
    if (collapse) {
      const bsCollapse = window.bootstrap?.Collapse?.getInstance(collapse);
      bsCollapse?.hide();
    }
  }, []);

  const translations = {
    sw: {
      searchPlaceholder: "Tafuta... (Ctrl+K)",
      english: "English",
      contact: "Wasiliana nasi",
      portal: "Ajira portal",
      questions: "Maswali",
      eOffice: "e-Office",
      email: "Barua pepe",
      republic: "Jamhuri ya Muungano wa Tanzania",
      commission: "Tume ya Utumishi wa Mahakama",
      home: "Mwanzo",
      aboutUs: "Kuhusu Sisi",
      whoWeAre: "Sisi ni nani",
      missionVision: "Dira na Dhima",
      whatWeDo: "Tunafanya nini?",
      stakeholders: "Wadau wetu",
      governance: "Utawala",
      structure: "Muundo wa Taasisi",
      members: "Wajumbe wa Taasisi",
      management: "Menejimenti",
      committees: "Kamati",
      ethicsJudges: "Kamati ya Maadili ya Majaji",
      ethicsOfficers: "Kamati ya Maadili ya Maafisa Mahakama",
      regionalEthics: "Kamati ya Maadili ya Maafisa Mahakama ya Mkoa",
      districtEthics: "Kamati ya Maadili ya Maafisa Mahakama ya Wilaya",
      hqDiscipline: "Kamati ya Nidhamu ya Makao Makuu ya Mahakama",
      registryDiscipline: "Kamati ya Nidhamu ya Masjala Kuu ya Mahakama",
      regionalDiscipline: "Kamati ya Nidhamu ya Kanda au Division ya Mahakama",
      employmentAdvice: "Kamati ya Ajira na Ushauri",
      newsCenter: "Kituo cha Habari",
      news: "Habari",
      photoLibrary: "Maktaba ya Picha",
      videoLibrary: "Maktaba ya Video",
      speeches: "Hotuba Mbalimbali",
      publications: "Machapisho",
      regulations: "Kanuni",
      guidelines: "Miongozo",
      laws: "Sheria",
      constitution: "Katiba ya Jamhuri ya Muungano wa Tanzania",
      eReturn: "e-Mrejesho",
    },
    en: {
      searchPlaceholder: "Search... (Ctrl+K)",
      english: "Swahili",
      contact: "Contact us",
      portal: "Recruitment portal",
      questions: "FAQs",
      eOffice: "e-Office",
      email: "Staff mail",
      republic: "The United Republic of Tanzania",
      commission: "Judicial Service Commission",
      home: "Home",
      aboutUs: "About Us",
      whoWeAre: "Who We Are",
      missionVision: "Mission & Vision",
      whatWeDo: "What We Do",
      stakeholders: "Our Stakeholders",
      governance: "Governance",
      structure: "Organisation Structure",
      members: "Commission Members",
      management: "Management",
      committees: "Committees",
      ethicsJudges: "Judges Ethics Committee",
      ethicsOfficers: "Judicial Officers Ethics Committee",
      regionalEthics: "Regional Judicial Officers Ethics Committee",
      districtEthics: "District Judicial Officers Ethics Committee",
      hqDiscipline: "Disciplinary Committee at the Judiciary Headquarter",
      registryDiscipline: "Discipline Committee at the High Court Main Registry",
      regionalDiscipline: "Disciplinary Committee at the zones and divisions of the High Court of Tanzania",
      employmentAdvice: "Appointment and Advisory Committee",
      newsCenter: "News Center",
      news: "News",
      photoLibrary: "Photo Library",
      videoLibrary: "Video Library",
      speeches: "Speeches",
      publications: "Publications",
      regulations: "Regulations",
      guidelines: "Guidelines",
      laws: "Laws",
      constitution: "Constitution of the United Republic of Tanzania",
      eReturn: "e-Mrejesho",
    }
  };

  const t = translations[language];
  const headerPaddingTop = isSticky ? '35px' : '0';

  return (
    <header   id="header" className="header header-banner" style={{paddingTop: headerPaddingTop, transition: 'padding-top 0.2s ease' }}  >
      <div className="top-header">
        {/* ===== MOBILE ===== */}
        <div className="d-flex d-lg-none justify-content-center w-100 py-2" style={{ backgroundColor: '#ED1F2C' }}>
          <div className="d-flex align-items-center gap-2 w-100 px-2">
            <form onSubmit={handleSearchSubmit} className="flex-grow-1">
              <div className="input-group input-group-sm search-group">
                <input  ref={searchInputRef} type="text" className="form-control" placeholder={t.searchPlaceholder} value={searchQuery} onChange={(e) => setSearchQuery(e.target.value)} />
                <button type="submit" className="btn btn-light"><i className="bi bi-search"></i></button>
              </div>
            </form>
            <button className="btn btn-sm text-white fw-semibold px-2"  onClick={toggleLanguage} style={{ background: 'transparent', border: 'none', whiteSpace: 'nowrap' }}>{t.english}</button>
          </div>
        </div>

        {/* ===== DESKTOP ===== */}
        <div className="container-fluid d-none d-lg-flex align-items-center p-0">
          <div className="d-flex align-items-center w-50" style={{ backgroundColor: '#ED1F2C', borderBottomRightRadius: '45px', overflow: 'hidden' }}>
            <ul className="nav justify-content-end w-100 me-5 py-0">
              <li className="nav-item"> <Link  className="nav-link text-white" to="/contactus" onClick={closeMobileMenu} style={{ fontSize: '0.9rem' }}> {t.contact} </Link> </li>
              <li className="nav-item"><Link  className="nav-link text-white" to="https://oas.judiciary.go.tz/login" target="_blank" onClick={closeMobileMenu} style={{ fontSize: '0.9rem' }}>{t.portal}</Link> </li>
              <li className="nav-item"><Link className="nav-link text-white" to="/faqs" onClick={closeMobileMenu} style={{ fontSize: '0.9rem' }} >{t.questions}</Link></li>
            </ul>
          </div>
          
          <div className="d-flex justify-content-center align-items-center bg-transparent w-25">
            <form onSubmit={handleSearchSubmit} className="w-75 m-1">
              <div className="input-group input-group-sm">
                <input ref={searchInputRef}type="text"  className="form-control" placeholder={t.searchPlaceholder} value={searchQuery} onChange={(e) => setSearchQuery(e.target.value)} style={{ fontSize: '0.9rem' }}/>
                <button type="submit" className="btn btn-light" style={{ fontSize: '0.9rem' }}><i className="bi bi-search"></i></button>
              </div>
            </form>
          </div>
          
          <div className="d-flex align-items-center w-50" style={{ backgroundColor: '#ED1F2C', borderBottomLeftRadius: '45px', overflow: 'hidden' }}>
            <ul className="nav justify-content-start w-90 ms-5">
              <li className="nav-item"> <Link  className="nav-link text-white" target="_blank" to="https://eoffice.gov.go.tz/login" style={{ fontSize: '0.9rem' }} > {t.eOffice} </Link></li>
              <li className="nav-item"> <Link  className="nav-link text-white" target="_blank" to="https://mail.jsc.go.tz/" style={{ fontSize: '0.9rem' }} > {t.email} </Link></li>
              <li className="nav-item">
                <button className="nav-link text-white" onClick={toggleLanguage} 
                style={{ 
                    background: 'transparent', 
                    border: 'none', 
                    textDecoration: 'none', 
                    cursor: 'pointer',
                    fontSize: '0.9rem'
                  }}
                >{t.english}
                </button>
              </li>
            </ul>
          </div>
        </div>
      </div>

      <div 
        className="text-center"
        style={{
          opacity: isSticky ? 0 : 1,
          visibility: isSticky ? 'hidden' : 'visible',
          height: isSticky ? 0 : 'auto',
          overflow: 'hidden',
          transition: 'all 0.2s ease'
        }}
      >
        <div className="row align-items-center p-3">
          <div className="col-2 col-md-3 text-end my-0">
            <img src="/emblem.png" alt="National Emblem" className="img-fluid emblem-img" style={{ maxHeight: '80px' }} />
          </div>
          <div className="col-8 col-md-6">
            <div className="text-dark fw-bold mb-0">
              <h5 className="p-0 m-0 fw-bold" style={{ fontSize: 'clamp(0.9rem, 3vw, 1.3rem)' }}>{t.republic}</h5>
              <h2 className="p-0 m-0 fw-bold" style={{ fontSize: 'clamp(1.2rem, 3vw, 2.2rem)' }}>{t.commission}</h2>
            </div>
          </div>
          <div className="col-2 col-md-3 text-start my-0">
            <img src="/logo.png" alt="Commission Logo" className="img-fluid emblem-img" style={{ maxHeight: '80px' }} />
          </div>
        </div>
      </div>

      <nav ref={navbarRef}
        className={`navbar navbar-expand-lg w-100 top-shadow navbar-dark ${
          isSticky ? "navbar-sticky fixed-top" : ""
        }`}
        style={{backgroundColor: "#ED1F2C", minHeight: isSticky ? "32px" : "38px", transition: 'min-height 0.2s ease, box-shadow 0.2s ease', boxShadow: isSticky ? '0 2px 8px rgba(0,0,0,0.15)' : 'none', zIndex: 1030  }}>
        <div className="container-fluid py-1">
          <button className="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"
            style={{padding: isSticky ? '0.2rem 0.5rem' : '0.25rem 0.75rem', transition: 'padding 0.2s ease' }} >
            <span className="navbar-toggler-icon" style={{ width: isSticky ? '1.2em' : '1.5em', height: isSticky ? '1.2em' : '1.5em', transition: 'all 0.2s ease'  }}></span>
          </button>

          <div className="collapse navbar-collapse" id="navbarSupportedContent">
            <ul className="navbar-nav mx-auto">
              {/* Home */}
              <li className="nav-item"><Link className="nav-link fw-normal me-3" to="/" onClick={closeMobileMenu} style={{fontSize: isSticky ? '0.8rem' : '0.9rem', paddingTop: isSticky ? '0.01rem' : '0.1rem', paddingBottom: isSticky ? '0.01rem' : '0.1rem', transition: 'all 0.2s ease' }}  >{t.home}</Link></li>
              <li className="nav-item dropdown">
                <Link  className="nav-link dropdown-toggle fw-normal me-4"  to="#" role="button" data-bs-toggle="dropdown"  aria-expanded="false" style={{ fontSize: isSticky ? '0.9rem' : '1rem',paddingTop: isSticky ? '0.01rem' : '0.1rem', paddingBottom: isSticky ? '0.01rem' : '0.1rem',transition: 'all 0.2s ease'}} >{t.aboutUs}</Link>
                <ul className="dropdown-menu">
                  <li><Link  className="dropdown-item py-1" to="/who-we-are" onClick={closeMobileMenu} style={{ fontSize: isSticky ? '0.8rem' : '0.9rem', }}>{t.whoWeAre}</Link></li>
                  <li><Link className="dropdown-item py-1" to="/mission&vision" onClick={closeMobileMenu} style={{fontSize: isSticky ? '0.8rem' : '0.9rem',}} > {t.missionVision}</Link> </li>
                  <li><Link  className="dropdown-item py-1" to="/what-we-do" onClick={closeMobileMenu} style={{ fontSize: isSticky ? '0.8rem' : '0.9rem', }}>{t.whatWeDo}</Link></li>
                  <li><Link  className="dropdown-item py-1" to="/stakeholders" onClick={closeMobileMenu} style={{ fontSize: isSticky ? '0.8rem' : '0.9rem', }}>{t.stakeholders}</Link></li>
                </ul>
              </li>

              {/* Governance Dropdown */}
              <li className="nav-item dropdown">
                <Link  className="nav-link dropdown-toggle fw-normal me-4"  to="#" role="button" data-bs-toggle="dropdown"  aria-expanded="false" style={{ fontSize: isSticky ? '0.9rem' : '1rem',paddingTop: isSticky ? '0.01rem' : '0.1rem', paddingBottom: isSticky ? '0.01rem' : '0.1rem',transition: 'all 0.2s ease'}} >{t.governance}</Link>
                <ul className="dropdown-menu">
                  <li><Link  className="dropdown-item py-1" to="/organization-structure" onClick={closeMobileMenu} style={{ fontSize: isSticky ? '0.8rem' : '0.9rem', }}>{t.structure}</Link></li>
                  <li><Link className="dropdown-item py-1" to="/members" onClick={closeMobileMenu} style={{fontSize: isSticky ? '0.8rem' : '0.9rem',}} > {t.members}</Link> </li>
                  <li><Link  className="dropdown-item py-1" to="/management" onClick={closeMobileMenu} style={{ fontSize: isSticky ? '0.8rem' : '0.9rem', }}>{t.management}</Link></li>
                </ul>
              </li>

              {/* Committees Dropdown */}
                    <li className="nav-item dropdown">
                <Link  className="nav-link dropdown-toggle fw-normal me-4"  to="#" role="button" data-bs-toggle="dropdown"  aria-expanded="false" style={{ fontSize: isSticky ? '0.9rem' : '1rem',paddingTop: isSticky ? '0.01rem' : '0.1rem', paddingBottom: isSticky ? '0.01rem' : '0.1rem',transition: 'all 0.2s ease'}} >{t.committees}</Link>
                <ul className="dropdown-menu">
                  <li><Link  className="dropdown-item py-1" to="/who-we-are" onClick={closeMobileMenu} style={{ fontSize: isSticky ? '0.8rem' : '0.9rem', }}>{t.ethicsJudges}</Link></li>
                  <li><Link className="dropdown-item py-1" to="/mission&vision" onClick={closeMobileMenu} style={{fontSize: isSticky ? '0.8rem' : '0.9rem',}} > {t.ethicsOfficers}</Link> </li>
                  <li><Link  className="dropdown-item py-1" to="/what-we-do" onClick={closeMobileMenu} style={{ fontSize: isSticky ? '0.8rem' : '0.9rem', }}>{t.regionalEthics}</Link></li>
                  <li><Link  className="dropdown-item py-1" to="/stakeholders" onClick={closeMobileMenu} style={{ fontSize: isSticky ? '0.8rem' : '0.9rem', }}>{t.districtEthics}</Link></li>
                  <li><Link  className="dropdown-item py-1" to="/who-we-are" onClick={closeMobileMenu} style={{ fontSize: isSticky ? '0.8rem' : '0.9rem', }}>{t.hqDiscipline}</Link></li>
                  <li><Link className="dropdown-item py-1" to="/mission&vision" onClick={closeMobileMenu} style={{fontSize: isSticky ? '0.8rem' : '0.9rem',}} > {t.registryDiscipline}</Link> </li>
                  <li><Link  className="dropdown-item py-1" to="/what-we-do" onClick={closeMobileMenu} style={{ fontSize: isSticky ? '0.8rem' : '0.9rem', }}>{t.regionalDiscipline}</Link></li>
                  <li><Link  className="dropdown-item py-1" to="/stakeholders" onClick={closeMobileMenu} style={{ fontSize: isSticky ? '0.8rem' : '0.9rem', }}>{t.employmentAdvice}</Link></li>
                </ul>
              </li>

              {/* News Center Dropdown */}
                <li className="nav-item dropdown">
                <Link  className="nav-link dropdown-toggle fw-normal me-4"  to="#" role="button" data-bs-toggle="dropdown"  aria-expanded="false" style={{ fontSize: isSticky ? '0.9rem' : '1rem',paddingTop: isSticky ? '0.01rem' : '0.1rem', paddingBottom: isSticky ? '0.01rem' : '0.1rem',transition: 'all 0.2s ease'}} >{t.newsCenter}</Link>
                <ul className="dropdown-menu">
                  <li><Link  className="dropdown-item py-1" to="/organization-structure" onClick={closeMobileMenu} style={{ fontSize: isSticky ? '0.8rem' : '0.9rem', }}>{t.news}</Link></li>
                  <li><Link className="dropdown-item py-1" to="/members" onClick={closeMobileMenu} style={{fontSize: isSticky ? '0.8rem' : '0.9rem',}} > {t.photoLibrary}</Link> </li>
                  <li><Link  className="dropdown-item py-1" to="/management" onClick={closeMobileMenu} style={{ fontSize: isSticky ? '0.8rem' : '0.9rem', }}>{t.videoLibrary}</Link></li>
                  <li><Link  className="dropdown-item py-1" to="/management" onClick={closeMobileMenu} style={{ fontSize: isSticky ? '0.8rem' : '0.9rem', }}>{t.speeches}</Link></li>
                </ul>
              </li>

              {/* Publications Dropdown */}
               <li className="nav-item dropdown">
                <Link  className="nav-link dropdown-toggle fw-normal me-4"  to="#" role="button" data-bs-toggle="dropdown"  aria-expanded="false" style={{ fontSize: isSticky ? '0.9rem' : '1rem',paddingTop: isSticky ? '0.01rem' : '0.1rem', paddingBottom: isSticky ? '0.01rem' : '0.1rem',transition: 'all 0.2s ease'}} >{t.publications}</Link>
                <ul className="dropdown-menu">
                  <li><Link  className="dropdown-item py-1" to="/organization-structure" onClick={closeMobileMenu} style={{ fontSize: isSticky ? '0.8rem' : '0.9rem', }}>{t.regulations}</Link></li>
                  <li><Link className="dropdown-item py-1" to="/members" onClick={closeMobileMenu} style={{fontSize: isSticky ? '0.8rem' : '0.9rem',}} > {t.guidelines}</Link> </li>
                  <li><Link  className="dropdown-item py-1" to="/management" onClick={closeMobileMenu} style={{ fontSize: isSticky ? '0.8rem' : '0.9rem', }}>{t.laws}</Link></li>
                  <li><Link  className="dropdown-item py-1" to="/management" onClick={closeMobileMenu} style={{ fontSize: isSticky ? '0.8rem' : '0.9rem', }}>{t.constitution}</Link></li>
                </ul>
              </li>

              {/* e-Return */}
              <li className="nav-item"><Link className="nav-link fw-normal me-3" target="_blannk" to="https://www.emrejesho.gov.go.tz/home" onClick={closeMobileMenu} style={{fontSize: isSticky ? '0.8rem' : '0.9rem', paddingTop: isSticky ? '0.01rem' : '0.1rem', paddingBottom: isSticky ? '0.01rem' : '0.1rem', transition: 'all 0.2s ease' }}  >{t.eReturn}</Link></li> 

              {/* ================= MOBILE-ONLY LINKS ================= */}
              <li className="d-lg-none">
                <hr className="dropdown-divider bg-light opacity-50" />
              </li>
              <li className="nav-item d-lg-none"><Link  className="nav-link"  to="/contactus"  onClick={closeMobileMenu}style={{ fontSize: isSticky ? '0.8rem' : '0.9rem', }} >{t.contact}</Link></li>
              <li className="nav-item d-lg-none"><Link  className="nav-link"  to="https://oas.judiciary.go.tz/login" target="_blank"  onClick={closeMobileMenu}style={{ fontSize: isSticky ? '0.8rem' : '0.9rem', }} >{t.portal}</Link></li>
              <li className="nav-item d-lg-none"><Link  className="nav-link"  to="/faqs"  onClick={closeMobileMenu}style={{ fontSize: isSticky ? '0.8rem' : '0.9rem', }} >{t.questions}</Link></li>
              <li className="nav-item d-lg-none"><Link  className="nav-link"  to="https://eoffice.gov.go.tz/login" target="_blank"  onClick={closeMobileMenu}style={{ fontSize: isSticky ? '0.8rem' : '0.9rem', }} >{t.eOffice}</Link></li>
              <li className="nav-item d-lg-none"><Link  className="nav-link"  to="https://mail.jsc.go.tz/" target="_blank"  onClick={closeMobileMenu}style={{ fontSize: isSticky ? '0.8rem' : '0.9rem', }} >{t.email}</Link></li>
            </ul>
          </div>
        </div>
      </nav>

      {/* Add keyframe animation for sticky navbar */}
      <style jsx>{`
        .navbar-sticky {
          animation: slideDown 0.05s ease-out forwards;
        }
        
        @keyframes slideDown {
          from {
            transform: translateY(0);
          }
          to {
            transform: translateY(0);
          }
        }
        
        /* Ensure dropdowns work properly with fixed navbar */
        .navbar-sticky .dropdown-menu {
          position: absolute;
          margin-top: 4px;
        }
        
        /* Adjust dropdown items for compact view */
        .dropdown-item {
          transition: all 0.2s ease;
        }
        
        .dropdown-item:hover {
          padding-left: 1.5rem !important;
          background:red;
          color:white;
        }
      `}</style>
    </header>
  );
};

export default Header;