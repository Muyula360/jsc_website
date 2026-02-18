import { Link } from 'react-router-dom';
import { useEffect, useContext } from 'react';
import { useDispatch, useSelector } from 'react-redux';

import { formatDate } from '../utils/dateUtils';
import { capitalize } from '../utils/stringManipulation';
import { getAnnouncements } from "../features/announcementSlice";
import { LanguageContext } from '../context/Language'; // adjust path as needed

const AnnouncementsHighlight = () => {
  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

  const dispatch = useDispatch();
  const { announcements, isLoading, isSuccess, isError, message } = useSelector(
    (state) => state.announcements
  );

  // Language context
  const { language } = useContext(LanguageContext);

  // Translations (Swahili is the default)
  const translations = {
    sw: {
      header: "Matangazo Mbalimbali",
      loading: "Inapakia ...",
      retrievingAnnouncements: "Inaleta matangazo",
      errorTitle: "Hitilafu 521",
      errorSubtitle: "Seva ya wavuti haifanyi kazi",
      errorMessage: "Tunapata shida kuunganisha na seva. Tafadhali jaribu tena baadaye.",
      viewMore: "Angalia Zaidi",
      postedBy: "Mfumo"
    },
    en: {
      header: "Announcements",
      loading: "Loading ...",
      retrievingAnnouncements: "Retrieving announcements",
      errorTitle: "Error 521",
      errorSubtitle: "Web server is down",
      errorMessage: "We are having trouble connecting to the server. Please try again later.",
      viewMore: "View More",
      postedBy: "System"
    }
  };

  // Use Swahili as fallback if language is missing or invalid
  const t = translations[language] || translations.sw;

  // when announcement component loads dispatch getAnnouncements (fetch announcements from API)
  useEffect(() => {
    dispatch(getAnnouncements());
  }, [dispatch]);

  // handle announcement click (when user clicks an announcement)
  const handleClick = (announcement) => {
    if (announcement.hasAttachment && announcement.attachmentPath) {
      const fullPath = `${webMediaURL}/${announcement.attachmentPath}`;
      window.open(fullPath, "_blank");
    }
  };

  // announcement component UI
  return (
    <>
      <h5 className="fw-bold text-dark text-center mb-4">{t.header}</h5>

      <div className="card-pane border-0 rounded-3 px-1 pt-3 mb-0">
        <div className="card-body">
          <div className="list-group list-group-flush">
            {isLoading ? (
              <div className="d-flex flex-column justify-content-center align-items-center py-5 bg-light rounded-2">
                <span
                  className="spinner-border spinner-border-sm"
                  style={{ width: '1.5rem', height: '1.5rem' }}
                ></span>
                <div className="text-center my-4">
                  <h6 className="text-heading">{t.loading}</h6>
                  <p className="text-heading-secondary fs-12">{t.retrievingAnnouncements}</p>
                </div>
              </div>
            ) : isSuccess ? (
              announcements && announcements.slice(0, 4).map((announcement, index) => {
                const attachmentUrl = announcement.attachmentPath
                  ? `${webMediaURL}/${announcement.attachmentPath}`
                  : '#';

                return (
                  <div key={index}>
                    <Link
                      to={attachmentUrl}
                      title={announcement.announcementTitle}
                      target="_blank"
                      rel="noopener noreferrer"
                      onClick={() => handleClick(announcement)}
                    >
                      <div className="list-group-item list-group-item-action my-1 card-pane">
                        <div className="d-flex gap-3">
                          <div>
                            <i className="bi bi-megaphone-fill text-danger megaphone-tilted fs-24"></i>
                          </div>
                          <div className="announcement-card">
                            <h5 className="fs-16 mb-2 announcement-climp">
                              {capitalize(announcement.announcementTitle)}
                            </h5>
                            <small className="small text-danger fs-12">
                              {formatDate(announcement.postedAt)}
                            </small>
                          </div>
                        </div>
                      </div>
                    </Link>
                  </div>
                );
              })
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

      <div className="text-end mt-0">
        <Link className="icon-link icon-link-hover fw-bold" to="/announcements">
          {t.viewMore} <i className="bi bi-arrow-right"></i>
        </Link>
      </div>
    </>
  );
};

export default AnnouncementsHighlight;
