import { Link } from 'react-router-dom';

const CauseList = () => {
  return (
    <>
    <div className='page-banner mb-3'>
      <div className='container py-5'>
        <h2 className='text-white fw-bold'>Cause List</h2>
        <nav  aria-label='breadcrumb'>
            <ol className='breadcrumb'>
                <li className='breadcrumb-item'><Link to='/'>Home</Link></li>
                <li className='breadcrumb-item active' aria-current='page'>Cause List</li>
            </ol>
        </nav> 
      </div> 
    </div>
  </>
  )
}

export default CauseList