import { Link } from 'react-router-dom';
import { useContext } from 'react';
import { LanguageContext } from "../context/Language";
import NewsHighlights from '../components/NewsHighlights';

const Stakeholders = () => {
  const { language } = useContext(LanguageContext);

  const translations = {
    en: {
      home: "Home",
      pageTitle: "Our Stakeholder",
      paragraph_1: `Our stakeholders include all individuals and institutions that benefit from our services related to employment, appointments, and the submission of complaints concerning violations of the code of conduct for judicial officers.`,
      paragraph_2: `These stakeholders may consist of public and private institutions, citizens qualified for positions advertised by the Commission, and any individual or institution with an interest in or evidence of misconduct by a judicial officer.`,
      
    },
    sw: {
      home: "Mwanzo",
      pageTitle: "Wadau Wetu",
      paragraph_1: `Wadau wetu ni yeyote anayenufaika na huduma zetu za ajira, teuzi na uwasilishaji wa malalamiko yanayohusiana na ukiukwaji wa maadili ya watumishi wa Mahakama.`,
      paragraph_2:`Wanufaika hawa wanaweza kuwa taasisi za umma au binafsi, mwananchi yeyote mwenye sifa za kuajiriwa kwa nafasi zilizotangazwa na Tume na mtu au taasisi yenye maslahi au ushahidi katika lalamiko la ukiukwaji wa maadili ya utumishi wa Mahakama lililowasilishwa.`,
     }
  };

  const t = translations[language] || translations.en;

  return (
    <>
 <div className="position-relative">
        <div className="page-banner text-center">
          <div className="container d-flex flex-column justify-content-center" style={{ height: "130px" }} >
            <h2 className="text-white fw-bold my-1">{t.pageTitle}</h2>
            <ol className="breadcrumb mt-2 justify-content-center">
              <li className="breadcrumb-item"><Link to="/">{t.home}</Link> </li>
              <li className="breadcrumb-item active">{t.pageTitle}</li>
            </ol>
          </div>
        </div>
      </div>

      <div className="container my-5">
        <div className="row">
          <div className="col-lg-8">
            <div className="mb-5">
             <h4 className='text-center text-md-start fw-semibold'>{t.pageTitle}</h4>
             <div className='card-pane p-4 mt-5'>
              <p className='text-justify fs-18'>{t.paragraph_1}</p>
              <p className='text-justify fs-18'>{t.paragraph_2}</p>
             </div>
            </div>
          </div>

          <div className="col-lg-4 mt-5 mt-lg-0">
            <NewsHighlights />
          </div>
        </div>
      </div>
    </>
  );
};

export default Stakeholders;