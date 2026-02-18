// SearchResults.js
import { Link } from 'react-router-dom';
import { useSearch } from '../context/searchContext';

const SearchResults = ({ onClose }) => {
  const { searchQuery, searchResults, isSearching } = useSearch();

  if (!searchQuery.trim()) return null;

  return (
    <div className="search-results-container">
      <div className="search-results-header">
        <h6>Search Results for: "{searchQuery}"</h6>
        <button onClick={onClose} className="btn-close"></button>
      </div>
      
      {isSearching ? (
        <div className="text-center py-3">
          <div className="spinner-border spinner-border-sm" role="status">
            <span className="visually-hidden">Searching...</span>
          </div>
        </div>
      ) : (
        <>
          {searchResults.length > 0 ? (
            <ul className="search-results-list">
              {searchResults.map((result, index) => (
                <li key={index} className="search-result-item">
                  <Link to={result.path} onClick={onClose}>
                    <div className="result-title">{result.title}</div>
                    <div className="result-preview">
                      {result.content.substring(0, 100)}...
                    </div>
                    <div className="result-category">{result.category}</div>
                  </Link>
                </li>
              ))}
            </ul>
          ) : (
            <p className="no-results">No results found</p>
          )}
        </>
      )}
    </div>
  );
};

export default SearchResults;