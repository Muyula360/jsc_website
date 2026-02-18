import { configureStore } from '@reduxjs/toolkit';
import csrfReducer from '../features/csrfSlice';
import userAuthReducer from '../features/authSlice';
import forgotPasswordReducer from '../features/forgotPasswordSlice';
import resetPasswordReducer from '../features/resetPasswordSlice';
import authValidationReducer from '../features/authValidationSlice';
import annoucementReducer from '../features/announcementSlice';
import speechReducer from '../features/speechSlice';
import billboardReducer from '../features/billboardSlice';
import judgesReducer from '../features/judgeSlice';
import leadersReducer from '../features/leaderSlice';
import newsupdatesReducer from '../features/newsUpdateSlice';
import newslettersReducer from '../features/newsLetterSlice';
import publicationReducer from '../features/publicationSlice';
import galleryReducer from '../features/gallerySlice';
import tendersReducer from '../features/tenderSlice';
import vacanciesReducer from '../features/vacanciesSlice';
import projectsReducer from '../features/projectsSlice';
import feedbacksReducer from '../features/feedbackSlice';
import notificationsReducer from '../features/notificationSlice';
import websiteVisitReducer from '../features/websiteVisitSlice';
import contenthighlightReducer from '../features/contenthighlightSlice';
import weeklyVisitsTrendsReducer from '../features/weeklyvisittrendSlice';
import userReducer from '../features/userSlice';
import judgmentReducer from '../features/judgementSlice';
import faqReducer from '../features/faqsSlice'; 

const store = configureStore({
  reducer: {
    csrf: csrfReducer,
    userAuth: userAuthReducer,
    resetPasswordLink: forgotPasswordReducer,
    resetPassword: resetPasswordReducer,
    authValidation: authValidationReducer,
    announcements: annoucementReducer,
    speech: speechReducer,
    billboards: billboardReducer,
    leaders: leadersReducer,
    judges: judgesReducer,
    newsUpdates: newsupdatesReducer,
    newsletters: newslettersReducer,
    publications: publicationReducer,
    gallery: galleryReducer,
    feedbacks: feedbacksReducer,
    notifications: notificationsReducer,
    tenders: tendersReducer,
    projects: projectsReducer,
    judgments: judgmentReducer,
    vacancies: vacanciesReducer,
    websiteVisit: websiteVisitReducer,
    contenthighlights: contenthighlightReducer,
    weeklyVisitsTrends: weeklyVisitsTrendsReducer,
    users: userReducer,
    faqs: faqReducer,
  },
});

export default store;