import React from 'react'


const CardCarousel = () => {
  return (
    <div className="row">
        <div className="col-lg-3 col-md-6 col-12">
        <div class="card p-0 border-0 rounded-0 shadow">
            <img class="card-img-top rounded-0" src={ NewsImage } alt=""/>
            <div class="card-body px-4">
                <small className='text-secondary'>By John Doe</small>
                <h6 className='fw-semibold heading-color mt-2 mb-3'>Dolorum optio tempore voluptas dignissimos cumqu ... </h6>

                <div class="d-flex justify-content-between py-1">
                    <small class="text-secondary">Last updated 3 mins ago</small>
                </div>             
            </div>
        </div>
        </div>
        <div className="col-lg-3 col-md-6 col-12">
        <div class="card p-0 border-0 rounded-0 shadow">
            <img class="card-img-top rounded-0" src={ NewsImage } alt=""/>
            <div class="card-body px-4">
                <small className='text-secondary'>By John Doe</small>
                <h6 className='fw-semibold heading-color mt-2 mb-3'>Dolorum optio tempore voluptas dignissimos cumqu ... </h6>

                <div class="d-flex justify-content-between py-1">
                    <small class="text-secondary">Last updated 3 mins ago</small>
                </div>             
            </div>
        </div>
        </div>
        <div className="col-lg-3 col-md-6 col-12">
        <div class="card p-0 border-0 rounded-0 shadow">
            <img class="card-img-top rounded-0" src={ NewsImage } alt=""/>
            <div class="card-body px-4">
                <small className='text-secondary'>By John Doe</small>
                <h6 className='fw-semibold heading-color mt-2 mb-3'>Dolorum optio tempore voluptas dignissimos cumqu ... </h6>

                <div class="d-flex justify-content-between py-1">
                    <small class="text-secondary">Last updated 3 mins ago</small>
                </div>             
            </div>
        </div>
        </div>
        <div className="col-lg-3 col-md-6 col-12">
        <div class="card p-0 border-0 rounded-0 shadow">
            <img class="card-img-top rounded-0" src={ NewsImage } alt=""/>
            <div class="card-body px-4">
                <small className='text-secondary'>By John Doe</small>
                <h6 className='fw-semibold heading-color mt-2 mb-3'>Dolorum optio tempore voluptas dignissimos cumqu ... </h6>

                <div class="d-flex justify-content-between py-1">
                    <small class="text-secondary">Last updated 3 mins ago</small>
                </div>             
            </div>
        </div>
        </div>
    </div>

  )
}

export default CardCarousel