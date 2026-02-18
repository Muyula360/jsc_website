import React, { useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";
import { getContenthighlights } from '../features/contenthighlightSlice';
import WeeklyVisitTrends from "../components/WeeklyVisitTrends";

// Reusable statistic card component
const HighlightCard = ({ icon, label, value, loading }) => (
  <div className="statistics-item text-center">
    {loading ? (
      <div className="mb-3">
        <span className="spinner-border text-light" aria-hidden="true"></span>
      </div>
    ) : (
      <>
        <span className="h5 mb-3 d-block"> <i className={`bi ${icon}`}></i> </span>
        <h2 className="fw-semibold">{value}</h2>
      </>
    )}
    <label className="fs-15">{label}</label>
  </div>
);

const ContentsMgrHome = () => {

  const dispatch = useDispatch();

  const { contenthighlights, isLoading, isSuccess } = useSelector((state) => state.contenthighlights);

  // Dispatch fetch action when Dashboard (Home) loads
  useEffect(() => {
    dispatch(getContenthighlights());
  }, [dispatch]);

  // Get the actual highlight data or provide fallback to avoid crash
  const stats = isSuccess && contenthighlights.length > 0 ? contenthighlights[0] : {};

  return (
    <>
      <div className="container-fluid mb-5 ">
        <h5><strong>Dashboard</strong></h5>

        {/* Top highlight cards */}
        <div className="row grid-margin mt-4">
          <div className="col-12">
            <div className="card bg-accent text-light border-0">
              <div className="card-body">
                <div className="d-flex flex-column flex-md-row align-items-center justify-content-between px-3 flex-wrap gap-4">
                  <HighlightCard icon="bi-fire" label="News & Updates" value={stats.news} loading={!isSuccess} />
                  <HighlightCard icon="bi-megaphone" label="Announcements" value={stats.announcements} loading={!isSuccess} />
                  <HighlightCard icon="bi-file-earmark-text" label="Newsletters" value={stats.newsletters} loading={!isSuccess} />
                  <HighlightCard icon="bi-mortarboard" label="Vacancies" value={stats.vacancies} loading={!isSuccess} />
                  <HighlightCard icon="bi-briefcase" label="Tenders" value={stats.tenders} loading={!isSuccess} />
                  <HighlightCard icon="bi-chat-text" label="Feedbacks" value={stats.feedbacks} loading={!isSuccess} />
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Charts and Trends */}
        <div className="row">

          {/* Website Visit Trends */}
          <div className="col-md-6 grid-margin stretch-card">
            <WeeklyVisitTrends />
          </div>

          {/* Website Engagements */}
          <div className="col-md-6 grid-margin stretch-card">
            <div className="card hover-border">
              <div className="card-body">
                <h5 className="card-title"><i className="bi bi-link-45deg me-1"></i> Engagements</h5>
                <canvas id="sales-chart"></canvas>
                <h6 className="mt-5"> 56000 <span className="text-muted h6 font-weight-normal">Engages</span></h6>
              </div>
            </div>
          </div>

        </div>
      </div>
    </>
  );
};

export default ContentsMgrHome;