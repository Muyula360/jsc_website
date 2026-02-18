import { Link } from 'react-router-dom';
import { useState, useEffect, useContext } from 'react';
import { useDispatch, useSelector } from "react-redux";
import { LanguageContext } from "../context/Language";
import NewsHighlights from '../components/NewsHighlights';

import { getFAQs } from '../features/faqsSlice'; // Import the action

const Faqs = () => {
  const dispatch = useDispatch();
  const { language } = useContext(LanguageContext);

  // FAQ state from Redux slice
  const { 
    faqs = [], 
    isLoading = false,
    isSuccess = false,
    isError = false,
    message = ""
  } = useSelector((state) => state.faqs || {});

  const [openQuestion, setOpenQuestion] = useState(null);

  /* ================= TRANSLATIONS ================= */
  const translations = {
    en: {
      home: "Home",
      faqTitle: "Frequently Asked Questions",
      loading: "Loading ...",
      retrievingFaqs: "Retrieving frequently asked questions",
      errorTitle: "Unable to Load FAQs",
      errorSubtitle: "Connection Issue",
      errorMessage: "We are having trouble connecting to the server. Please try again later.",
      noFaqs: "No frequently asked questions available at the moment.",
      error: "Failed to load FAQs. Please try again later.",
      checkBackLater: "Check back later for new FAQs.",
      comingSoon: "Coming soon",
      answer: "Answer",
      retry: "Retry"
    },
    sw: {
      home: "Mwanzo",
      faqTitle: "Maswali Yanayoulizwa Mara Kwa Mara",
      loading: "Inapakia ...",
      retrievingFaqs: "Inaleta maswali yanayoulizwa mara kwa mara",
      errorTitle: "Imeshindwa Kupakia Maswali",
      errorSubtitle: "Tatizo la Muunganisho",
      errorMessage: "Tunapata shida kuunganisha na seva. Tafadhali jaribu tena baadaye.",
      noFaqs: "Hakuna maswali yanayoulizwa mara kwa mara kwa sasa.",
      error: "Imeshindwa kupakia maswali. Tafadhali jaribu tena baadaye.",
      checkBackLater: "Angalia tena baadaye kwa maswali mapya.",
      comingSoon: "Inakuja hivi karibuni",
      answer: "Jibu",
      retry: "Jaribu Tena"
    },
  };

  const t = translations[language] || translations.en;

  /* ================= FETCH FAQS ON COMPONENT MOUNT ================= */
  useEffect(() => {
    dispatch(getFAQs());
  }, [dispatch]); // Removed language dependency since FAQs are not language-specific in your schema

  /* ================= FILTER FAQS ================= */
  const getFilteredFaqs = () => {
    if (!faqs || faqs.length === 0) return [];
    
    // Your FAQ schema doesn't have language-specific fields or is_active
    // Just return the FAQs as they are
    return faqs.map((faq, index) => ({
      id: faq.faqsID || index,
      question: faq.question || "",
      answer: faq.answer || "",
      postedBy: faq.postedBy,
      worktStation: faq.worktStation,
      postedAt: faq.postedAt
    }));
  };

  const filteredFaqs = getFilteredFaqs();

  /* ================= FAQ TOGGLE HANDLER ================= */
  const toggleQuestion = (id) => {
    if (openQuestion === id) {
      setOpenQuestion(null);
    } else {
      setOpenQuestion(id);
    }
  };

  /* ================= RETRY HANDLER ================= */
  const handleRetry = () => {
    dispatch(getFAQs());
  };

  return (
    <>
      {/* ================= PAGE BANNER ================= */}
      <div className="position-relative">
        <div className="page-banner text-center">
          <div className="container d-flex flex-column justify-content-center" style={{ height: "130px" }} >
            <h2 className="text-white fw-bold my-1">{t.faqTitle}</h2>
            <ol className="breadcrumb mt-2 justify-content-center">
              <li className="breadcrumb-item"><Link to="/">{t.home}</Link> </li>
              <li className="breadcrumb-item active">{t.faqTitle} </li>
            </ol>
          </div>
        </div>
      </div>

      <div className="container my-5">
        <div className="row justify-content-center">
          <div className="col-lg-8">
            <h4 className='fw-bold mb-5'>{t.faqTitle}</h4>
            
            {/* ================= FAQ SECTION ================= */}
            <div className="card-pane border-0 rounded-3 px-1 mt-4 pt-3 mb-0">
              <div className="card-body">
                <div className="list-group list-group-flush">
                  {/* Loading State */}
                  {isLoading ? (
                    <div className="d-flex flex-column justify-content-center align-items-center py-5 bg-light rounded-2">
                      <span
                        className="spinner-border text-danger"
                        style={{ width: '2.5rem', height: '2.5rem' }}
                      ></span>
                      <div className="text-center my-4">
                        <h6 className="text-heading fw-semibold">{t.loading}</h6>
                        <p className="text-muted small">{t.retrievingFaqs}</p>
                      </div>
                    </div>
                  ) : isError ? (
                    /* Error State */
                    <div className="text-center py-5">
                      <div className="mb-4">
                        <div className="bg-danger bg-opacity-10 rounded-circle p-4 d-inline-block">
                          <i className="bi bi-exclamation-triangle-fill text-danger fs-1"></i>
                        </div>
                      </div>
                      <h5 className="fw-bold text-danger mb-2">{message || t.errorTitle}</h5>
                      <p className="text-muted mb-3">{t.errorMessage}</p>
                      <button 
                        className="btn btn-outline-danger rounded-5 px-4"
                        onClick={handleRetry}
                      >
                        <i className="bi bi-arrow-repeat me-2"></i>
                        {t.retry}
                      </button>
                    </div>
                  ) : filteredFaqs.length > 0 ? (
                    /* FAQ List */
                    <div className="accordion" id="faqAccordion">
                      {filteredFaqs.map((faq, index) => (
                        <div className="accordion-item border rounded-3 m-2 shadow-sm" key={faq.id}>
                          <h2 className="accordion-header">
                            <button
                              className={`accordion-button ${openQuestion === faq.id ? '' : 'collapsed'}`}
                              type="button"
                              onClick={() => toggleQuestion(faq.id)}
                              style={{
                                fontWeight: '600',
                                fontSize: '1rem',
                                padding: '1.2rem 1.5rem',
                                backgroundColor: openQuestion === faq.id ? '#fff9f9' : 'white',
                                border: 'none',
                                boxShadow: 'none',
                                color: openQuestion === faq.id ? '#dc3545' : '#212529'
                              }}
                            >
                              <span className="me-3 text-muted fw-normal">Q{index + 1}.</span>
                              {faq.question}
                            </button>
                          </h2>
                          <div
                            className={`accordion-collapse bg-info collapse ${openQuestion === faq.id ? 'show' : ''}`}
                          >
                            <div className="accordion-body py-4 px-4" 
                                style={{ 
                                  backgroundColor: '#fafafa',
                                  borderTop: '1px solid #f0f0f0'
                                }}>
                              <div className="d-flex">
                                <div className="flex-shrink-0 me-3">
                                  <span className="badge bg-danger rounded-circle d-flex align-items-center justify-content-center" 
                                        style={{ width: '28px', height: '28px', fontSize: '0.75rem' }}>
                                    A
                                  </span>
                                </div>
                                <div className="flex-grow-1">
                                  <p className="mb-0" style={{ 
                                    lineHeight: '1.7', 
                                    whiteSpace: 'pre-line',
                                    color: '#495057'
                                  }}>
                                    {faq.answer}
                                  </p>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      ))}
                    </div>
                  ) : (
                    /* No FAQs State */
                    <div className="text-center py-5">
                      <div className="mb-3">
                        <div className="bg-light rounded-circle p-4 d-inline-block">
                          <i className="bi bi-question-circle text-muted fs-1 opacity-50"></i>
                        </div>
                      </div>
                      <h6 className="fw-semibold mb-2">{t.noFaqs}</h6>
                      <p className="text-muted small mb-4">{t.checkBackLater}</p>
                      <span className="badge bg-light text-muted px-3 py-2">
                        <i className="bi bi-clock-history me-1"></i>
                        {t.comingSoon}
                      </span>
                    </div>
                  )}
                </div>
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

export default Faqs;