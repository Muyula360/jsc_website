
import Slider from "react-slick";

const ScrollingNewsHighlights = ({newsUpdates}) => {

  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

  const newsData = newsUpdates;

  const settings = {
    dots: true,
    infinite: true,
    speed: 1000,
    slidesToShow: 3, // Number of slides on desktop
    slidesToScroll: 1,
    autoplay: true,
    autoplaySpeed: 5000,
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
    <div className="container mt-3 mb-4 px-0">
      <div className="news-carousel">
        <Slider {...settings}>
          {
            newsData.map((item, index) => (
              <div key={index} className="px-2" >
                <div className="position-relative news-item">
                  <img src={ `${webMediaURL}/${item.coverPhotoPath}` } alt={``} className="img-fluid" />
                  <div className="news-title position-absolute">{item.newsTitle}</div>
                </div>
              </div>
            ))
          }
        </Slider>
      </div>
    </div>
  );
};

export default ScrollingNewsHighlights;
