import ServicesButton from '../components/ServiceButton'

const ServicesButtonDisplay = () => {

  const webUrl = import.meta.env.VITE_API_WEBURL;
  const iconsPath = webUrl+'/src/assets/icons';

  return (
    <>
    <div className='services-btn-display' style={{ height: '190px' }}>
        <div className="container position-relative h-100 text-center" style={{ zIndex: '4'}}>
            <div className='position-absolute top-0 start-50 translate-middle bg-light w-100 border-0 rounded-3 p-0'>
              <div className='d-flex' data-aos="fade-right" data-aos-duration="1500">
                <ServicesButton btn_title='Case Management' btn_icon={ `${iconsPath}/case_managment.png` } to='https://cms.judiciary.go.tz' />
                <ServicesButton btn_title='eWakili' btn_icon={ `${iconsPath}/advocate.png` } to='https://ewakili.judiciary.go.tz/#/ewakili' />
                <ServicesButton btn_title='eLibrary' btn_icon={ `${iconsPath}//elibrary.png` } to='' />          
                <ServicesButton btn_title='Virtual Court' btn_icon={ `${iconsPath}/virtual_courts.png` } to='https://virtualcourt.judiciary.go.tz' />
                <ServicesButton btn_title='Court Broker' btn_icon={ `${iconsPath}/broker.png` } to='http://cbps.judiciary.go.tz' />
              </div>
            </div> 
            <div className='text-white position-absolute translate-middle-x' style={{ top:'55%', left:'50%' }} data-aos="fade-up" data-aos-duration="1500">
              <span>Discover more e-services on our Portal <button className='btn btn-accent-marron ms-2'  onClick={() => window.open('https://portal.judiciary.go.tz/home', '_blank')}>Judiciary Portal</button> </span>
            </div>                
        </div>
    </div>

    <div className="modal fade" id="casestatusmodal" data-bs-backdrop="static" data-bs-keyboard="false" tabIndex="-1" aria-labelledby="casestatusmodal" aria-hidden="true">
    <div className="modal-dialog">
      <div className="modal-content">
        <div className="modal-header border-0">
          <h5 className="modal-title fw-semibold" id="casestatusmodal"></h5>
          <button type="button" className="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div className="modal-body px-4">

          <ul className='nav nav-underline justify-content-center mb-4' id='casestatus-tablist' role='tablist'>
              <li className='nav-item nav-item-rounded' role='presentation'>
                  <a className='nav-link nav-link-rounded active' id='byReferenceNo-tab' data-bs-toggle='tab' data-bs-target='#byReferenceNo-tab-pane' role='tab' aria-controls='byReferenceNo-tab-pane' aria-selected='true'>By Reference No</a>
              </li>
              <li className='nav-item nav-item-rounded' role='presentation'>
                  <a className='nav-link nav-link-rounded' href='' id='byCaseNo-tab' data-bs-toggle='tab' data-bs-target='#byCaseNo-tab-pane' role='tab' aria-controls='byCaseNo-tab-pane' aria-selected='false'>By Case No</a>
              </li>
          </ul>
          <div className='tab-content' id='casesStatusForms'>
            <div className='tab-pane fade show active' id='byReferenceNo-tab-pane' role='tabpanel' aria-labelledby='byReferenceNo-tab' tabIndex='0'>
              <form id='byReferenceNoForm' action="">
                <div className="form-floating mb-4">
                  <input type="text" className="form-control" id="caseref" placeholder=""/>
                  <label htmlFor="floatingInput">Case Reference Number</label>
                </div>
                <div className="d-flex flex-column align-items-center">
                  <button type="button" className="btn btn-accent rounded-3 px-4">Get Status</button>
                </div>     
              </form>
            </div>
            <div className='tab-pane fade' id='byCaseNo-tab-pane' role='tabpanel' aria-labelledby='byCaseNo-tab' tabIndex='0'>
              <form id='byCaseNoForm' action="">
                <div className="form-floating mb-3">
                  <input type="text" className="form-control" id="caseref" placeholder=""/>
                  <label htmlFor="floatingInput">Case Number</label>
                </div>
                <select className="form-select mb-3" aria-label="Default select example">
                  <option defaultValue>Select Year</option>
                  <option value="1">One</option>
                  <option value="2">Two</option>
                  <option value="3">Three</option>
                </select>
                <select className="form-select" aria-label="Default select example">
                  <option defaultValue>Select Court</option>
                  <option value="1">One</option>
                  <option value="2">Two</option>
                  <option value="3">Three</option>
                </select>
                <div className="d-flex flex-column align-items-center mt-4">
                  <button type="button" className="btn btn-accent rounded-3 px-4">Get Status</button>
                </div>     
              </form>
            </div> 
          </div>

        </div>
      </div>
    </div>
    </div>
    </>

  )
}

export default ServicesButtonDisplay