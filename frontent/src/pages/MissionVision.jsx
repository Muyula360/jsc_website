import { Link } from 'react-router-dom';
import { useContext } from 'react';
import { LanguageContext } from "../context/Language";
import NewsHighlights from '../components/NewsHighlights';

const MissionVision = () => {
  const { language } = useContext(LanguageContext);

  const translations = {
    en: {
      home: "Home",
      pageTitle: "Vision, Mission & Core Value",
      vision: "Vision",
      mission: "Mission",
      coreValues: "Core Values",

      visionText:
        "To be the center of excellence in managing the Judiciary Service in Mainland Tanzania.",

      missionText:
        "To provide continuous advisory and management services for Human Resources in the Judiciary Service of Mainland Tanzania.",

      value1: "Integrity",
      value2: "Innovativeness",
      value3: "Accountability & Responsiveness",
      value4: "Transparency",
      value5: "Team Work",
      value6: "Excellence",
    },

    sw: {
      home: "Mwanzo",
      pageTitle: "Dira, Dhima na Maadili ya Msingi",
      vision: "Dira",
      mission: "Dhima",
      coreValues: "Maadili ya Msingi",

      visionText:
        "Kuwa kitovu cha ubora katika kusimamia Utumishi wa Mahakama Tanzania Bara.",

      missionText:
        "Utoaji endelevu wa huduma ya ushauri na usimamizi wa Rasilimaliwatu katika Utumishi wa Mahakama Tanzania Bara.",

      value1: "Uadilifu",
      value2: "Ubunifu",
      value3: "Uwajibikaji na Uwajibikaji wa Haraka",
      value4: "Uwazi",
      value5: "Ushirikiano",
      value6: "Ubora",
    }
  };

  const t = translations[language] || translations.en;

  return (
    <>
      {/* Page Banner */}
      <div className="position-relative">
        <div className="page-banner text-center">
          <div className="container d-flex flex-column justify-content-center" style={{ height: "130px" }} >
            <h2 className="text-white fw-bold my-1">{t.pageTitle}</h2>
            <ol className="breadcrumb mt-2 justify-content-center">
              <li className="breadcrumb-item"><Link to="/">{t.home}</Link></li>
              <li className="breadcrumb-item active">{t.pageTitle}</li>
            </ol>
          </div>
        </div>
      </div>


      <div className="container my-5">
        <div className="row">
          <div className="col-lg-8">
            <h4 className='text-center text-md-start fw-semibold'>{t.pageTitle}</h4>
            <div className="card-pane p-4 mt-5">
              <div className="mb-5">
                <h4 className="fw-semibold border-bottom pb-2">
                  <i className="bi bi-crosshair text-accent me-2"></i>
                  {t.vision}
                </h4>
                <p className="fs-18 text-justify mt-2">{t.visionText}</p>
              </div>

              <div className="my-5">
                <h4 className="fw-semibold border-bottom pb-2">
                  <i className="bi bi-flag text-accent me-2"></i>
                  {t.mission}
                </h4>
                <p className="fs-18 text-justify mt-2">{t.missionText}</p>
              </div>

              <div>
                <h4 className="fw-semibold border-bottom pb-2">
                  <i className="bi bi-bank text-accent me-2"></i>
                  {t.coreValues}
                </h4>
                <div className="row mt-3">
                  <div className="col-sm-6 col-md-6">
                    <ul className="list-unstyled">
                      <li className="mb-2"><span className="badge text-success fw-bold me-2">✓</span>{t.value1}</li>
                      <li className="mb-2"><span className="badge text-success fw-bold me-2">✓</span>{t.value2}</li>
                      <li className="mb-2"><span className="badge text-success fw-bold me-2">✓</span>{t.value3}</li>
                    </ul>
                  </div>
                  <div className="col-sm-6 col-md-6">
                    <ul className="list-unstyled">
                      <li className="mb-2"><span className="badge text-success fw-bold me-2">✓</span>{t.value4}</li>
                      <li className="mb-2"><span className="badge text-success fw-bold me-2">✓</span>{t.value5}</li>
                      <li className="mb-2"><span className="badge text-success fw-bold me-2">✓</span>{t.value6}</li>
                    </ul>
                  </div>
                </div>
              </div>

            </div>
          </div>

          {/* Sidebar */}
          <div className="col-lg-4 mt-5 mt-lg-0">
            <NewsHighlights />
          </div>

        </div>
      </div>
    </>
  );
};

export default MissionVision;
