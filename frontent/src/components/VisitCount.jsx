import { useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';

import VisitCounter from './VisitCounter';
import { getWebsiteVisitStats } from "../features/websiteVisitSlice";

const VisitCount = () => {
  
  const dispatch = useDispatch();
  const { websiteVisits, isLoading, isSuccess, isError, message } = useSelector(state => state.websiteVisit);

  useEffect(() => {
    dispatch(getWebsiteVisitStats());
  }, [dispatch]);

  const renderCard = (id, count, label, loading) => (
    <div className="card visit-count-card text-center py-2 rounded-4" style={{ width: '10rem' }}>
      <div className="card-body">
        {loading ? (
          <>
            <div className="placeholder-glow mb-2">
              <span className="placeholder col-6 rounded"></span>
            </div>
            <span className="placeholder col-8"></span>
          </>
        ) : (
          <>
            <VisitCounter id={id} visitcount={count} />
            <hr className="border-3 border-danger w-25 mx-auto my-4" />
            <span className="card-text">{label}</span>
          </>
        )}
      </div>
    </div>
  );

  const cards = (isSuccess && websiteVisits?.length > 0)
    ? websiteVisits.map((visit, index) => (
        <div className="d-flex justify-content-center gap-4 flex-wrap" key={index}>
          {renderCard("today_counts", visit.today_visits, "Today Visitors", false)}
          {renderCard("week_counts", visit.this_week_visits, "This Week", false)}
          {renderCard("month_counts", visit.this_month_visits, "This Month", false)}
          {renderCard("year_counts", visit.this_year_visits, "This Year", false)}
        </div>
      ))
    : (
        <div className="d-flex justify-content-center gap-4 flex-wrap">
          {renderCard("", 0, "Today Visitors", true)}
          {renderCard("", 0, "This Week", true)}
          {renderCard("", 0, "This Month", true)}
          {renderCard("", 0, "This Year", true)}
        </div>
      );

  return (
    <section className='visit-count-section-bg'>
      <div className="container visit-count-content">
        <div className='section-title text-center p-3 pb-4 '>
          <h3 className='text-accent fw-bold my-3' data-aos="fade-down" data-aos-duration="1500">Website Visit Count</h3>
          <span>
            Here is an analytical overview of our website traffic, displaying the number of visits recorded daily, weekly, monthly, and annually. These numbers reflect the growing interest and interactions from our valued users like you. Keep exploring, and thank you for being part of our journey!
          </span>
        </div>

        <div data-aos="fade-up" data-aos-duration="1500">
          {cards}
        </div>

        {isError && (
          <div className="alert alert-danger text-center mt-4">
            Failed to load visit data: {message}
          </div>
        )}
      </div>
    </section>
  );
};

export default VisitCount;