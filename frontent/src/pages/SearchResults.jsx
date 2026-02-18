// src/pages/SearchResults.jsx
import { Link, useNavigate, useSearchParams } from 'react-router-dom';
import { useEffect, useState, useContext } from 'react';
import { useSearch } from '../context/searchContext';
import { LanguageContext } from '../context/Language';

const SearchResults = () => {
  const [searchParams] = useSearchParams();
  const query = searchParams.get('q') || '';
  const navigate = useNavigate();

  const { language } = useContext(LanguageContext);
  const {
    setSearchQuery,
    searchResults,
    isSearching,
    performSearch,
    isInitialized
  } = useSearch();

  const [openResult, setOpenResult] = useState(null);

  useEffect(() => {
    if (query && isInitialized) {
      setSearchQuery(query);
      performSearch(query);
    }
  }, [query, setSearchQuery, performSearch, isInitialized]);

  const translations = {
    en: {
      home: "Home",
      backToHome: "Back to Home",
      searchTitle: "Search Results",
      loading: "Loading ...",
      searching: "Searching for results...",
      initializing: "Initializing search index...",
      noQuery: "Enter a search term to find content.",
      noQueryMessage: "Please enter a search term in the search box above to find content across the website.",
      noResults: "No results found",
      noResultsMessage: "Try different keywords or browse our pages using the navigation menu.",
      results: "result",
      results_plural: "results",
      found: "Found",
      category: "Category",
      tags: "Tags",
      readMore: "Read more",
      openPDF: "Open PDF"
    },
    sw: {
      home: "Mwanzo",
      backToHome: "Rudi Mwanzo",
      searchTitle: "Matokeo ya Utafutaji",
      loading: "Inapakia ...",
      searching: "Inatafuta matokeo...",
      initializing: "Inaandaa faharasa ya utafutaji...",
      noQuery: "Weka neno la utafutaji kupata matokeo.",
      noQueryMessage: "Tafadhali weka neno la utafutaji kwenye kisanduku cha utafutaji hapo juu kupata matokeo kwenye tovuti nzima.",
      noResults: "Hakuna matokeo yaliyopatikana",
      noResultsMessage: "Jaribu maneno mengine au vinjari kurasa zetu kwa kutumia menyu ya urambazaji.",
      results: "matokeo",
      results_plural: "matokeo",
      found: "Yamepatikana",
      category: "Kategoria",
      tags: "Lebo",
      readMore: "Soma zaidi",
      openPDF: "Fungua PDF"
    }
  };

  const t = translations[language] || translations.en;

  const toggleResult = (id) => {
    setOpenResult(openResult === id ? null : id);
  };

  const handleResultClick = (e, result) => {
    e.preventDefault();
    
    if (result.external) {
      window.open(result.path, '_blank', 'noopener noreferrer');
    } else {
      navigate(result.path);
    }
  };

  if (!query) {
    return (
      <>
        <div className="position-relative">
          <div className="page-banner text-center">
            <div className="container d-flex flex-column justify-content-center" style={{ height: "130px" }}>
              <h2 className="text-white fw-bold my-1">{t.searchTitle}</h2>
              <ol className="breadcrumb mt-2 justify-content-center">
                <li className="breadcrumb-item"><Link to="/">{t.home}</Link></li>
                <li className="breadcrumb-item active">{t.searchTitle}</li>
              </ol>
            </div>
          </div>
        </div>

        <div className="container my-5">
          <div className="text-center py-5">
            <div className="mb-4">
              <div className="bg-light bg-opacity-10 rounded-circle p-4 d-inline-block">
                <i className="bi bi-search text-muted fs-1"></i>
              </div>
            </div>
            
            <h5 className="fw-bold text-muted mb-2">{t.noQuery}</h5>
            <p className="text-muted mb-4">{t.noQueryMessage}</p>
            
            <Link to="/" className="btn btn-danger rounded-5 px-4 py-2">
              <i className="bi bi-house me-2"></i>
              {t.backToHome}
            </Link>
          </div>
        </div>
      </>
    );
  }

  if (!isInitialized) {
    return (
      <>
        <div className="position-relative">
          <div className="page-banner text-center">
            <div className="container d-flex flex-column justify-content-center" style={{ height: "130px" }}>
              <h2 className="text-white fw-bold my-1">{t.searchTitle}</h2>
              <ol className="breadcrumb mt-2 justify-content-center">
                <li className="breadcrumb-item"><Link to="/">{t.home}</Link></li>
                <li className="breadcrumb-item active">{t.searchTitle}</li>
              </ol>
            </div>
          </div>
        </div>

        <div className="container my-5">
          <div className="text-center py-5">
            <div className="spinner-border text-danger mb-3" style={{ width: '3rem', height: '3rem' }} role="status">
              <span className="visually-hidden">{t.loading}</span>
            </div>
            <h5 className="fw-bold text-muted mb-2">{t.initializing}</h5>
            <p className="text-muted">{t.searching}</p>
          </div>
        </div>
      </>
    );
  }

  return (
    <>
      <div className="position-relative">
        <div className="page-banner text-center">
          <div className="container d-flex flex-column justify-content-center" style={{ height: "130px" }}>
            <h2 className="text-white fw-bold my-1">{t.searchTitle}</h2>
            <ol className="breadcrumb mt-2 justify-content-center">
              <li className="breadcrumb-item"><Link to="/">{t.home}</Link></li>
              <li className="breadcrumb-item active">{t.searchTitle}</li>
            </ol>
          </div>
        </div>
      </div>

      <div className="container my-5">
        <div className="d-flex justify-content-between align-items-center mb-4">
          <h4 className='fw-bold mb-0'>
            {t.searchTitle}: "{query}"
          </h4>

          {!isSearching && searchResults?.length > 0 && (
            <span className="badge bg-danger bg-opacity-10 text-danger px-3 py-2">
              {t.found} {searchResults.length}{" "}
              {searchResults.length === 1 ? t.results : t.results_plural}
            </span>
          )}
        </div>

        {isSearching ? (
          <div className="text-center py-5">
            <div className="spinner-border text-danger mb-3" role="status">
              <span className="visually-hidden">{t.loading}</span>
            </div>
            <h6>{t.loading}</h6>
            <p className="text-muted small">{t.searching}</p>
          </div>
        ) : searchResults.length > 0 ? (
          <div className="accordion">
            {searchResults.map((result, index) => (
              <div className="accordion-item border rounded-3 m-2 shadow-sm" key={result.id}>
                <h2 className="accordion-header">
                  <button
                    className={`accordion-button ${openResult === result.id ? '' : 'collapsed'}`}
                    type="button"
                    onClick={() => toggleResult(result.id)}
                  >
                    <span className="me-3 text-muted fw-normal">{index + 1}.</span>
                    {result.title}
                    {result.external && (
                      <span className="ms-2 badge bg-danger bg-opacity-10 text-danger">
                        <i className="bi bi-file-pdf me-1"></i>PDF
                      </span>
                    )}
                  </button>
                </h2>

                <div className={`accordion-collapse collapse ${openResult === result.id ? 'show' : ''}`}>
                  <div className="accordion-body">
                    <p style={{ whiteSpace: 'pre-line' }}>
                      {result.content?.length > 200
                        ? `${result.content.substring(0, 200)}...`
                        : result.content}
                    </p>

                    <div className="d-flex flex-wrap gap-2 mb-3">
                      {result.category && (
                        <span className="badge bg-primary bg-opacity-10 text-primary px-3 py-2">
                          {t.category}: {result.category}
                        </span>
                      )}
                    </div>

                    {result.external ? (
                      <a
                        href={result.path}
                        onClick={(e) => handleResultClick(e, result)}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="text-decoration-none fw-semibold text-danger"
                      >
                        <i className="bi bi-file-pdf me-1"></i>
                        {t.openPDF} →
                      </a>
                    ) : (
                      <Link
                        to={result.path || '/'}
                        onClick={(e) => handleResultClick(e, result)}
                        className="text-decoration-none fw-semibold text-danger"
                      >
                        {t.readMore} →
                      </Link>
                    )}
                  </div>
                </div>
              </div>
            ))}
          </div>
        ) : (
          <div className="card-pane text-center py-3 pb-3">
            <div className="mb-2">
              <div className="bg-light rounded-circle p-1 d-inline-block">
                <i className="bi bi-question-circle text-info fs-1 opacity-10"></i>
              </div>
            </div>
            
            <h6 className="fw-semibold mb-2">{t.noResults}</h6>
            <p className="text-muted small mb-4">{t.noResultsMessage}</p>

            <Link to="/" className="btn btn-outline-danger rounded-5 px-4 py-2">
              <i className="bi bi-house me-2"></i>
              {t.backToHome}
            </Link>
          </div>
        )}
      </div>
    </>
  );
};

export default SearchResults;