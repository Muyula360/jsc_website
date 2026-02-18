import { useEffect } from 'react';
import { Provider, useDispatch, useSelector  } from 'react-redux';

import { BrowserRouter as Router, Routes, Route } from "react-router-dom";

// for react toast
import { ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";

// for scroll/reveal animations
import AOS from 'aos';
import 'aos/dist/aos.css';

import PublicLayout from "./Layouts/PublicLayout";
import ContentsmgrLayouts from "./Layouts/ContentsmgrLayouts";

import Home from "./pages/Home";
import AboutUs  from "./pages/AboutUs";
import CauseList  from "./pages/CauseList";
import Courts  from "./pages/Courts";
import CaseLaw  from "./pages/faqs";
import Judges from "./pages/Judges";
import JusticeOfAppeal from './pages/JusticeOfAppeal';
import JudgesOfHighCourt from './pages/JudgesOfHighCourt';
import FormerJudges from './pages/FormerJudges';
import Publications  from "./pages/Publications";
import NewsUpdates  from "./pages/NewsUpdates";
import BillboardPreview from "./pages/BillboardPreview";
import NewsUpdatesPreview from "./pages/NewsUpdatesPreview";
import Newsletter  from "./pages/Newsletter";
import Announcements  from "./pages/Announcements";
import Vacancies from "./pages/Vacancies";
import Tenders from "./pages/Tenders";
import Login from "./pages/Login";
import ResetPassword from './pages/ResetPassword';
import Biography from "./pages/Biography";
import MissionVision from "./pages/MissionVision";
import OrganizationStructure from './pages/OrganizationStructure';
import History from "./pages/History";
import ContactUs from "./pages/ContactUs";
import WhatWeDo from "./pages/whatwedo";
import CourtOfAppeal from "./pages/CourtOfAppeal";
import HighCourt from "./pages/HighCourt";
import PublicForms from "./pages/PublicForms";
import PublicReports from "./pages/PublicReports";
import PublicGuidelines from "./pages/PublicGuidelines";
import LawsRegulations from "./pages/LawsRegulations";
import Gallery from "./pages/Gallerry";
import Faqs from './pages/faqs';
import PageNotFound from "./pages/PageNotFound";


import ContentsMgrHome from "./pages/ContentsMgrHome";
import ContentsMgrAnnouncements from "./pages/ContentsMgrAnnouncements";
import ContentsMgrBillboard from "./pages/ContentsMgrBillboards";
import ContentsMgrNewsletters from "./pages/ContentsMgrNewsletters";
import ContentsMgrNewsupdates from "./pages/ContentsMgrNewsupdates";
import ContentsMgrLeaders from "./pages/ContentsMgrLeaders";
import ContentsMgrTenders from "./pages/ContentsMgrTenders";
import ContentsMgrVacancies from "./pages/ContentsMgrVacancies";
import ContentsMgrCorevalues from "./pages/ContentsMgrCorevalues";
import ContentsMgrGallery from "./pages/ContentsMgrGallery";
import ContentsMgrPublications from "./pages/ContentsMgrPublications";
import ContentsMgrUsers from "./pages/ContentsMgrUsers";
import ContentsMgrRoles from "./pages/ContentsMgrRoles";
import ContentsMgrSettings from "./pages/ContentsMgrSettings";
import ContentsMgrAccount from "./pages/ContentsMgrAccount";
import ContentsMgrNotification from "./pages/ContentsMgrNotification";
import ContentsMgrFeedbacks from "./pages/ContentsMgrFeedbacks";
import ContentsMgrSpeeches from './pages/ContentsMgrSpeeches';



import store from "./app/store"; 
import { getCSRFToken } from "./features/csrfSlice";
import { postWebsiteVisit } from "./features/websiteVisitSlice";
import ScrollToTop from './components/ScrolltoTop';
import ContentsMgrFAQs from './pages/ContentsMgrFaqs';
import SearchResults from './pages/SearchResults';
import Stakeholders from './pages/stakeholders';




// app component component
function AppContent() {

  const dispatch = useDispatch();
  const { csrfToken } = useSelector( state => state.csrf );

  useEffect(() => {
    AOS.init({
      duration: 1000,
      once: true,    
    });
  }, []);

  useEffect(() => {
    if (!csrfToken) {
      //dispatch getCSRFToken request
      dispatch(getCSRFToken());

    }else{

      //dispatch postWebsiteVisit request
      dispatch(postWebsiteVisit());
    }
  }, [dispatch, csrfToken ]);

  
  // App Component UI
  return (
    <>
      <ToastContainer position="top-center" autoClose={3000} hideProgressBar={false} newestOnTop={false} />
      <Router>
        <ScrollToTop />
        <Routes>
          {/* Public Layout */}
          <Route path="/" element={<PublicLayout />}>
            <Route index element={<Home />} />
            <Route path="vacancies" element={<Vacancies />} />
            <Route path="tenders" element={<Tenders />} />
            <Route path="login" element={<Login />} />
            <Route path="resetPassword/:resetPwdToken" element={<ResetPassword />} />
            <Route path="aboutus" element={<AboutUs />} />
            <Route path="faqs" element={<Faqs />} />
            <Route path="judges" element={<Judges />} />
            <Route path="causelist" element={<CauseList />} />
            <Route path="newsupdates" element={<NewsUpdates />} />
            <Route path="newsupdates/:id/:slug" element={<NewsUpdatesPreview />} />
            <Route path="billboard/:billboardID" element={<BillboardPreview />} />
            <Route path="newsletter" element={<Newsletter />} />
            <Route path="announcements" element={<Announcements />} />
            <Route path="biography/:leaderTitleID" element={<Biography />} />
            <Route path="mission&vision" element={<MissionVision />} />
            <Route path="contactus" element={<ContactUs />} />
            <Route path="who-we-are" element={<History />} />
            <Route path="what-we-do" element={<WhatWeDo />} />
            <Route path="organizationstructure" element={<OrganizationStructure />} />
            <Route path="courtofappeal" element={<CourtOfAppeal />} />
            <Route path="highcourt" element={<HighCourt />} />
            <Route path="justiceofappeal" element={<JusticeOfAppeal />} />
            <Route path="judgesofhighcourt" element={<JudgesOfHighCourt />} />
            <Route path="stakeholders" element={<Stakeholders />} />
            <Route path="publicforms" element={<PublicForms />} />
            <Route path="publicreports" element={<PublicReports />} />
            <Route path="guidelines" element={<PublicGuidelines/>} />
            <Route path="laws&regulations" element={<LawsRegulations/>} />
            <Route path="laws&regulations" element={<History />} />
            <Route path="journals&arrticles" element={<History />} />
            <Route path="judiciarygallery" element={<Gallery />} />
            <Route path="gallery" element={<History />} />
            <Route  path='search' element={<SearchResults/>} /> 

            {/* 404 Page - Catch All Unmatched Routes */}
            <Route path="*" element={<PageNotFound />} />
          </Route>

          {/* Web Contents Management Layout */}
          <Route path="/webcontentsmgr" element={<ContentsmgrLayouts />}>
            <Route index element={<ContentsMgrHome />} />
            <Route path="settings" element={<ContentsMgrSettings />} />
            <Route path="myAccount" element={<ContentsMgrAccount />} />
            <Route path="notifications" element={<ContentsMgrNotification />} />
            <Route path="feedbacks" element={<ContentsMgrFeedbacks />} />
            <Route path="newsupdates" element={<ContentsMgrNewsupdates />} />
            <Route path="billboard" element={<ContentsMgrBillboard />} />
            <Route path="speeches" element={<ContentsMgrSpeeches />} />
            <Route path="announcements" element={<ContentsMgrAnnouncements />} />
            <Route path="managementLeaders" element={<ContentsMgrLeaders />} />
            <Route path="vacancies" element={<ContentsMgrVacancies />} />
            <Route path="tenders" element={<ContentsMgrTenders  />} />
            <Route path="corevalues" element={<ContentsMgrCorevalues />} />      
            <Route path="users" element={<ContentsMgrUsers />} /> 
            <Route path="userroles" element={<ContentsMgrRoles />} />s
            <Route path="publications" element={<ContentsMgrPublications />} /> 
            <Route path="gallery" element={<ContentsMgrGallery />} /> 
            <Route path="faqs" element={<ContentsMgrFAQs />} /> 
            

            {/* 404 Page - Catch All Unmatched Routes */}
            <Route path="*" element={<PageNotFound />} />
          </Route>
        </Routes>
      </Router>
    </>

  );
}


// Main App component with Provider
function App() {
  return (
    <Provider store={store}>
      <AppContent />
    </Provider>
  );
}

export default App
