import { Link } from "react-router-dom";
import React, { useContext } from "react";
import { LanguageContext } from "../context/Language";
import NewsHighlights from "../components/NewsHighlights";

const WhatWeDo = () => {
  const { language } = useContext(LanguageContext);

  const translations = {
    en: {
      home: "Home",
      pageTitle: "What We Do",
      intro: `The Authority of the Judiciary Service Commission as a body managing employment 
      and discipline of Judicial Officers is derived from Article 113 (1) of the Constitution 
      of the United Republic of Tanzania, 1977 as read together with Section 29 (1) of the 
      Judicial Administration Act, Chapter 237, as follows:`,
      sections: [
        {
          title: "Advise the President on:",
          items: [
            "Appointment of Chief Justice and Judges of the High Court of Tanzania.",
            "Appointment of the Chief Executive Officer of the Judiciary, Registrar General, Registrar of the Court of Appeal, and Registrar of the High Court.",
            "Inability of the Court of Appeal Judge, Chief Justice, and High Court Judge to perform duties.",
            "Unsatisfactory conduct of the Court of Appeal Judge, Chief Justice, Chief Executive Officer of the Judiciary, Registrar General, Registrar of the Court of Appeal, and Registrar of the High Court.",
            "Benefits of Judiciary employees in Tanzania.",
          ],
        },
        {
          title: "Investigate complaints against Court of Appeal Judges, Chief Justice, High Court Judges, or any judicial officer.",
        },
        {
          title: "Take administrative action against Court of Appeal Judges, Chief Justice, or High Court Judges beyond the steps provided in the Constitution.",
        },
        {
          title: "Appoint, promote, and take disciplinary action against all employees except those outside the Commission's appointment authority.",
        },
        {
          title: "Recruit, promote, or discipline any employee who is not a Judicial Officer as defined by law.",
        },
      ],
    },
    sw: {
      home: "Mwanzo",
      pageTitle: "Tunafanya Nini",
      intro: `Mamlaka ya Tume ya Utumishi wa Mahakama kama chombo cha kusimamia 
      ajira na nidhamu za watumishi wa Mahakama yanatokana na Ibara ya 113 (1) 
      ya Katiba ya Jamhuri ya Muungano wa Tanzania Toleo la mwaka 1977 ikisomwa 
      pamoja na Kifungu Na. 29 (1) cha Sheria ya Usimamizi wa Mahakama sura ya 237, kama ifuatavyo:`,
      sections: [
        {
          title: "Kumshauri Rais kuhusu:",
          items: [
            "Uteuzi wa Jaji Kiongozi pamoja na Majaji wa Mahakama Kuu ya Tanzania.",
            "Uteuzi wa Mtendaji Mkuu wa Mahakama, Msajili Mkuu, Msajili wa Mahakama ya Rufani na Msajili wa Mahakama Kuu.",
            "Kutokuwa na uwezo kwa Jaji wa Rufani, Jaji Kiongozi na Jaji wa Mahakama Kuu kutekeleza majukumu ya ofisi.",
            "Mwenendo usioridhisha wa Jaji wa Rufani, Jaji Kiongozi, Mtendaji Mkuu wa Mahakama, Msajili Mkuu, Msajili wa Mahakama ya Rufani na Msajili wa Mahakama Kuu.",
            "Maslahi ya watumishi wa Mahakama ya Tanzania.",
          ],
        },
        {
          title: "Kuchambua lalamiko dhidi ya Jaji wa Rufani, Jaji Kiongozi, Jaji wa Mahakama Kuu au Afisa yeyote wa Mahakama.",
        },
        {
          title: "Kuchukua hatua za kiutawala dhidi ya Jaji wa Rufani, Jaji Kiongozi, au Jaji wa Mahakama Kuu mbali na hatua zilizoainishwa katika Katiba.",
        },
        {
          title: "Kuteua, Kupandisha Cheo na kuchukua hatua za kinidhamu dhidi ya watumishi wote isipokuwa kwa wale ambao sio mamlaka ya uteuzi wa Tume.",
        },
        {
          title: "Kuajiri na Kupandisha cheo au kuchukua hatua za kinidhamu dhidi ya mtumishi yeyote ambaye si Afisa wa Mahakama kama ilivyoainishwa katika sheria.",
        },
      ],
    },
  };

  const t = translations[language] || translations.en;

  return (
    <>
      {/* Page Banner */}
      <div className="position-relative">
        <div className="page-banner text-center">
          <div className="container d-flex flex-column justify-content-center" style={{ height: "130px" }}>
            <h2 className="text-white fw-bold my-1">{t.pageTitle}</h2>
            <ol className="breadcrumb mt-2 justify-content-center">
              <li className="breadcrumb-item">
                <Link to="/">{t.home}</Link>
              </li>
              <li className="breadcrumb-item active">{t.pageTitle}</li>
            </ol>
          </div>
        </div>
      </div>

      {/* Main Content */}
      <div className="container my-5">
        <div className="row">
          {/* Left Content */}
          <div className="col-lg-8">
            <h4 className="text-center text-md-start fw-semibold mb-5">{t.pageTitle}</h4>

            <div className="card-pane mb-5 p-4">
              <p className="text-justify fs-18 mb-4">{t.intro}</p>

              {t.sections.map((section, idx) => (
                <div key={idx} className="mb-4 ps-3">
                  <h6 className="fw-semibold mb-2">
                    <span className="me-2">{idx + 1}.</span>
                    {section.title}
                  </h6>

                  {section.items && (
                    <ul className="list-unstyled text-secondary ps-4">
                      {section.items.map((item, i) => (
                        <li key={i} className="mb-1">
                          <i className="bi bi-check text-accent me-2"></i>
                          {item}
                        </li>
                      ))}
                    </ul>
                  )}
                </div>
              ))}
            </div>
          </div>

          {/* Right Sidebar */}
          <div className="col-lg-4 mt-5 mt-lg-0">
            <NewsHighlights />
          </div>
        </div>
      </div>
    </>
  );
};

export default WhatWeDo;
