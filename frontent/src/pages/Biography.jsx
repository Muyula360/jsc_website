import { useParams, Link } from 'react-router-dom';
import React, { useState, useEffect } from "react";
import { useDispatch, useSelector } from 'react-redux';
import { getLeaders } from "../features/leaderSlice";

const Biography = () => {

  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

  const { leaderTitleID } = useParams(); 
  const [selectedLeader, setSelectedLeader] = useState(null);
  
  const dispatch = useDispatch();
  const { leaders, isLoading, isSuccess, isError, message } = useSelector(state => state.leaders);


  useEffect(() => {
    dispatch(getLeaders());
  }, [dispatch]);


  useEffect(() => {
    if (leaders && leaders.length > 0) {
      const leader = leaders.find( leader => leader.leadersTitleID === leaderTitleID );
      setSelectedLeader(leader);
      console.log(leader);
    }
  }, [leaders, leaderTitleID]);


  return (
    <>
      <div className='position-relative'>
        {/* Page banner */}
        <div className='page-banner'>
          <div className='container d-flex flex-column justify-content-center' style={{ height: '200px' }}>
            <h2 className='text-white fw-bold'>Biography</h2>
            <nav  aria-label='breadcrumb'>
              <ol className='breadcrumb'>
                  <li className='breadcrumb-item'><Link to='/'>Home</Link></li>
                  <li className='breadcrumb-item active' aria-current='page'>Biography</li>
              </ol>
            </nav> 
          </div> 
        </div>
      </div>

      <div className="container py-5 my-5">

        { selectedLeader && (
          <>
            <div className="card border-0 shadow-sm rounded-1 mb-5" data-aos="fade-down" data-aos-duration="1500">
              <div className="row g-2">
                <div className="col-md-4">
                  <img className="img-fluid rounded-start" src={ `${webMediaURL}/${selectedLeader.profile_pic_path}` } alt=""/>
                </div>
                <div className="col-md-8">
                  <div className="card-body d-flex p-5">
                    <div id="leader-particulars" className="w-50">
                        <span className='text-dark-accent fw-semibold'> { selectedLeader.title } </span>
                        <h5 className='text-heading fw-semibold my-2'> { selectedLeader.fullname } </h5>
                        <div className='mt-2 fs-15'>
                            <p className='text-heading-secondary mb-1'> <span className="text-heading">Expertise:</span> { selectedLeader.profession } </p>
                            <p className='text-heading-secondary mb-1'> <span className="text-heading">Experience:</span> { selectedLeader.experienceYears } </p>    
                        </div>         
                    </div>
                    <div id="title-decription" className="w-50 text-heading-secondary">
                        <p> { selectedLeader.titleDesc} </p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div className="mb-3">
                <h4 className="text-heading fw-bold" data-aos="fade-up" data-aos-duration="1500">Biography</h4>
                <div className="text-justify mb-3 text-heading-secondary" data-aos="fade-up" data-aos-duration="1500" dangerouslySetInnerHTML={{ __html: selectedLeader?.bio }} />     
            </div>
          </>

        )}

      </div>
    </>
  );
};

export default Biography;