import { Link } from 'react-router-dom';
import { useContext } from 'react';
import { LanguageContext } from '../context/Language'; // Adjust path as needed

const ChairManGreetings = () => {
  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL || '';
  const { language } = useContext(LanguageContext);

  // Translation object
  const translations = {
    sw: {
      title: "Neno la Utangulizi",
      paragraph1: "Kwa niaba ya Wajumbe, Usimamizi na wafanyikazi wote wa Tume ya Utumishi wa Mahakama, ninafurahi kuwakaribisha raia wote kuitembelea tovuti ya Tume ya Utumishi wa Mahakama iliyosanidiwa kwa madhumuni ya kuwataarifu umma juu ya kuwepo kwa shughuli na majukumu mbalimbali yanayotekelezwa na Tume.",
      paragraph2: "Majukumu ya Tume ya Utumishi wa Mahakama yameainishwa chini ya Kifungu cha 113(1) cha Katiba ya Jamhuri ya Muungano wa Tanzania na Kifungu cha 29 cha Sheria ya Usimamizi wa Mahakama Namba 4 ya 2011.",
      readMore: "Soma Zaidi",
      sincerely: "Kwa dhati,",
      chairmanName: "George Mcheche Masaju",
      chairmanTitle: "Mwenyekiti, Tume ya Utumishi wa Mahakama"
    },
    en: {
      title: "Foreword of the Chairman",
      paragraph1: "On behalf of the Commissioners, Management and all the employees of the Judicial Service Commission, I am happy to invite all citizens to visit the website of the Judicial Service Commission established with aim of informing the public about the existence of various activities and duties performed by the Commission.",
      paragraph2: "The responsibilities of the Judicial Service Commission are outlined under Article 113(1) of the Constitution of the United Republic of Tanzania and section 29 of the Judiciary Management Act Number 4 of 2011.",
      readMore: "Read More",
      sincerely: "Sincerely,",
      chairmanName: "George Mcheche Masaju",
      chairmanTitle: "Chairman, Judicial Service Commission"
    }
  };

  const t = translations[language];

  return (
    <div className="p-1">
      <div className="row justify-content-center">
        {/* Left Column - Image */}
        <div className="col-10 col-md-6 col-lg-4">
          <div className="">
            <div className="d-flex flex-column justify-content-center align-items-center text-center mt-lg-5 ps-lg-4">
              {/* Chairman Image */}
              <div className="">
                <img 
                  src={`${webMediaURL}/website-repository/leadersprofilepictures/2025/1/chairman.png`} 
                  alt={language === 'sw' ? "Mwenyekiti wa Tume ya Utumishi wa Mahakama" : "Chairman of Judicial Service Commission"} 
                  className="img-fluid rounded-3 mt-4"
                  style={{ width: '250px', height: '250px', objectFit: 'cover' }}
                  onError={(e) => {
                    e.target.src = 'https://via.placeholder.com/250/ED1F2C/FFFFFF?text=Chairman';
                  }}
                />
              </div>
            </div>
          </div>
        </div>

        {/* Right Column - Paragraph Content */}
        <div className="col-md-8 col-lg-8">
          <div className="border-0">
            <div className="card-body py-4 ps-2 pe-4 ps-md-4 ps-sm-4">
              <h4 className="card-title text-dark mb-4 border-bottom pb-1 text-lg-start text-center">
                {t.title}
              </h4>
              
              <div className="content text-justify">
                <p className="text-dark mb-4">
                  {t.paragraph1}
                </p>
                
                <p className="text-dark mb-4">
                  {t.paragraph2}
                  <span>
                    <Link to="#">  
                      <strong>
                        <i> {t.readMore}</i>
                      </strong>
                    </Link>
                  </span>
                </p>           
                
                <div className="mt-4 pt-1 border-top text-lg-start text-center">
                  <p className="text-dark fw-semibold mb-1">{t.sincerely}</p>
                  <p className="text-dark fw-bold mb-0">{t.chairmanName}</p>
                  <p className="text-muted small mb-0">{t.chairmanTitle}</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ChairManGreetings;