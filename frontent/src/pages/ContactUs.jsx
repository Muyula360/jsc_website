import { Link } from 'react-router-dom';
import { useState, useEffect, useContext } from 'react';
import { useDispatch, useSelector } from "react-redux";
import { postFeedback, postReset } from '../features/feedbackSlice';
import { LanguageContext } from "../context/Language"; // adjust path if needed
import { capitalize } from '../utils/stringManipulation';

const ContactUs = () => {
  const dispatch = useDispatch();
  const { language } = useContext(LanguageContext);

  const { postLoading, postSuccess, postError, message } =
    useSelector((state) => state.feedbacks);

  const [submitterName, setSubmitterName] = useState('');
  const [submitterEmail, setSubmitterEmail] = useState('');
  const [feedbackSubject, setFeedbackSubject] = useState('');
  const [feedbackBody, setFeedbackBody] = useState('');
  const [showSuccess, setShowSuccess] = useState(false);

  /* ================= TRANSLATIONS ================= */
  const translations = {
    en: {
      contactUs: "Contact Us",
      home: "Home",
      head:"The Judicial Service Commission",
      street:"Mahakama Street",
      address:"P.O Box",
      leaveMessage: "Leave your Message",
      contactNote: "Contact us today using this form and we will reach you asap.",
      fullname: "Your fullname",
      email: "Your email",
      subject: "Subject",
      message: "Write your message...",
      sendMessage: "Send Message",
      success: "Message sent successfully!",
      addressTitle: "Address",
      openHours: "Open Hours",
      openTime: "Mon - Fri 8:00 am - 4:00 pm",
      phone: "Phone",
      mail:"Email",
      intro:"Judicial Service Commission House is located at Dodoma(RQ37+M9), near SGR railway and Dar es Salaam Highway.",
    },
    sw: {
      contactUs: "Wasiliana Nasi",
      home: "Mwanzo",
      head:"Tume ya Utumishi wa Mahakama",
      street:"Mtaa wa Mahakama",
      address:"S.L.P",
      leaveMessage: "Acha Ujumbe Wako",
      contactNote: "Wasiliana nasi kupitia fomu hii nasi tutakujibu haraka iwezekanavyo.",
      fullname: "Majina Kamili",
      email: "Barua pepe",
      subject: "Kichwa cha habari",
      message: "Andika ujumbe wako...",
      sendMessage: "Tuma Ujumbe",
      success: "Ujumbe umetumwa kikamilifu!",
      addressTitle: "Anuani",
      openHours: "Muda wa Kazi",
      openTime: "Jumatatu - Ijumaa 8:00 asubuhi - 4:00 jioni",
      phone: "Simu",
      mail:"Barua Pepe",
      intro:"Jengo la Tume ya Utumishi wa mahakama linapatikana Dodoma (RQ37+M9), Karibu na Reli ya SGR na Barabara ya Dar es Salaam",
    },
  };

  const t = translations[language];

  /* ================= SUBMIT HANDLER ================= */
  const handleFeedbackSubmit = (e) => {
    e.preventDefault();
    dispatch(
      postFeedback({
        submitterFullname: submitterName,
        submitterEmail,
        feedbackSubject,
        feedbackBody,
      })
    );
  };

  /* ================= RESET AFTER SUCCESS ================= */
  useEffect(() => {
    if (postSuccess) {
      setSubmitterName('');
      setSubmitterEmail('');
      setFeedbackSubject('');
      setFeedbackBody('');

      setShowSuccess(true);
      const timeout = setTimeout(() => {
        setShowSuccess(false);
        dispatch(postReset());
      }, 5000);

      return () => clearTimeout(timeout);
    }
  }, [postSuccess, dispatch]);

  return (
    <>
      {/* ================= PAGE BANNER ================= */}
      <div className="position-relative">
        <div className="page-banner text-center">
          <div
            className="container d-flex flex-column justify-content-center"
            style={{ height: "130px" }}
          >
            <h2 className="text-white fw-bold my-1">
              {t.contactUs}
            </h2>

            <ol className="breadcrumb mt-2 justify-content-center">
              <li className="breadcrumb-item">
                <Link to="/">{t.home}</Link>
              </li>
              <li className="breadcrumb-item active">
                {t.contactUs}
              </li>
            </ol>
          </div>
        </div>
      </div>

      {/* ================= CONTENT ================= */}
      <div className="container my-3 py-3">
        <div className="row py-3 g-4">
          <div className="col-lg-6 col-md-6 col-sm-12 mb-3">
            <h4 className="text-heading fw-semibold mb-3">{t.head}</h4>
            <p className="w-100 text-justify fs-18">{t.intro}</p>
            <h5 className="fw-semibold mt-3">{t.addressTitle}</h5>
            <p className="mb-1">{capitalize(t.head)}</p>
            <p className="mb-1">2, {t.street}</p>
            <p className="mb-1">{t.address} 2705</p>
            <p className="mb-1">41104 Tambukareli, Dodoma</p>
            <p className="mt-3 mb-1 ms-3">
              <i className="bi bi-clock text-danger"></i>
              <span className="ms-2"> {t.openHours}: {t.openTime}</span>
            </p>
            <p className='mb-1 ms-3'>
              <i className="bi bi-telephone-inbound text-danger"></i>
              <span className="ms-2">{t.phone}:</span>{" "}<Link to="tel:+255262320001">+255 (0) 262 320 001</Link>
            </p>
            <p className='ms-3'>
              <i className="bi bi-envelope text-danger"></i>
              <span className="ms-2">{t.mail}:</span>{" "}<Link to="mailto:secretary@jsc.go.tz">secretary@jsc.go.tz</Link>
            </p>
          </div>
          <div className="col-lg-6 col-md-6 col-sm-12">
            <h4 className="fw-bold text-center text-md-start">{t.leaveMessage}</h4>     
            <form className="mt-4" onSubmit={handleFeedbackSubmit}>
              {showSuccess && (
                <div className="shadow-sm py-3 mb-3 text-center">
                  <i className="bi bi-check-circle-fill text-success me-1"></i>
                  {t.success}
                </div>
              )}
              {postError && (
                <div className="alert alert-danger py-2 text-center">
                  {message}
                </div>
              )}
              <div className="form-floating mb-2">
                <input type="text" className="form-control" value={submitterName} onChange={(e) => setSubmitterName(e.target.value)} required />
                <label>{t.fullname}</label>
              </div>
              <div className="form-floating mb-2">
                <input type="email" className="form-control" value={submitterEmail} onChange={(e) => setSubmitterEmail(e.target.value)} required />
                <label>{t.email}</label>
              </div>
              <div className="form-floating mb-2">
                <input type="text" className="form-control" value={feedbackSubject} onChange={(e) => setFeedbackSubject(e.target.value)} required />
                <label>{t.subject}</label>
              </div>
              <div className="form-floating mb-3">
                <textarea className="form-control" style={{ height: "100px" }} value={feedbackBody} onChange={(e) => setFeedbackBody(e.target.value)} required />
                <label>{t.message}</label>
              </div>
              <div className="text-center text-md-end">
                <button type="submit" className="btn btn-accent" disabled={postLoading} >
                  {postLoading && (
                    <span className="spinner-border spinner-border-sm me-2"></span>
                  )}
                  {t.sendMessage}
                </button>
              </div>
            </form>
          </div>
        </div>

        <div className="my-5" style={{ height: "300px" }}        >
          <iframe
            title="Judiciary Service Commission Location"
            src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d326.24479796373714!2d35.7619118866144!3d-6.196441591333911!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x184de50076a6a169%3A0xebc3d8d1954014e7!2sTume%20ya%20Utumishi%20wa%20Mahakama!5e1!3m2!1sen!2stz!4v1770360212406!5m2!1sen!2stz"
            style={{ width: "100%", height: "100%", border: 0 }}
            allowFullScreen
            loading="lazy"
            referrerPolicy="no-referrer-when-downgrade"
          />
        </div>
      </div>
    </>
  );
};

export default ContactUs;
