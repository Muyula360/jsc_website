import { Link } from 'react-router-dom';

const HighCourt = () => {
  return (
    <>
    <div className='page-banner mb-3'>
      <div className='container py-5'>
        <h2 className='text-white fw-bold' data-aos="fade-right" data-aos-duration="1500">High Court of Tanzania</h2>
        <nav  aria-label='breadcrumb' data-aos="fade-up" data-aos-duration="1700">
            <ol className='breadcrumb border-0'>
                <li className='breadcrumb-item'><Link to='/'>Home</Link></li>
                <li className='breadcrumb-item active' aria-current='page'>High Court of Tanzania</li>
            </ol>
        </nav> 
      </div> 
    </div>

    <div className="container my-5 pb-5">

      <div className="col-12 mb-5">

        <h3 className='text-accent text-center fw-semibold mb-4' data-aos="fade-down" data-aos-duration="1500"> About The High Court </h3>
        <p className='text-justify' data-aos="fade-right" data-aos-duration="1700">
          This is the second level in the justice delivery system in Tanzania. It has both appellate and original 
          powers on civil and criminal matters. It also hears appeals from the Courts of Resident Magistrate, the 
          District Courts, and the District Land and Housing Tribunals in exercise of their original, appellate 
          and/or revisional jurisdiction. Further, the High Court has revisional and supervisory powers over 
          subordinate courts, tribunals, and administrative and quasi-judicial bodies. The High Court is divided into 
          Zones and specialized Divisions. Currently there are sixteen (16) Zones and four (4) Specialized Divisions 
          namely: Commercial, Land, Labor and Corruption & Economic Crime. The establishment of special divisions was 
          aimed at creating a conducive environment for the attraction of investments necessary for economic growth, by 
          faster resolution of legal matters that required court’s intervention. Future Judiciary plan, is to have 
          High Court centers in all administrative regions in a move to expand accessibility to justice by the citizens
        </p>

      </div>    


      {/* High Courts Specialized Divisions Starts */}
      <div className="row my-4">
      
        <h3 className='text-accent text-center fw-semibold mb-4' data-aos="fade-up" data-aos-duration="1500"> High Court Specialized Divisions </h3>

        {/* high court labour division  */}
        <div className="col-12" data-aos="fade-left" data-aos-duration="1500">
        <div className='card hover-border rounded-3 p-4 my-3'>
          <h5 className='text-heading fw-semibold'> Labour Division </h5>
          <div className="card-body p-0" style={{  }}>
            <p className='text-heading-secondary fs-15 text-justify my-3'>
              The Labour Court was officially inaugurated on June, 2007 under the Employment and Labour Relations Act. It is a division of the High Court of Tanzania 
              which specializes in the determination of employment and labour disputes only.
            </p>
          </div>
          <div className="">
            <Link className="icon-link icon-link-hover fs-15" to="/highcourt">Visit Court Website <i className="bi bi-arrow-right"></i></Link> 
          </div>
        </div>
        </div>          

        {/* high court Corruption and Economic Crimes division */}
        <div className="col-md-6 col-12" data-aos="fade-up" data-aos-duration="1500">
        <div className='card hover-border rounded-3 p-4 my-3'>
          <h5 className='text-heading fw-semibold'> Corruption and Economic Crimes Division </h5>
          <div className="card-body p-0" style={{  }}>
            <p className='text-heading-secondary fs-15 text-justify my-3'>
              The High Court Corruption and Economic Crimes Division in Tanzania was officially established under the Economic and Organised Crime Control Act (EOCCA) of 2016. 
              This is a division of the High specializes in the determination of Corruption and Economic Crimes disputes only.
            </p>
          </div>
          <div className="">
            <Link className="icon-link icon-link-hover fs-15" to="/highcourt">Visit Court Website <i className="bi bi-arrow-right"></i></Link> 
          </div>
        </div>
        </div>

        {/* high court land division */}
        <div className="col-md-6 col-12" data-aos="fade-left" data-aos-duration="1500">
        <div className='card hover-border rounded-3 p-4 my-3'>
          <h5 className='text-heading fw-semibold'> Land Division </h5>
          <div className="card-body p-0" style={{  }}>
            <p className='text-heading-secondary fs-15 text-justify my-3'>
              High Court Land  Division was established as a result of the land reforms which were implemented by the Land Act 1999. 
              Until 2010, the Land Court had exclusive jurisdiction to determine land disputes relating to land with a pecuniary value of TZS 50,000 or more. 
            </p>
          </div>
          <div className="">
            <Link className="icon-link icon-link-hover fs-15" to="/highcourt">Visit Court Website <i className="bi bi-arrow-right"></i></Link> 
          </div>
        </div>
        </div>
     
        {/* high court commercial division */}
        <div className="col-md-6 col-12" data-aos="fade-right" data-aos-duration="1500">
        <div className='card hover-border rounded-3 p-4 my-3'>
          <h5 className='text-heading fw-semibold'> Commercial Division </h5>
          <div className="card-body p-0" style={{  }}>
            <p className='text-heading-secondary fs-15 text-justify my-3'>
              The Commercial Court was officially inaugurated on 15th September, 1999. The Government of Tanzania endorsed the recommendations in 1997. It is a division 
              of the High Court of Tanzania which specializes in the determination of commercial disputes only
            </p>
          </div>
          <div className="">
            <Link className="icon-link icon-link-hover fs-15" to="/highcourt">Visit Court Website <i className="bi bi-arrow-right"></i></Link> 
          </div>
        </div>
        </div>

        {/* high court Mediation division */}
        <div className="col-md-6 col-12" data-aos="fade-up" data-aos-duration="1500">
        <div className='card hover-border rounded-3 p-4 my-3'>
          <h5 className='text-heading fw-semibold'> Mediation Division </h5>
          <div className="card-body p-0" style={{  }}>
            <p className='text-heading-secondary fs-15 text-justify my-3'>
              Court-Annexed Mediation to facilitate the amicable resolution of disputes before they proceed to full litigation. This approach aims to 
              reduce case backlogs, save time and resources, and promote harmonious settlements between parties
            </p>
          </div>
          <div className="">
            <Link className="icon-link icon-link-hover fs-15" to="/highcourt">Visit Court Website <i className="bi bi-arrow-right"></i></Link> 
          </div>
        </div>
        </div>

      </div>
      {/* High Courts Specialized Divisions Ends */}
 

      {/* High Courts Zones Starts */}
      <div className="my-5 ">
        <h3 className='text-accent text-center fw-semibold mb-4' data-aos="fade-up" data-aos-duration="1500"> High Courts Zones </h3>
        <div className="my-5 bg-accent rounded-2 py-5 px-4" data-aos="fade-up" data-aos-duration="1500">
          <div className="row" data-aos="fade-right" data-aos-duration="1700">
            <div class="col-xl-4 col-md-6 col-12 my-2"><i className="bi bi-bank text-white me-1"></i> <Link className="text-white icon-link icon-link-hover fs-15"> Dar-Es-Salaam High Court Zone <i className="bi bi-arrow-right"></i></Link></div>
            <div class="col-xl-4 col-md-6 col-12 my-2"><i className="bi bi-bank text-white me-1"></i> <Link className="text-white icon-link icon-link-hover fs-15"> Bukoba High Court Zone <i className="bi bi-arrow-right"></i></Link></div>
            <div class="col-xl-4 col-md-6 col-12 my-2"><i className="bi bi-bank text-white me-1"></i> <Link className="text-white icon-link icon-link-hover fs-15"> Tanga High Court Zone <i className="bi bi-arrow-right"></i></Link></div>
            <div class="col-xl-4 col-md-6 col-12 my-2"><i className="bi bi-bank text-white me-1"></i> <Link className="text-white icon-link icon-link-hover fs-15"> Mbeya High Court Zone <i className="bi bi-arrow-right"></i></Link></div>
            <div class="col-xl-4 col-md-6 col-12 my-2"><i className="bi bi-bank text-white me-1"></i> <Link className="text-white icon-link icon-link-hover fs-15"> Arusha High Court Zone <i className="bi bi-arrow-right"></i></Link></div>
            <div class="col-xl-4 col-md-6 col-12 my-2"><i className="bi bi-bank text-white me-1"></i> <Link className="text-white icon-link icon-link-hover fs-15"> Dodoma High Court Zone <i className="bi bi-arrow-right"></i></Link></div>
            <div class="col-xl-4 col-md-6 col-12 my-2"><i className="bi bi-bank text-white me-1"></i> <Link className="text-white icon-link icon-link-hover fs-15"> Mwanza High Court Zone <i className="bi bi-arrow-right"></i></Link></div>
            <div class="col-xl-4 col-md-6 col-12 my-2"><i className="bi bi-bank text-white me-1"></i> <Link className="text-white icon-link icon-link-hover fs-15"> Iringa High Court Zone <i className="bi bi-arrow-right"></i></Link></div>
            <div class="col-xl-4 col-md-6 col-12 my-2"><i className="bi bi-bank text-white me-1"></i> <Link className="text-white icon-link icon-link-hover fs-15"> Tabora High Court Zone <i className="bi bi-arrow-right"></i></Link></div>
            <div class="col-xl-4 col-md-6 col-12 my-2"><i className="bi bi-bank text-white me-1"></i> <Link className="text-white icon-link icon-link-hover fs-15"> Songea High Court Zone <i className="bi bi-arrow-right"></i></Link></div>
            <div class="col-xl-4 col-md-6 col-12 my-2"><i className="bi bi-bank text-white me-1"></i> <Link className="text-white icon-link icon-link-hover fs-15"> Sumbawanga Court Zone <i className="bi bi-arrow-right"></i></Link></div>
            <div class="col-xl-4 col-md-6 col-12 my-2"><i className="bi bi-bank text-white me-1"></i> <Link className="text-white icon-link icon-link-hover fs-15"> Moshi High Court Zone <i className="bi bi-arrow-right"></i></Link></div>
            <div class="col-xl-4 col-md-6 col-12 my-2"><i className="bi bi-bank text-white me-1"></i> <Link className="text-white icon-link icon-link-hover fs-15"> Mtwara High Court Zone <i className="bi bi-arrow-right"></i></Link></div>
            <div class="col-xl-4 col-md-6 col-12 my-2"><i className="bi bi-bank text-white me-1"></i> <Link className="text-white icon-link icon-link-hover fs-15"> Shinyanga High Court Zone <i className="bi bi-arrow-right"></i></Link></div>
            <div class="col-xl-4 col-md-6 col-12 my-2"><i className="bi bi-bank text-white me-1"></i> <Link className="text-white icon-link icon-link-hover fs-15"> Kigoma High Court Zone <i className="bi bi-arrow-right"></i></Link></div>
            <div class="col-xl-4 col-md-6 col-12 my-2"><i className="bi bi-bank text-white me-1"></i> <Link className="text-white icon-link icon-link-hover fs-15"> Msoma High Court Zone <i className="bi bi-arrow-right"></i></Link></div>
            <div class="col-xl-4 col-md-6 col-12 my-2"><i className="bi bi-bank text-white me-1"></i> <Link className="text-white icon-link icon-link-hover fs-15"> Temeke - DSM High Court Zone <i className="bi bi-arrow-right"></i></Link></div>
            <div class="col-xl-4 col-md-6 col-12 my-2"><i className="bi bi-bank text-white me-1"></i> <Link className="text-white icon-link icon-link-hover fs-15"> Morogoro High Court Zone <i className="bi bi-arrow-right"></i></Link></div>
          </div>
        </div>
      </div>
      {/* High Courts Zones Ends */}   
                   	
 
    </div>

  </>
  )
}

export default HighCourt