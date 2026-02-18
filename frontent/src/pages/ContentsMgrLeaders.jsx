import { Link } from "react-router-dom";
import React, { useState, useEffect } from "react";
import { useDispatch, useSelector  } from 'react-redux';

import { getLeaders } from "../features/leaderSlice";
import LeaderForm from "../components/LeadersForm";



const ContentsMgrLeaders = () => {

  const dispatch = useDispatch();
  const { leaders, isLoading, isSuccess, isError, message } = useSelector((state) => state.leaders);


  //selected leader state
  const [ selectedLeaderDetails, setSelectedLeaderDetails ] = useState({ leadersTitleID: '', title: '', profession: '', experienceYear: '', bio: '' });


  // managementLeaders page useeffect (when this page loads fetch Leaders data from API)
  useEffect(() => {

    dispatch( getLeaders() );

  },[ dispatch ]);

 
  return (
    <>
      <div className="container-fluid">
        <div className="d-flex justify-content-between align-items-center mb-3">
          <h5 className=""><i className="bi bi-people-fill"></i> Top Management Leaders </h5>
        </div>

        <div className="">

          {/* Modal for UserForm */}
          <div className="modal fade" id="leadersForm" data-bs-backdrop="static" data-bs-keyboard="false" tabIndex="-1" aria-labelledby="#leadersFormLabel1" aria-hidden="true">
            <LeaderForm leaderDetails={ selectedLeaderDetails } />
          </div>

          
          <div className="row py-4">
            {
              isSuccess && (

                leaders.map((leader, index) => (

                  <div key={index} className="col-6 gx-2 g-3">
                    <div className="card border-0 shadow-sm rounded-1 py-3">
                      <div className="card-body px-3">
                        <div className="row">
                          <div className="col-md-4 d-flex justify-content-center align-items-center">
                              <img src="/userProfilePic.png" className="img-fluid rounded-circle opacity-25 p-1" alt="Leader Profile Picture" style={{ width: "100px", height: "100px", objectFit: "cover" }} />
                          </div>
                          <div className="col-md-8 py-2">
                              <h6 className="text-heading fw-semibold">{ leader.title }</h6>
                              <p className="text-heading-secondary fs-14 mb-1">Name: <span>{ leader.fullname }</span></p>
                              <p className="text-heading-secondary fs-14 mb-1">Profession: <span>{ leader.profession }</span></p>
                              <p className="text-heading-secondary fs-14 mb-1">Experience: <span>{ leader.experienceYears }</span></p>
                          </div>
                        </div>
                        <div className="bg-light rounded-1 p-3">
                          <h6 className="text-heading fw-semibold mb-2">Bio</h6>
                          <div className="text-justify text-secondary fs-12" style={{ height: '60px', overflow: 'hidden', textOverflow: 'ellipsis', display: '-webkit-box', WebkitLineClamp: 3, WebkitBoxOrient: 'vertical' }}dangerouslySetInnerHTML={{ __html: leader.bio }}/>
                        </div>
                      </div>
                      <div className="py-1 d-flex justify-content-end">
                          <Link className="text-decoration-none mx-3" data-bs-toggle="modal" data-bs-target="#leadersForm" onClick={ () => setSelectedLeaderDetails(leader) }>
                            Update Details <span className=''><i className="bi bi-pencil-fill"></i></span>
                          </Link>
                      </div>
                    </div>
                  </div>

                ))

              )
            }
          </div>
          
        </div>
      </div>
        
    </>
  );
}

export default ContentsMgrLeaders
