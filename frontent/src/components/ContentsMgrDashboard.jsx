

const ContentsMgrDashboard = () => {

  return (
    <>
    <div className="container-fluid">
      <h5><strong>Dashboard</strong></h5>
  
      <div className="row grid-margin my-5">
            <div className="col-12">
              <div className="card bg-danger text-light">
                <div className="card-body">
                  <div className="d-flex flex-column flex-md-row align-items-center justify-content-between">
                      <div className="statistics-item">
                        <p>
                          <i className="icon-sm bi bi-newspaper mr-2"></i>
                          News & Updates
                        </p>
                        <h2>540</h2>
                        <label className="badge badge-outline-success badge-pill">2.7% increase</label>
                      </div>
                      <div className="statistics-item">
                        <p>
                          <i className="icon-sm bi bi-megaphone mr-2"></i>
                          Announcements
                        </p>
                        <h2>122</h2>
                        <label className="badge badge-outline-danger badge-pill">30% decrease</label>
                      </div>
                      <div className="statistics-item">
                        <p>
                          <i className="icon-sm bi bi-journal-album mr-2"></i>
                          Newsletters
                        </p>
                        <h2>50</h2>
                        <label className="badge badge-outline-success badge-pill">12% increase</label>
                      </div>
                      <div className="statistics-item">
                        <p>
                          <i className="icon-sm fas fa-check-circle mr-2"></i>
                          Vacancies
                        </p>
                        <h2>7500</h2>
                        <label className="badge badge-outline-success badge-pill">57% increase</label>
                      </div>
                      <div className="statistics-item">
                        <p>
                          <i className="icon-sm fas fa-chart-line mr-2"></i>
                          Tenders
                        </p>
                        <h2>120</h2>
                        <label className="badge badge-outline-success badge-pill">10% increase</label>
                      </div>
                      <div className="statistics-item">
                        <p>
                          <i className="icon-sm fas fa-circle-notch mr-2"></i>
                          Feedbacks
                        </p>
                        <h2>750</h2>
                        <label className="badge badge-outline-danger badge-pill">16% decrease</label>
                      </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div className="row">
            <div className="col-md-6 grid-margin stretch-card">
              <div className="card">
                <div className="card-body">
                  <h5 className="card-title">
                  <i className="fas fa-chart-line"></i>
                    Website Visits
                  </h5>
                  <canvas id="orders-chart"></canvas>
                  <div id="orders-chart-legend" className="orders-chart-legend "></div>                  
                </div>
              </div>
            </div>
            <div className="col-md-6 grid-margin stretch-card">
              <div className="card">
                <div className="card-body">
                  <h5 className="card-title">
                    <i className="bi bi-link-45deg fs-4"></i>
                    Engagements
                  </h5>
                  <canvas id="sales-chart"></canvas>
                  <h6 className="mt-5">56000 <span className="text-muted h6 font-weight-normal">Engages</span></h6>
                  
                </div>
              </div>
            </div>
          </div>
    </div>
      
    </>
  );
}


export default ContentsMgrDashboard
