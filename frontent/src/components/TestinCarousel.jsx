
import Slider from "react-slick";

const TestinCarousel = () => {
  const settings = {
    dots: true,
    infinite: true,
    speed: 500,
    slidesToShow: 3, // Number of slides on desktop
    slidesToScroll: 1,
    autoplay: true,
    autoplaySpeed: 3000,
    responsive: [
      {
        breakpoint: 992, // for medium devices
        settings: {
          slidesToShow: 2,
        },
      },
      {
        breakpoint: 576, // for small devices
        settings: {
          slidesToShow: 1,
        },
      },
    ],
  };

  return (
    <div className="container mt-4">
      <h3>React Slick Carousel</h3>
      <Slider {...settings}>
        <div><img src="/images/1.jpg" alt="1" className="img-fluid" /></div>
        <div><img src="/images/2.jpg" alt="2" className="img-fluid" /></div>
        <div><img src="/images/3.jpg" alt="3" className="img-fluid" /></div>
        <div><img src="/images/4.jpg" alt="4" className="img-fluid" /></div>
      </Slider>
    </div>
  );
}

export default TestinCarousel