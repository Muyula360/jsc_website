// src/components/SearchInitializer.jsx
import { useEffect, useRef, useCallback, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { useSearch } from '../context/searchContext';
import { getSpeeches } from '../features/speechSlice';
import { getFAQs } from '../features/faqsSlice';
import { getNewsupdates } from '../features/newsUpdateSlice';

const SearchInitializer = () => {
  const dispatch = useDispatch();
  const { registerContent, unregisterContent, markInitialized } = useSearch();
  
  const [speechesRegistered, setSpeechesRegistered] = useState(false);
  const [faqsRegistered, setFaqsRegistered] = useState(false);
  const [newsRegistered, setNewsRegistered] = useState(false);

  const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

  const getPDFUrl = (attachmentPath) => {
    if (!attachmentPath || !webMediaURL) return null;
    const baseUrl = webMediaURL.endsWith('/') ? webMediaURL : `${webMediaURL}/`;
    const cleanPath = attachmentPath.startsWith('/') ? attachmentPath.slice(1) : attachmentPath;
    return `${baseUrl}${cleanPath}`;
  };

  useEffect(() => {
    dispatch(getSpeeches());
    dispatch(getFAQs());
    dispatch(getNewsupdates());
  }, [dispatch]);

  const speechesData = useSelector((state) => ({
    speeches: state?.speech?.speeches || [],
    speechesSuccess: state?.speech?.isSuccess || false,
    speechesLoading: state?.speech?.isLoading || false,
    speechesError: state?.speech?.isError || false
  }));

  const faqsData = useSelector((state) => ({
    faqs: state?.faqs?.faqs || [],
    faqsSuccess: state?.faqs?.isSuccess || false,
    faqsLoading: state?.faqs?.isLoading || false,
    faqsError: state?.faqs?.isError || false
  }));

  const newsData = useSelector((state) => ({
    news: state?.newsUpdates?.newsupdates || [],
    newsSuccess: state?.newsUpdates?.isSuccess || false,
    newsLoading: state?.newsUpdates?.isLoading || false,
    newsError: state?.newsUpdates?.isError || false
  }));

  const { speeches, speechesSuccess, speechesLoading, speechesError } = speechesData;
  const { faqs, faqsSuccess, faqsLoading, faqsError } = faqsData;
  const { news, newsSuccess, newsLoading, newsError } = newsData;

  useEffect(() => {
    const timeoutId = setTimeout(() => {
      if (!(speechesRegistered && faqsRegistered && newsRegistered)) {
        markInitialized();
      }
    }, 5000);

    return () => clearTimeout(timeoutId);
  }, [speechesRegistered, faqsRegistered, newsRegistered, markInitialized]);

  useEffect(() => {
    if (speechesRegistered && faqsRegistered && newsRegistered) {
      markInitialized();
    }
  }, [speechesRegistered, faqsRegistered, newsRegistered, markInitialized]);

  useEffect(() => {
    if (speechesLoading) {
      return;
    }

    if (speechesError) {
      setSpeechesRegistered(true);
      return;
    }

    if (speechesSuccess && speeches && speeches.length > 0) {
      speeches.forEach((speech) => {
        if (speech.announcementID && speech.announcementTitle) {
          let pdfUrl = null;
          try {
            pdfUrl = speech.hasAttachment && speech.attachmentPath 
              ? getPDFUrl(speech.attachmentPath) 
              : null;
          } catch (error) {
            // Silently handle error
          }
          
          registerContent({
            id: `speech-${speech.announcementID}`,
            title: speech.announcementTitle,
            content: `${speech.announcementTitle} ${speech.announcementDesc || ''}`,
            category: 'Speeches',
            tags: [
              'speech', 
              'hotuba', 
              'matamko',
              speech.hasAttachment ? 'pdf' : 'no-pdf'
            ],
            path: pdfUrl || `/speeches/${speech.announcementID}`,
            external: !!pdfUrl
          });
        }
      });
      
      setSpeechesRegistered(true);
    } else if (speechesSuccess && speeches.length === 0) {
      setSpeechesRegistered(true);
    } else if (!speechesLoading && !speechesSuccess) {
      setSpeechesRegistered(true);
    }

    return () => {
      if (speeches.length > 0) {
        speeches.forEach((speech) => {
          if (speech.announcementID) {
            unregisterContent(`speech-${speech.announcementID}`);
          }
        });
      }
    };
  }, [speechesSuccess, speeches, speechesLoading, speechesError, registerContent, unregisterContent]);

  useEffect(() => {
    if (faqsLoading) {
      return;
    }

    if (faqsError) {
      setFaqsRegistered(true);
      return;
    }

    if (faqsSuccess && faqs && faqs.length > 0) {
      faqs.forEach((faq) => {
        if (faq.faqsID && faq.question) {
          registerContent({
            id: `faq-${faq.faqsID}`,
            title: faq.question,
            content: `${faq.question} ${faq.answer || ''}`,
            category: 'FAQs',
            tags: ['faq', 'question', 'answer', 'help'],
            path: `/faqs#${faq.faqsID}`,
            external: false
          });
        }
      });
      setFaqsRegistered(true);
    } else if (faqsSuccess && faqs.length === 0) {
      setFaqsRegistered(true);
    } else if (!faqsLoading && !faqsSuccess) {
      setFaqsRegistered(true);
    }
  }, [faqsSuccess, faqs, faqsLoading, faqsError, registerContent]);

  useEffect(() => {
    if (newsLoading) {
      return;
    }

    if (newsError) {
      setNewsRegistered(true);
      return;
    }

    if (newsSuccess && news && news.length > 0) {
      news.forEach((article) => {
        if (article.newsupdatesID && article.newsTitle) {
          registerContent({
            id: `news-${article.newsupdatesID}`,
            title: article.newsTitle,
            content: `${article.newsTitle} ${article.newsDesc || ''}`,
            category: 'News',
            tags: ['Habari', 'News', 'matukio', 'events'],
            path: `/news/${article.newsupdatesID}`,
            external: false
          });
        }
      });
      setNewsRegistered(true);
    } else if (newsSuccess && news.length === 0) {
      setNewsRegistered(true);
    } else if (!newsLoading && !newsSuccess) {
      setNewsRegistered(true);
    }
  }, [newsSuccess, news, newsLoading, newsError, registerContent]);

  return null;
};

export default SearchInitializer;