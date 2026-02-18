import React from 'react'
import SampleNewsImg4 from '../assets/img/sample_news_img4.jpg';

const CardTrial = () => {
  return (
    <div class="card w-50">
        <div class="card-body image-container p-0">
            <img src={ SampleNewsImg4 } class="card-img-top" alt="Card Image"/>
            <div class="overlay">
                <a href="#" class="read-more-btn">See Biography</a>
            </div>
        </div>
        <div className='card-footer'>
            <h5 class="card-title">Card Title</h5>
            <p class="card-text">Some brief description of the card content.</p>
        </div>
    </div>
  )
}

export default CardTrial