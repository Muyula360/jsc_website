import React, { useEffect } from 'react';
import { Link } from 'react-router-dom';
import { useDispatch, useSelector } from 'react-redux';
import { getJudgments } from '../features/judgementSlice';

const JudgmentsHighlight = () => {
  const dispatch = useDispatch();

  // Get state from Redux
  const { judgments, isLoading, isError, message } = useSelector((state) => state.judgments);

  useEffect(() => {
    dispatch(getJudgments());
  }, [dispatch]);

  return (
    <div className="list-group list-group-flush p-1">
      <div className="d-flex justify-content-between mb-4">
        <h6 className='text-heading'>
          <i className="bi bi-bank2 text-accent me-1"></i> Recent Judgments
        </h6>
        <Link className="icon-link icon-link-hover fs-15" to="projects">
          See More <i className="bi bi-arrow-right"></i>
        </Link>
      </div>

      {isLoading && <p className="text-secondary">Loading judgments...</p>}
      {isError && <p className="text-danger">Error: {message}</p>}

      {!isLoading && judgments.slice(0, 3).map((judgment) => (
        <li key={judgment.id} className="list-group-item d-flex justify-content-between align-items-center px-3 py-2 bg-light">
          <div>
            <small className='text-accent-secondary'>{judgment.type}</small>
            <div className='d-flex justify-content-between my-1'>
              <h6 className="text-heading-secondary fw-semibold">{judgment.title}</h6>
              <Link to={judgment.link} className="ms-3 fs-18" title="View Judgment Details" target="_blank" rel="noopener noreferrer" style={{ width: '5%' }}>
                <i className="bi bi-arrow-up-right-square"></i>
              </Link>
            </div>
            <p className="text-secondary text-justify fs-14 mb-2">{judgment.summary}</p>
            <div className='d-flex justify-content-between'>
              <span className="causelist-card-text">
                <small><i className="bi bi-bank2 me-1"></i> {judgment.court}</small>
              </span>
              <span className="causelist-card-text">
                <small><i className="bi bi-clock me-1"></i> {judgment.date}</small>
              </span>
            </div>
          </div>
        </li>
      ))}
    </div>
  );
};

export default JudgmentsHighlight;
