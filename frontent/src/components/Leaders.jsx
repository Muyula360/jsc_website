import { useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';

import LeaderProfile from './LeaderProfile';
import { getLeaders } from "../features/leaderSlice";

const Leaders = () => {

  const dispatch = useDispatch();
  const { leaders, isLoading, isSuccess, isError, message } = useSelector(state => state.leaders);

  useEffect(() => {
    dispatch(getLeaders());
  }, [dispatch]);

  return (

    <section className='bg-transparent mb-5'>
        <div className="container">
            <div className="text-center mb-4" data-aos="fade-up" data-aos-delay="300">
                <h3 className='text-accent fw-bold'> Judiciary Top Management </h3>
            </div>
            <div className="container py-2">
                <div className="row gy-4" >
                    {/* Loading State: Show 4 placeholder cards */}
                    {isLoading &&
                        Array.from({ length: 4 }).map((_, index) => (
                        <div key={index} className="col-lg-3">
                            <LeaderProfile index={index} totalLeaders={4} isLoading />
                        </div>
                        ))
                    }

                    {/* Error State */}
                    {isError && (
                        <div className="col-12">
                            <div className="alert alert-danger text-center" role="alert">
                                {message || "Failed to load leaders. Please try again later."}
                            </div>
                        </div>
                    )}

                    {/* Success with Leaders */}
                    {isSuccess && leaders?.length > 0 &&
                        leaders.map((leader, index) => (
                            <div key={index} className="col-lg-3">
                                <LeaderProfile leaderDetails={leader} totalLeaders={4} index={index} isSuccess />
                            </div>
                        ))
                    }

                    {/* Success but no data */}
                    {isSuccess && leaders?.length === 0 && (
                        <div className="col-12 text-center">
                            <span className="text-muted">No leaders found at this time.</span>
                        </div>
                    )}
                </div>
        

            </div>
        </div>
    </section>
 
  );
};

export default Leaders;