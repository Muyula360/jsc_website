// src/components/HotubaHighlights.jsx
import React, { useEffect, useContext } from 'react';
import { Link } from 'react-router-dom';
import { useDispatch, useSelector } from "react-redux";
import { getSpeeches } from "../features/speechSlice";
import { formatDate } from '../utils/dateUtils';
import { LanguageContext } from '../context/Language';
import { useSearch } from '../context/searchContext';

const HotubaHighlights = () => {
  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;
  const dispatch = useDispatch();

  const { language } = useContext(LanguageContext);
  const { registerContent, unregisterContent, searchableContent } = useSearch();

  const translations = {
    sw: {
      header: "Hotuba Mbalimbali",
      viewMore: "Angalia Zaidi",
      loading: "Inapakia ...",
      retrievingSpeeches: "Inaleta hotuba mbalimbali",
      errorTitle: "Hitilafu 521",
      errorSubtitle: "Seva ya wavuti haifanyi kazi",
      errorMessage: "Tunapata shida kuunganisha na seva. Tafadhali jaribu tena baadaye.",
      viewPDF: "Tazama PDF",
      noPDFSpeeches: "Hakuna hotuba zilizo na PDF.",
      downloadPDF: "Pakua PDF",
      noDataTitle: "Hakuna Hotuba",
      noDataMessage: "Bado hakuna hotuba zilizopakiwa. Zitakuwa zinapatikana hivi karibuni.",
      uploadPrompt: "Tafadhali pakia hotuba mpya",
      comingSoon: "Inakuja hivi karibuni",
      existingNoPDF: "Hotuba zilizopo hazina viambatanisho vya PDF."
    },
    en: {
      header: "Various Speeches",
      viewMore: "View More",
      loading: "Loading ...",
      retrievingSpeeches: "Retrieving speeches",
      errorTitle: "Error 521",
      errorSubtitle: "Web server is down",
      errorMessage: "We are having trouble connecting to the server. Please try again later.",
      viewPDF: "View PDF",
      noPDFSpeeches: "No speeches with PDF available.",
      downloadPDF: "Download PDF",
      noDataTitle: "No Speeches",
      noDataMessage: "No speeches have been uploaded yet. They will be available soon.",
      uploadPrompt: "Please upload new speeches",
      comingSoon: "Coming soon",
      existingNoPDF: "Existing speeches do not have PDF attachments."
    }
  };

  const t = translations[language] || translations.sw;

  // Get speeches from Redux
  const { speeches, isLoading, isSuccess } = useSelector((state) => {
    console.log('Redux state:', state); // Log entire Redux state
    return {
      speeches: state.speech?.speeches,
      isLoading: state.speech?.isLoading,
      isSuccess: state.speech?.isSuccess
    };
  });

  // Fetch speeches
  useEffect(() => {
    console.log('📡 Dispatching getSpeeches...');
    dispatch(getSpeeches());
  }, [dispatch]);

  // Log when speeches data changes
  useEffect(() => {
    console.log('📊 Speeches data changed:', {
      hasSpeeches: !!speeches,
      speechesLength: speeches?.length,
      isLoading,
      isSuccess,
      speeches: speeches
    });
  }, [speeches, isLoading, isSuccess]);

  // Register speeches for search when data loads
  useEffect(() => {
    console.log('🔍 Registration useEffect triggered:', {
      isSuccess,
      hasSpeeches: speeches && speeches.length > 0,
      speechesCount: speeches?.length
    });

    if (isSuccess && speeches && speeches.length > 0) {
      console.log('📢 Attempting to register', speeches.length, 'speeches for search...');
      
      speeches.forEach((speech, index) => {
        // Create searchable content for each speech
        const searchContent = {
          id: `speech-${speech.announcementID || index}`,
          title: speech.announcementTitle || 'Untitled',
          content: `${speech.announcementTitle || ''} ${speech.announcementDesc || ''}`,
          category: "Speeches",
          tags: ["speech", "hotuba", speech.hasAttachment ? "pdf" : "no-pdf"],
          path: "/speeches",
          date: speech.postedAt
        };
        
        console.log(`📝 Registering speech ${index + 1}:`, searchContent.title);
        registerContent(searchContent);
      });

      // Check what's in searchableContent after registration
      setTimeout(() => {
        console.log('📚 Searchable content after registration:', searchableContent);
      }, 500);
    }

    // Cleanup
    return () => {
      if (speeches && speeches.length > 0) {
        console.log('🧹 Cleaning up speeches registration');
        speeches.forEach((speech, index) => {
          unregisterContent(`speech-${speech.announcementID || index}`);
        });
      }
    };
  }, [isSuccess, speeches, registerContent, unregisterContent, searchableContent]);

  const getPDFUrl = (attachmentPath) => {
    if (!attachmentPath || !webMediaURL) return "#";
    const baseUrl = webMediaURL.endsWith('/') ? webMediaURL : `${webMediaURL}/`;
    const cleanPath = attachmentPath.startsWith('/') ? attachmentPath.slice(1) : attachmentPath;
    return `${baseUrl}${cleanPath}`;
  };

  const speechesWithPDF = speeches ? speeches.filter(speech => 
    speech.hasAttachment && speech.attachmentPath
  ) : [];

  const hasAnySpeeches = speeches && speeches.length > 0;
  const hasPDFSpeeches = speechesWithPDF.length > 0;

  return (
    <div className="card-">
      <div className="card-body">
        <div className="d-flex justify-content-between mb-4">
          <h6 className='text-heading'>
            <i className="bi bi-activity text-accent me-2"></i><b>{t.header}</b>
          </h6>
          {hasPDFSpeeches && (
            <Link className="icon-link icon-link-hover fs-16" to="/speeches">
              <b>{t.viewMore}</b> <i className="bi bi-arrow-right"></i>
            </Link>
          )}
        </div>

        <div className="list-group list-group-flush">
          {isLoading ? (
            <div className="d-flex flex-column justify-content-center align-items-center py-5 bg-light rounded-2">
              <span
                className="spinner-border spinner-border-sm"
                style={{ width: '1.5rem', height: '1.5rem' }}
              ></span>
              <div className="text-center my-4">
                <h6 className="text-heading">{t.loading}</h6>
                <p className="text-heading-secondary fs-12">{t.retrievingSpeeches}</p>
              </div>
            </div>
          ) : isSuccess ? (
            hasPDFSpeeches ? (
              speechesWithPDF.slice(0, 4).map((speech) => (
                <div key={speech.announcementID} className="mb-2">
                  <a 
                    href={getPDFUrl(speech.attachmentPath)} 
                    title={`${speech.announcementTitle} - ${t.downloadPDF}`} 
                    target="_blank" 
                    rel="noopener noreferrer"
                    className="text-decoration-none d-block"
                  >
                    <div className="card-pane list-group-item list-group-item-action d-flex justify-content-between align-items-center py-3 px-4 mb-1 hover-shadow">
                      <div className="image d-flex align-items-center me-3">
                        <i className='bi bi-file-earmark-pdf-fill fs-1 text-danger'></i>
                      </div>

                      <div className="center flex-grow-1 px-3" style={{ minWidth: 0 }}>
                        <h5 
                          className="text-heading-primary fs-16 text-truncate" 
                          style={{ 
                            overflow: 'hidden',
                            textOverflow: 'ellipsis',
                            whiteSpace: 'nowrap',
                            lineHeight: '1.5'
                          }}
                          title={speech.announcementTitle}
                        >
                          {speech.announcementTitle}
                        </h5>
                        <div className="d-flex flex-column">
                          <span className="text-danger fs-14 mb-1">
                            {speech.announcementDesc} - {formatDate(speech.postedAt)}
                          </span>
                        </div>
                      </div>

                      <div className="end d-flex align-items-center ms-2">
                        <i className="bi bi-box-arrow-up-right text-danger fs-5"></i>
                      </div>
                    </div>
                  </a>
                </div>
              ))
            ) : hasAnySpeeches ? (
              <div className="text-center py-4">
                <div className="mb-3">
                  <i className="bi bi-file-earmark-x text-warning fs-1"></i>
                </div>
                <h6 className="text-heading mb-2">{t.noPDFSpeeches}</h6>
                <p className="text-muted small mb-0">
                  {t.existingNoPDF}
                </p>
              </div>
            ) : (
              <div className="text-center py-5">
                <div className="mb-3">
                  <i className="bi bi-file-earmark-pdf text-muted fs-1 opacity-50"></i>
                </div>
                <h6 className="text-heading mb-2">{t.noDataTitle}</h6>
                <p className="text-muted small mb-3">{t.noDataMessage}</p>
                <div className="d-flex justify-content-center">
                  <span className="badge bg-light text-muted px-3 py-2">
                    <i className="bi bi-clock-history me-1"></i>
                    {t.comingSoon}
                  </span>
                </div>
              </div>
            )
          ) : (
            <div className="alert alert-info text-center border-0 w-100 py-4">
              <div className="m-auto p-3 w-75 text-danger" style={{ backgroundColor: 'transparent' }}>
                <h5 className="card-title fw-semibold">{t.errorTitle}</h5>
                <h6 className="card-title fw-semibold mb-3">{t.errorSubtitle}</h6>
                <p className="text-secondary fs-13">{t.errorMessage}</p>
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default HotubaHighlights;