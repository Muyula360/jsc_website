import { useContext } from 'react';
import { Link } from 'react-router-dom';
import { LanguageContext } from '../context/Language'; // Adjust path as needed
import AnnouncementsHighlight from './AnnouncementsHighlight'
import ChairManGreetings from './ChairManGreetings';
import MissionVision from './missionVision';
import HotubaHighlights from './HotubaHighlights';
import VacancyHighlights from './VacancyHighlights';

// collection UI
const Collection = () => {
  const { language } = useContext(LanguageContext);
  
  const webUrl = import.meta.env.VITE_API_WEBURL;
  const iconsPath = webUrl+'/src/assets/icons';

  // Translation object for tab labels
  const translations = {
    sw: {
      chairmanGreetings: "Salamu za Mwenyekiti",
      secretaryGreetings: "Salamu za Katibu",
      missionVision: "Dira na Dhima",
      speeches: "Hotuba",
      jobOpportunities: "Nafasi za Kazi"
    },
    en: {
      chairmanGreetings: "Chairman's Greetings",
      secretaryGreetings: "Secretary's Greetings",
      missionVision: "Mission & Vision",
      speeches: "Speeches",
      jobOpportunities: "Vacancies"
    }
  };

  const t = translations[language];

  return (
    <section id="" className="bg-transparent my-5">
      <div className="container">
        <div className="row gx-4">
          <div className="col-lg-9 col-md-12 mb-sm-3 col-12">
            <div className="w-100" data-aos="fade-left" data-aos-duration="1500">    
              <ul 
                className="nav nav-pills mb-3 custom-tabs justify-content-center justify-content-lg-start w-100" 
                id="custom-tabs" 
                role="tablist"
              >
                <li className="nav-item" role="presentation">
                  <button
                    className="nav-link active"
                    id="casestatistics-tab"
                    data-bs-toggle="tab"
                    data-bs-target="#casestatistics-tab-pane"
                    type="button"
                    role="tab"
                  >
                    {t.chairmanGreetings}
                  </button>
                </li>
{/* 
                <li className="nav-item" role="presentation">
                  <button
                    className="nav-link"
                    id="judgement-tab"
                    data-bs-toggle="tab"
                    data-bs-target="#judgement-tab-pane"
                    type="button"
                    role="tab"
                  >
                    {t.secretaryGreetings}
                  </button>
                </li> */}

                <li className="nav-item" role="presentation">
                  <button
                    className="nav-link"
                    id="judiciarymap-tab"
                    data-bs-toggle="tab"
                    data-bs-target="#judiciarymap-tab-pane"
                    type="button"
                    role="tab"
                  >
                    {t.missionVision}
                  </button>
                </li>

                <li className="nav-item" role="presentation">
                  <button
                    className="nav-link"
                    id="projects-tab"
                    data-bs-toggle="tab"
                    data-bs-target="#projects-tab-pane"
                    type="button"
                    role="tab"
                  >
                    {t.speeches}
                  </button>
                </li>

                <li className="nav-item" role="presentation">
                  <button
                    className="nav-link"
                    id="tender-tab"
                    data-bs-toggle="tab"
                    data-bs-target="#tender-tab-pane"
                    role="tab"
                  >
                    {t.jobOpportunities}
                  </button>
                </li>
              </ul>
            </div>

            <div className="tab-content w-100" id="collectionContent" data-aos="fade-right" data-aos-duration="1500">
              <div className="tab-pane fade show active" id="casestatistics-tab-pane" role="tabpanel" aria-labelledby="casestatistics-tab" tabIndex="0">
                <div className='card-pane border-0 py-2 w-100'>
                  <ChairManGreetings />     
                </div>
              </div>
              {/* <div className="tab-pane fade" id="judgement-tab-pane" role="tabpanel" aria-labelledby="judgement-tab" tabIndex="0">    
                <div className='card-pane border-0 px-3 py-4'>
                  <JudgmentsHighlight />
                </div>
              </div> */}
              <div className="tab-pane fade" id="judiciarymap-tab-pane" role="tabpanel" aria-labelledby="judiciarymap-tab" tabIndex="0">
                <div className='card-pane border-0 px-3 py-4'>
                  <MissionVision />
                </div>
              </div>
              <div className="tab-pane fade" id="projects-tab-pane" role="tabpanel" aria-labelledby="projects-tab" tabIndex="0">
                <div className='card-pane border-0 px-3 pt-4'>
                  <HotubaHighlights />
                </div>
              </div>
              <div className="tab-pane fade" id="tender-tab-pane" role="tabpanel" aria-labelledby="tender-tab" tabIndex="0">
                <div className='card-pane border-0 px-3 py-4'>
                  <VacancyHighlights />
                </div>
              </div>      
            </div>
          </div>
          <div className="col-lg-3 col-md- mt-2">
            <div data-aos="fade-up" data-aos-delay="300">
              <AnnouncementsHighlight />
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}

export default Collection;