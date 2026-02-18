import { Link } from 'react-router-dom';

const CourtOfAppeal = () => {
  return (
    <>
    <div className='page-banner mb-3'>
      <div className='container py-5'>
        <h2 className='text-white fw-bold' data-aos="fade-right" data-aos-duration="1500">Court of Appeal</h2>
        <nav  aria-label='breadcrumb' data-aos="fade-up" data-aos-duration="1700">
            <ol className='breadcrumb border-0'>
                <li className='breadcrumb-item'><Link to='/'>Home</Link></li>
                <li className='breadcrumb-item active' aria-current='page'>Court of Appeal</li>
            </ol>
        </nav> 
      </div> 
    </div>


    <div className="container my-5 pb-5">
      <div className="col-lg-12">
        <h3 className='text-accent text-center fw-semibold mb-4' data-aos="fade-down" data-aos-duration="1500">About The Court of Appeal</h3>        
        <p className='text-justify' data-aos="fade-right" data-aos-duration="1500">
          This is the highest level in the justice delivery system in Tanzania.
          The Court hears appeals  on both point of law and facts for cases originating from the 
          High Court of Tanzania and Magistrates with extended jurisdiction in exercise of their original 
          jurisdiction or appellate and revisional jurisdiction over matters originating in the District 
          Land and Housing Tribunals, District Courts and Courts of Resident Magistrate. The Court also 
          hears similar appeals  from quasi judicial bodies of status equivalent to that of the High Court. 
          It  further hears appeals  on point of law against the decision of the High Court in  matters 
          originating from Primary Courts. The Court of Appeal also exercises jurisdiction on appeals originating 
          from the High Court of Zanzibar except for constitutional issues arising from the interpretation of the 
          Constitution of Zanzibar and matters arising from the Kadhi Court.
        </p>
      </div>

      <div className="py-4" >
        <h3 className='text-accent text-center fw-semibold mb-4' data-aos="fade-up" data-aos-duration="1500">Mandate of Court of Appeal</h3>
        <p className='text-justify' data-aos="fade-right" data-aos-duration="1500">
          The primary mandate of the Court of Appeal is to hear and determine appeals from decisions of the High Court and other courts or 
          tribunals as prescribed by law. The Court of Appeal ensures the uniform interpretation and application of the law across the country, 
          thus upholding the rule of law and safeguarding justice. It plays a critical role in setting legal precedents, reviewing points of law, 
          and correcting errors made by lower courts. In addition to its appellate jurisdiction, the Court may also entertain applications for 
          review and revision under specific legal provisions, thereby reinforcing its oversight function in the administration of justice in 
          Tanzania.
        </p>
      </div>
    </div>

  </>
  )
}

export default CourtOfAppeal