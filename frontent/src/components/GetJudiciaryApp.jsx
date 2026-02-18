import { Link } from 'react-router-dom';

const GetJudiciaryApp = () => {

  const webUrl = import.meta.env.VITE_API_WEBURL;
  const iconsPath = webUrl+'/src/assets/icons';

  return (
    <>
    <div className='text-center bg-accent text-white py-5'>
        <h4 className='fw-bold' data-aos="fade-down" data-aos-duration="2000">Get Our App</h4>
        <span>Use Judiciary mobile application to  track case and stay informated about judiciary news!</span>

        <div className='d-flex align-items-center gap-3 justify-content-center mt-3'>
          <div data-aos="fade-right" data-aos-duration="1500" style={{ width: '15%', minWidth: '150px' }}>
            <Link target='_blank' rel='noopener noreferrer' to='https://play.google.com/store/search?q=judiciary+mobile+tz&c=apps' className='btn btn-dark d-flex flex-row justify-content-center align-items-center gap-2'>
                <img src={`${iconsPath}/playstore_logo.png`} alt='Apple Logo' style={{ width: '30px' }} /> Google Play
            </Link>
          </div>
          <div data-aos="fade-left" data-aos-duration="1500" style={{ width: '15%', minWidth: '150px' }}>
            <Link target='_blank' rel='noopener noreferrer' to='https://apps.apple.com/us/app/judiciary-mobile-tz/id1234567890' className='btn btn-dark d-flex flex-row justify-content-center align-items-center gap-2'>
                <img src={`${iconsPath}/appstore_logo.png`} alt='Apple Logo' style={{ width: '30px' }} /> App Store
            </Link>
          </div>
        </div>
    </div>
    </>  
  )
}

export default GetJudiciaryApp