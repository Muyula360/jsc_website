import { Link } from "react-router-dom";


const LeaderProfile = ({ leaderDetails, isLoading, isError, isSuccess, index, totalLeaders }) => {

  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;
  const defaultAvatar = "/userProfilePic.png";
  const profileImage = leaderDetails?.profile_pic_path ? `${webMediaURL}/${leaderDetails.profile_pic_path}` : defaultAvatar;

  // Determine AOS animation based on position
  let aosType = "fade-up";

  if (index === 0) {
    aosType = "fade-left";
  } else if (index === totalLeaders - 1) {
    aosType = "fade-right";
  }

  return (
    <div className="leaders-card card p-0 border-0 shadow-sm rounded-3" data-aos={aosType} data-aos-delay="300" >

      {/* Loading */}
      {isLoading && (
        <div className="placeholder-glow">
          <div className="card-img-top placeholder rounded-top-3" style={{ height: '250px' }}></div>
          <div className="card-body px-4">
            <h6 className="placeholder col-6 mb-2"></h6>
            <p className="placeholder col-4 mb-1"></p>
            <p className="placeholder col-7"></p>
          </div>
        </div>
      )}

      {/* Error */}
      {isError && (
        <div className="alert alert-danger text-center m-3" role="alert">
          Failed to load leader profile. Please try again later.
        </div>
      )}

      {/* Success */}
      {isSuccess && leaderDetails && (
        <>
          <div className="image-container">
            <img className="card-img-top rounded-top-3" src={profileImage} alt={`${leaderDetails?.fullname || 'Leader'} profile`} style={{ opacity: leaderDetails?.profile_pic_path ? 1 : 0.2, transition: 'opacity 0.3s ease-in-out' }} onError={(e) => { e.target.onerror = null; e.target.src = defaultAvatar; e.target.style.opacity = 0.2;}} />
            <div className="overlay">
              <Link to={`biography/${leaderDetails.leadersTitleID}`} className="see-bio-btn">
                See Biography
              </Link>
            </div>
          </div>

          <div className="card-body px-4">
            <h6 className="text-heading fw-semibold mb-1">{leaderDetails.fullname}</h6>
            <span className="text-heading-secondary" style={{ fontSize: '14px' }}>
              {leaderDetails.title}
            </span>
            <p className="text-black-50" style={{ fontSize: '13px' }}>
              <i className="bi bi-envelope me-1"></i> {leaderDetails.status}
            </p>
          </div>
        </>
      )}
    </div>
  );
};

export default LeaderProfile;