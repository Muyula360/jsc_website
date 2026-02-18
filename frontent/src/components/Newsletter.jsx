import { Link } from 'react-router-dom';
import { useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';

import { getNewsletters } from "../features/newsLetterSlice";

const Newsletter = () => {
  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;
  const dispatch = useDispatch();
  const { newsletters, isLoading, isSuccess, isError, message } = useSelector(state => state.newsletters);

  useEffect(() => {
    dispatch(getNewsletters());
  }, [dispatch]);

  const handleDownload = (newsletter) => {
    if (newsletter?.newsletterPath) {
      const fullPath = `${webMediaURL}/${newsletter.newsletterPath}`;
      window.open(fullPath, "_blank");
    }
  };

  return (
    <div className="card border-0 shadow-sm py-4 px-2 mx-2 rounded-3">
      <div className="card-header bg-transparent border-0 mb-2">
        <h5 className="text-dark-accent fw-bold mb-1 w-75">Stay Updated with Our Newsletter</h5>
      </div>

      {/* Loading Placeholder */}
      {isLoading && (
        <div className="placeholder-glow m-3">
          <div className="placeholder w-100 mb-3" style={{ height: "250px", borderRadius: "0.5rem" }}></div>
          <h6 className="placeholder col-6 mb-2"></h6>
          <p className="placeholder col-4 mb-3"></p>
          <div className="d-flex justify-content-between">
            <span className="placeholder col-4"></span>
            <span className="placeholder col-2"></span>
          </div>
        </div>
      )}

      {/* Error Message */}
      {isError && (
        <div className="alert alert-danger text-center mx-3 my-4" role="alert">
          <h6 className="fw-bold mb-1">Failed to Load Newsletter</h6>
          <p className="mb-0">{message || 'An unexpected error occurred while fetching newsletter data.'}</p>
        </div>
      )}

      {/* Newsletter Content */}
      {isSuccess && newsletters?.length > 0 && (
        <>
          <div className="card-body py-1" style={{ height: '320px', overflow: 'hidden' }}>
            <img
              src={`${webMediaURL}/${newsletters[0].newsletterCoverPath}`}
              className="card-img rounded-0"
              style={{ height: '100%', objectFit: 'cover', objectPosition: 'top' }}
              alt={`Newsletter Cover ${newsletters[0].newsletterNo}`}
            />
          </div>
          <div className="card-footer bg-transparent border-0">
            <h6 className="fw-bold mb-1">Haki Bulletin Toleo No. <span>{newsletters[0].newsletterNo}</span></h6>
            <small className="text-heading-secondary">
              {`${newsletters[0].newsletterMonth}, ${newsletters[0].newsletterYear}`}
            </small>
            <div className="d-flex justify-content-between newsletter-links mt-3">
              <Link className="link-primary link-offset-2 link-underline link-underline-opacity-0" onClick={() => handleDownload(newsletters[0])} >
                <i className="bi bi-download"></i> Get Newsletter
              </Link>
              <Link className="icon-link icon-link-hover fw-bold" to="newsletter"> See More <i className="bi bi-arrow-right"></i></Link>
            </div>
          </div>
        </>
      )}

      {/* No Newsletters */}
      {isSuccess && newsletters?.length === 0 && (
        <div className="my-4 px-3">
          <h6 className="fw-bold">No newsletters available</h6>
          <span className="text-muted fs-14">Please check back later for updates.</span>
        </div>
      )}
    </div>
  );
};

export default Newsletter;