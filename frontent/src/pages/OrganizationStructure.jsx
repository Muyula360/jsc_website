import { Link } from 'react-router-dom';
import TestinCarousel from '../components/TestinCarousel';


const OrganizationStructure = () => {

    const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

    return (
        <>
            {/* Page banner */}
            <div className='page-banner'>
            <div className='container d-flex flex-column justify-content-center' style={{ height: '200px' }}>
                <h2 className='text-white fw-bold' data-aos="fade-right" data-aos-duration="1500">Organization Structure</h2>
                <nav  aria-label='breadcrumb' data-aos="fade-up" data-aos-duration="1700">
                    <ol className='breadcrumb border-0'>
                        <li className='breadcrumb-item'><Link to='/'>Home</Link></li>
                        <li className='breadcrumb-item active' aria-current='page'>Organization Structure</li>
                    </ol>
                </nav> 
            </div> 
            </div>    

            <div className="container py-4 my-5">      
                <div className="" data-aos="fade-up" data-aos-duration="1700">
                    <img src={`${webMediaURL}/website-repository/organization_structure/jot_org_structure.png`} width="100%" alt="Organization Structure" />
                </div>
            </div>
        </>
    )
}

export default OrganizationStructure;