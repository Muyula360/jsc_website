import { Link } from 'react-router-dom';
import { useContext } from 'react';
import { LanguageContext } from '../context/Language'; // adjust path if needed

const PageNotFound = () => {
  const { language } = useContext(LanguageContext);

  /* ================= TRANSLATIONS ================= */
  const translations = {
    en: {
      title: "Page Not Found",
      home: "Home",
      notFound: "404 NOT FOUND",
      message: "The page you are looking for doesn’t exist.",
      goHome: "Go Back to Home",
    },
    sw: {
      title: "Ukurasa Haupatikani",
      home: "Mwanzo",
      notFound: "404 HAUPATIKANI",
      message: "Ukurasa unaoutafuta haupo.",
      goHome: "Rudi Mwanzo",
    },
  };

  const t = translations[language];

  return (
    <>
      {/* ================= PAGE BANNER ================= */}
      <div className="position-relative">
        <div className="page-banner text-center">
          <div
            className="container d-flex flex-column justify-content-center"
            style={{ height: "130px" }}
          >
            <h2 className="text-white fw-bold my-1">
              {t.title}
            </h2>

            <ol className="breadcrumb mt-2 justify-content-center">
              <li className="breadcrumb-item">
                <Link to="/">{t.home}</Link>
              </li>
              <li className="breadcrumb-item active">
                {t.title}
              </li>
            </ol>
          </div>
        </div>
      </div>

      {/* ================= CONTENT ================= */}
      <div className="container text-center my-5">
        <h2 className="text-danger fw-bold">{t.notFound}</h2>
        <h4>{t.message}</h4>

        <Link className="icon-link icon-link-hover mt-4" to="/">
          {t.goHome} <i className="bi bi-arrow-right"></i>
        </Link>
      </div>
    </>
  );
};

export default PageNotFound;
