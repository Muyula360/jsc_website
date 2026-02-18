import { Link } from 'react-router-dom';
import { useContext } from 'react';
import { LanguageContext } from "../context/Language";
import NewsHighlights from '../components/NewsHighlights';

const History = () => {
  const { language } = useContext(LanguageContext);

  const translations = {
    en: {
      home: "Home",
      pageTitle: "Who we Are",
      aboutTitle: "About the Judicial Service Commission",
      paragraph_1: `The Judicial Service Commission was established under Article 112(1) of the Constitution of the United Republic of Tanzania, 1977 as read in conjunction with the Judicial Administration Act, Chapter 237.`,
      paragraph_2: `Prior to the enactment of the Judicial Service Act No. 2 of 2005, now referred to as the Judicial Administration Act, Chapter 237, there were two separate Commissions that handled judicial officers: The Judicial Service Commission, which dealt with Resident Magistrates and District Magistrates, and a special Judicial Service Commission that handled Primary Court Magistrates.`,
      paragraph_3: `Currently, the Judicial Service Commission manages all employment and disciplinary matters for judicial officers. The composition and functions of the Commission are outlined in the Constitution of the United Republic of Tanzania and the Judicial Administration Act, Chapter 237.`,
      paragraph_4: `In carrying out its mandate to oversee the conduct of judicial and non-judicial officers, the Commission has delegated its powers to Ethics Committees at various levels. These committees are tasked with investigating and inquiring complaints against judges, magistrates, and other judicial officers and reporting to the Commission for a decision.`,
    },
    sw: {
      home: "Mwanzo",
      pageTitle: "Sisi ni nani",
      aboutTitle: "Kuhusu Tume ya Utumishi wa Mahakama",
      paragraph_1: `Tume ya Utumishi wa Mahakama imeanzishwa kwa mujibu wa Ibara ya 112 (1) ya Katiba ya Jamhuri ya Muungano wa Tanzania ya mwaka 1977 ikisomwa pamoja na Sheria ya Usimamizi wa Mahakama Sura ya 237.`,
      paragraph_2: `Kabla ya kutungwa kwa Sheria ya Utumishi wa Mahakama Na. 2 ya mwaka 2005, na sasa Sheria ya Usimamizi wa Mahakama sura ya 237, kulikuwa na Tume mbili zilizokuwa zinashughulikia watumishi wa Mahakama yaani Tume ya Utumishi wa Mahakama iliyokuwa inashughulikia Mahakimu Wakazi na Mahakimu wa Wilaya na Tume maalum ya Utumishi wa Mahakama iliyokuwa inashughulikia Mahakimu wa Mahakama za Mwanzo.`,
      paragraph_3: `Kwa sasa masuala ya ajira na nidhamu ya Watumishi wa Mahakama yanashughulikiwa na Tume ya Utumishi wa Mahakama. Wajumbe na majukumu ya Tume yameainishwa kwenye Katiba ya Jamhuri ya Muungano wa Tanzania na Sheria ya Usimamizi wa Mahakama sura ya 237.`,
      paragraph_4: `Katika kutekeleza jukumu la kusimamia maadili ya Maafisa Mahakama, Tume imekasimu Madaraka yake kwa Kamati za Maadili katika ngazi mbali mbali. Kamati hizo zimepewa jukumu la kupeleleza na kuchunguza malalamiko dhidi ya Majaji, Mahakimu, na Watumishi wasio Maafisa Mahakama na kuwasilisha taarifa Tume kwa ajili ya uamuzi.`,
     }
  };

  const t = translations[language] || translations.en;

  return (
    <>
 <div className="position-relative">
        <div className="page-banner text-center">
          <div className="container d-flex flex-column justify-content-center" style={{ height: "130px" }} >
            <h2 className="text-white fw-bold my-1">{t.pageTitle}</h2>
            <ol className="breadcrumb mt-2 justify-content-center">
              <li className="breadcrumb-item"><Link to="/">{t.home}</Link> </li>
              <li className="breadcrumb-item active">{t.pageTitle}</li>
            </ol>
          </div>
        </div>
      </div>

      <div className="container my-5">
        <div className="row">
          <div className="col-lg-8">
            <div className="mb-5">
             <h4 className='text-center text-md-start fw-semibold'>{t.aboutTitle}</h4>
             <div className='card-pane p-4 mt-5'>
              <p className='text-justify fs-18'>{t.paragraph_1}</p>
              <p className='text-justify fs-18'>{t.paragraph_2}</p>
              <p className='text-justify fs-18'>{t.paragraph_3}</p>
              <p className='text-justify fs-18'>{t.paragraph_4}</p>
             </div>
            </div>
          </div>

          <div className="col-lg-4 mt-5 mt-lg-0">
            <NewsHighlights />
          </div>
        </div>
      </div>
    </>
  );
};

export default History;