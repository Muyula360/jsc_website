import React from 'react'

const CollectionTabs = () => {
  return (
    <div className='container'>
        <div>
        <ul class="nav nav-pills nav-fill" id="WebCollectionTab" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home-tab-pane" type="button" role="tab" aria-controls="home-tab-pane" aria-selected="true">Home</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile-tab-pane" type="button" role="tab" aria-controls="profile-tab-pane" aria-selected="false">Profile</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact-tab-pane" type="button" role="tab" aria-controls="contact-tab-pane" aria-selected="false">Contact</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="disabled-tab" data-bs-toggle="tab" data-bs-target="#disabled-tab-pane" type="button" role="tab" aria-controls="disabled-tab-pane" aria-selected="false" disabled>Disabled</button>
            </li>
        </ul>
        </div>


        <ul class="portfolio-filters isotope-filters" data-aos="fade-up" data-aos-delay="100">        
            <li className='filter-active' id="cause-list-tab" data-bs-toggle="tab" data-bs-target="#cause-list-pane" type="button" role="tab" aria-controls="cause-list-pane" aria-selected="true">Cause List</li>
            <li data-filter=".judgements">
                <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile-tab-pane" type="button" role="tab" aria-controls="profile-tab-pane" aria-selected="false">Judgements</button>
            </li>
            <li data-filter=".case-stats">Case Statistics</li>         
            <li data-filter=".judiciary-map">Judiciary Map</li>
            <li data-filter=".projects">Projects</li>
            <li data-filter=".tenders">Tenders</li>
        </ul>
        <div class="tab-content" id="WebCollectionTabContent">
            <div class="tab-pane fade show active" id="home-tab-pane" role="tabpanel" aria-labelledby="home-tab" tabindex="0">Cause List</div>
            <div class="tab-pane fade" id="profile-tab-pane" role="tabpanel" aria-labelledby="profile-tab" tabindex="0">Judgements</div>
            <div class="tab-pane fade" id="contact-tab-pane" role="tabpanel" aria-labelledby="contact-tab" tabindex="0">Case Stats</div>
            <div class="tab-pane fade" id="disabled-tab-pane" role="tabpanel" aria-labelledby="disabled-tab" tabindex="0">Judiciary Map</div>
            <div class="tab-pane fade" id="disabled-tab-pane" role="tabpanel" aria-labelledby="disabled-tab" tabindex="0">Projects</div>
            <div class="tab-pane fade" id="disabled-tab-pane" role="tabpanel" aria-labelledby="disabled-tab" tabindex="0">Tenders</div>
        </div>
    </div>
  )
}

export default CollectionTabs