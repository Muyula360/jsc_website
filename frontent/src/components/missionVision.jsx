import { Link } from 'react-router-dom';
import { useContext } from 'react';
import { LanguageContext } from '../context/Language'; // Adjust path as needed

const MissionVision = () => {
  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL || '';
  const { language } = useContext(LanguageContext);

  // Translation object
  const translations = {
    sw: {
      dira: "Dira",
      dhima: "Dhima",
      paragraph1: "Kuwa kitovu cha ubora katika kusimamia Utumishi wa Mahakama Tanzania bara.",
      paragraph2: "Utoaji endelevu wa huduma ya ushauri na usimamizi wa Rasilimaliwatu katika Utumishi wa Mahakama Tanzania Bara",
      value1: "Uadilifu",
      value2: "Ubunifu",
      value3: "Uwajibikaji",
      value4: "Uwazi",
      value5: "Ushirikiano",
      value6: "Ubora",

    },
    en: {
      dira: "Vision",
      dhima: "Mission",
      paragraph1: "To be the center of excellence in managing the Judiciary Service in Mainland Tanzania.",
      paragraph2: "To provide continuous advisory and management services for Human Resources in the Judiciary Service of Mainland Tanzania.",
      value1:"Integrity",
      value2:"Innovativeness",
      value3:"Accountability & Responsiveness",
      value4:"Transparency",
      value5:"Team Work",
      value6:"Excellence",
    }
  };

  const t = translations[language];

  return (
    <div className="">
      <div className="row justify-content-center">
        <div className="col-lg-11 p-3">
          <div className="border-0">
            <div className="card-body">
              <h4 className="card-title text-dark mb-3 border-bottom pb-1 text-lg-start text-center">
                {t.dira}
              </h4>
              
              <div className="content text-justify">
                <p className="text-dark mb-4">
                  {t.paragraph1}
                </p>                  
             </div>
              <h4 className="card-title text-dark mb-3 pt-2 border-bottom pb-1 text-lg-start text-center">
                {t.dhima}
              </h4>
              <div className="content text-justify">
                <p className="text-dark mb-4">
                  {t.paragraph2}
                </p>                  
             </div>
               <h4 className="card-title text-dark mb-3 pt-2 border-bottom pb-1 text-lg-start text-center">
                Core Values
              </h4>
              <div className="content text-justify">
            <div className="row justify-content-center">
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
        </div>
      </div>
    </div>
  );
};

export default MissionVision;