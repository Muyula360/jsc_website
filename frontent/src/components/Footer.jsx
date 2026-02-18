import { Link } from "react-router-dom";
import { useContext, useEffect } from "react";
import { LanguageContext } from "../context/Language";
import { useDispatch, useSelector } from 'react-redux';
import { getWebsiteVisitStats } from "../features/websiteVisitSlice";

const Footer = () => {
  const { language } = useContext(LanguageContext);
  const dispatch = useDispatch();
  
  // Get website visit stats from Redux store
  const { websiteVisits, isLoading, isSuccess } = useSelector(state => state.websiteVisit);

  // Fetch website visit stats on component mount
  useEffect(() => {
    dispatch(getWebsiteVisitStats());
  }, [dispatch]);

  // Get today's visit stats (first item in array or default values)
  const visitData = isSuccess && websiteVisits?.length > 0 
    ? websiteVisits[0] 
    : {
        today_visits: 0,
        yesterday_visits: 0,
        this_week_visits: 0,
        this_month_visits: 0,
        this_year_visits: 0
      };

  const t = {
    sw: {
      title: "Tume ya Utumishi wa Mahakama",
      follow: "Tufuatilie",
      popularSites: [
        { name: "Wizara ya Katiba na Sheria", href: "https://www.sheria.go.tz" },
        { name: "Mahakama ya Tanzania", href: "https://www.judiciary.go.tz" },
        { name: "Bunge la Tanzania", href: "https://www.parliament.go.tz" },
        { name: "Ofisi ya Taifa ya Mashtaka", href: "https://www.nps.go.tz" },
        { name: "Ofisi ya Wakili Mkuu wa Serikali", href: "https://www.oag.go.tz" },
      ],
      pages: [
        { name: "Miongozo na Taratibu", href: "/miongozo-na-taratibu" },
        { name: "Ramani ya Tanzania", href: "https://www.lands.go.tz/uploads/notices/sw1734348442-RAMANIYATANZANIA_.pdf" },
        { name: "e-Mrejesho", href: "https://emrejesho.gov.go.tz/" },
        { name: "Ajira Portal", href: "https://oas.judiciary.go.tz/" },
        { name: "Complainant Portal", href: "https://redmis.jsc.go.tz/complainant-login" },
      ],
      visitorLog: {
        today: "Leo",
        yesterday: "Jana",
        thisWeek: "Wiki Hii",
        thisMonth: "Mwezi Huu",
        thisYear: "Mwaka Huu",
      },
      contact: {
        location: "Mahali",
        address: "41104 Tambukareli Dodoma, 2 Mtaa wa Mahakama",
        street: "Anuani",
        streetAddress: "S.L.P 2705 Dodoma, Tanzania",
        email: "Barua pepe",
        emailAddress: "secretary@jsc.go.tz",
        phone: "Namba ya Simu",
        phoneNumber: "+255 262 320001",
      },
      footerLinks: {
        siteMap: "Ramani ya Tovuti",
        privacy: "Sera ya Faragha",
        disclaimer: "Kanusho",
        copyright: "Tovuti imesanifiwa na kutengenezwa na Huendeshwa na ",
        copyrighti: "Haki zote Zimehifadhiwa"
      }
    },
    en: {
      title: "Judiciary Service Commission",
      follow: "Follow Us",
      popularSites: [
        { name: "Ministry of Constitution and Legal Affairs", href: "https://www.sheria.go.tz" },
        { name: "Tanzania Judiciary", href: "https://www.judiciary.go.tz" },
        { name: "Tanzania Parliament", href: "https://www.parliament.go.tz" },
        { name: "National Prosecution Service", href: "https://www.nps.go.tz" },
        { name: "Attorney General Office", href: "https://www.oag.go.tz" },
      ],
      pages: [
        { name: "Guidelines & Procedures", href: "/miongozo-na-taratibu" },
        { name: "Tanzania Map", href: "https://www.lands.go.tz/uploads/notices/sw1734348442-RAMANIYATANZANIA_.pdf" },
        { name: "e-Mrejesho", href: "https://emrejesho.gov.go.tz/" },
        { name: "Vacancies Portal", href: "https://oas.judiciary.go.tz/" },
        { name: "Complainant Portal", href: "https://redmis.jsc.go.tz/complainant-login" },
      ],
      visitorLog: {
        today: "Today",
        yesterday: "Yesterday",
        thisWeek: "This Week",
        thisMonth: "This Month",
        thisYear: "This Year",
      },
      contact: {
        location: "Location",
        address: "41104 Tambukareli Dodoma, 2 Mahakama Street",
        street: "Address",
        streetAddress: "S.L.P 2705 Dodoma, Tanzania",
        email: "Email",
        emailAddress: "secretary@jsc.go.tz",
        phone: "Phone",
        phoneNumber: "+255 262 320001",
      },
      footerLinks: {
        siteMap: "Site Map",
        privacy: "Privacy Policy",
        disclaimer: "Disclaimer",
        copyright: "Website designed, developed and managed by ",
        copyrighti: "All right Reserved",
      }
    }
  };

  const content = t[language];

  return (
    <footer className="footer p-0 mb-0 pt-5">
      <div className="container mb-0">
        <div className="row gx-3">

          {/* Logo & Social */}
          <div className="col-lg-3 col-md-6 col-sm-12 footer-links text-center text-md-start" data-aos="fade-right" data-aos-duration="1500">
            <div className="logo d-flex flex-column align-items-center align-items-md-start text-white px-0">
              <img src="/logo_footer.png" alt="JSC Logo" className="mb-2 footer-logo"/>
              <h4 className="text-white fw-bold">{content.title}</h4>
              <h6 className="mt-2">{content.follow}</h6>
              <div className="social-links d-flex justify-content-center justify-content-md-start gap-1">
                <a target="_blank" href="https://twitter.com/jsc_tanzania"><i className="bi bi-twitter-x"></i></a>
                <a target="_blank" href="https://www.facebook.com/profile.php?id=61567374067620&mibextid=ZbWKwL"><i className="bi bi-facebook"></i></a>
                <a target="_blank" href="https://www.youtube.com/@TumeyaUtumishiwaMahakamaJSC"><i className="bi bi-youtube"></i></a>
                <a target="_blank" href="https://www.instagram.com/tume_ya_utumishi_wa_mahakama/"><i className="bi bi-instagram"></i></a>
              </div>
            </div>
          </div>

          {/* Popular Sites */}
          <div className="col-lg-3 col-md-6 col-sm-12 footer-links text-center text-md-start" data-aos="fade-left" data-aos-duration="1500" data-aos-delay="500">
            <h4>{language === "sw" ? "Tovuti Mashuhuri" : "Popular Sites"}</h4>
            <ul className="d-flex flex-column align-items-center align-items-md-start ps-0">
              {content.popularSites.map((site, i) => (
                <li key={i}><a href={site.href} target="_blank" rel="noopener noreferrer">{site.name}</a></li>
              ))}
            </ul>
          </div>

          {/* Pages */}
          <div className="col-lg-3 col-md-6 col-sm-12 footer-links text-center text-md-start" data-aos="fade-left" data-aos-duration="1500" data-aos-delay="800">
            <h4>{language === "sw" ? "Kurasa za Karibu" : "Recent Pages"}</h4>
            <ul className="d-flex flex-column align-items-center align-items-md-start ps-0 list-unstyled">
              {content.pages.map((page, i) => (
                <li key={i}>
                  <Link to={page.href} target={page.href.startsWith("http") ? "_blank" : "_self"}>{page.name}</Link>
                </li>
              ))}
            </ul>
          </div>

          {/* Visitor Log - UPDATED WITH REDUX DATA */}
          <div className="col-lg-3 col-md-6 col-sm-12 footer-links text-center text-md-start" data-aos="fade-left" data-aos-duration="1500" data-aos-delay="800">
            <h4>{language === "sw" ? "Logi ya Wageni" : "Visitor Log"}</h4>
            <ul className="d-flex flex-column align-items-center align-items-md-start ps-0 text-white">
              <li className="d-flex align-items-center">
                <a>
                  <i className="bi bi-calendar-day me-1"></i>
                  <span className="me-2">{content.visitorLog.today}:</span>
                  <strong className="text-white fs-16">
                    {isLoading ? "..." : visitData.today_visits}
                  </strong>
                </a>
              </li>
              <li className="d-flex align-items-center">
                <a>
                  <i className="bi bi-calendar-week me-2"></i>
                  <span className="me-2">{content.visitorLog.thisWeek}:</span>
                  <strong className="text-white fs-16">
                    {isLoading ? "..." : visitData.this_week_visits}
                  </strong>
                </a>
              </li>
              <li className="d-flex align-items-center">
                <a> 
                  <i className="bi bi-calendar-month me-2"></i>
                  <span className="me-2">{content.visitorLog.thisMonth}:</span>
                  <strong className="text-white fs-16">
                    {isLoading ? "..." : visitData.this_month_visits}
                  </strong>
                </a>
              </li>
              <li className="d-flex align-items-center">
                <a>
                  <i className="bi bi-calendar3 me-2"></i>
                  <span className="me-2">{content.visitorLog.thisYear}:</span>
                  <strong  className="text-white fs-16">
                    {isLoading ? "..." : visitData.this_year_visits}
                  </strong>
                </a>
              </li>
            </ul>
          </div>

        </div>
      </div>

      <hr className="footer-line" data-aos="fade-up" data-aos-duration="1500" data-aos-delay="1000"/>

      <div className="container mt-2 mb-4">
        <div className="row" data-aos="fade-bottom" data-aos-duration="2000" data-aos-delay="2000">

          {/* Location */}
          <div className="col-lg-3 col-md-6 text-center text-lg-start mb-3 mb-lg-0">
            <div className="footer-contact mt-3 text-white">
              <div className="d-flex flex-column flex-lg-row align-items-center align-items-lg-start gap-2">
                <span className="icon-circle-geo mb-2 mb-lg-0"><i className="bi bi-geo-alt-fill" style={{ fontSize: '1.5rem' }}></i></span>
                <span>
                  <h6 className="text-white mb-1">{content.contact.location}</h6>
                  {content.contact.address}
                </span>
              </div>
            </div>
          </div>

          {/* Street */}
          <div className="col-lg-3 col-md-6 text-center text-lg-start mb-3 mb-lg-0">
            <div className="footer-contact mt-3 text-white">
              <div className="d-flex flex-column flex-lg-row align-items-center align-items-lg-start gap-2">
                <span className="icon-circle mb-2 mb-lg-0"><i className="bi bi-house-fill" style={{ fontSize: '1.5rem' }}></i></span>
                <span>
                  <h6 className="text-white mb-1">{content.contact.street}</h6>
                  {content.contact.streetAddress}
                </span>
              </div>
            </div>
          </div>

          {/* Email */}
          <div className="col-lg-3 col-md-6 text-center text-lg-start mb-3 mb-lg-0">
            <div className="footer-contact mt-3 text-white">
              <div className="d-flex flex-column flex-lg-row align-items-center align-items-lg-start gap-2">
                <span className="icon-circle mb-2 mb-lg-0"><i className="bi bi-envelope-fill" style={{ fontSize: '1.5rem' }}></i></span>
                <span>
                  <h6 className="text-white mb-1">{content.contact.email}</h6>
                  {content.contact.emailAddress}
                </span>
              </div>
            </div>
          </div>

          {/* Phone */}
          <div className="col-lg-3 col-md-6 text-center text-lg-start mb-3 mb-lg-0">
            <div className="footer-contact mt-3 text-white">
              <div className="d-flex flex-column flex-lg-row align-items-center align-items-lg-start gap-2">
                <span className="icon-circle mb-2 mb-lg-0"><i className="bi bi-telephone-fill" style={{ fontSize: '1.5rem' }}></i></span>
                <span>
                  <h6 className="text-white mb-1">{content.contact.phone}</h6>
                  {content.contact.phoneNumber}
                </span>
              </div>
            </div>
          </div>

        </div>
      </div>

      {/* Footer Banner Links */}
      <div className="footer-banner">
        <div className='text-center mt-2'>
          <div className="pb-3 fs-6">
            <Link to="#"><strong className="mt-sm-4 me-5 text-dark">{content.footerLinks.siteMap}</strong></Link>
            <Link to="#"><strong className="mt-sm-4 me-5 text-dark">{content.footerLinks.privacy}</strong></Link>
            <Link to="#"><strong className="mt-sm-4 text-dark">{content.footerLinks.disclaimer}</strong></Link>
          </div>
          <div className="row justify-content-center">
            <div className="col-10 fs-7">{content.footerLinks.copyright} <b>{content.title} © 2025 JSC, </b>{content.footerLinks.copyrighti} </div>
          </div>
        </div>
      </div>

    </footer>
  );
};

export default Footer;