import { Link } from "react-router-dom";


const ServiceButton = ({ btn_title, btn_icon, to }) => {
  return (
    <Link className='service-btn d-flex flex-column justify-content-center align-items-center gap-3' to={to} target="_blank" rel="noopener noreferrer">
      <img src={ btn_icon } alt="" style={{ width: "60px" }} />
      <span>{ btn_title }</span>
    </Link>
  )
}

export default ServiceButton