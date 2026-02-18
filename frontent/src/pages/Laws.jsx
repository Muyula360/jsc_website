import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import Newsaside from "../components/newsaside";
import * as Icons from 'react-bootstrap-icons';

const Laws = () => {
  
  const [searchTerm, setSearchTerm] = useState("");

  const formsData = [
    { title: "Probate and Administration Central form.", icon: <Icons.FileEarmarkPdf className="text-danger" size={50} /> },
    { title: "Office of the Judiciary Ombudsman - Client Complaint Form", icon: <Icons.FileEarmarkPdf className="text-danger" size={50} /> },
    { title: "Wealth Declaration Form", icon: <Icons.FileEarmarkPdf className="text-danger" size={50} /> },
    { title: "Steps for use in Microsoft Teams, Skype and Zoom", icon: <Icons.FileEarmarkPdf className="text-danger" size={50} /> },
  ];

  const filteredLaws                                                                                   = formsData.filter(form =>
    form.title.toLowerCase().includes(searchTerm.toLowerCase())
  );
  return (
   <>
    <div className='page-banner mb-3'>
      <div className='container py-5'>
        <h2 className='text-white fw-bold'>Laws & Regulations</h2>
        <nav  aria-label='breadcrumb'>
            <ol className='breadcrumb border-0'>
                <li className='breadcrumb-item'><Link to='/'>Home</Link></li>
                <li className='breadcrumb-item active' aria-current='page'>Laws & Regulations</li>
            </ol>
        </nav> 
      </div> 
    </div>
   
      <div className="container mb-5 mt-4">
        <div className="row mb-5 justify-content-between">
          <div className='col-12 col-lg-9 col-xl-9 col-md-8'>
            <div className="mb-3">
              <input 
                type="text" 
                className="form-control mb-4" 
                placeholder="Search laws & regulations..."
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
              />
            </div>
            <div className="row mt-4">
              {filteredLaws.map((law, index) => (
                <div className="col-12 col-xl-4 col-lg-4 mb-4" key={index}>
                  <a href='#' className="d-flex align-items-center">
                    <div className="left">{law.icon}</div>
                    <div className="text-dark forms-title">
                      {law.title}
                    </div>
                  </a>
                </div>
              ))}
            </div>
          </div>
          <Newsaside />
        </div>
      </div>
  </>
  )
}

export default Laws