// src/context/searchContext.jsx
import React, { createContext, useState, useContext, useCallback, useMemo, useRef, useEffect } from 'react';

const SearchContext = createContext();

export const useSearch = () => {
  const context = useContext(SearchContext);
  if (!context) {
    throw new Error('useSearch must be used within a SearchProvider');
  }
  return context;
};

export const SearchProvider = ({ children }) => {
  const [searchQuery, setSearchQuery] = useState('');
  const [searchResults, setSearchResults] = useState([]);
  const [isSearching, setIsSearching] = useState(false);
  const [searchableContent, setSearchableContent] = useState([]);
  const [isInitialized, setIsInitialized] = useState(false);
  
  const searchTimeoutRef = useRef(null);
  const pendingSearches = useRef([]);
  const initializationTimeoutRef = useRef(null);

  const registerContent = useCallback((content) => {
    setSearchableContent(prev => {
      const exists = prev.some(item => item.id === content.id);
      if (exists) {
        return prev.map(item => item.id === content.id ? content : item);
      }
      return [...prev, content];
    });
  }, []);

  const unregisterContent = useCallback((id) => {
    setSearchableContent(prev => prev.filter(item => item.id !== id));
  }, []);

  const markInitialized = useCallback(() => {
    setIsInitialized(true);
    
    if (initializationTimeoutRef.current) {
      clearTimeout(initializationTimeoutRef.current);
    }
    
    if (pendingSearches.current.length > 0) {
      pendingSearches.current.forEach(query => {
        performSearch(query);
      });
      pendingSearches.current = [];
    }
  }, []);

  const performSearch = useCallback((query) => {
    if (searchTimeoutRef.current) {
      clearTimeout(searchTimeoutRef.current);
    }

    if (!query || !query.trim()) {
      setSearchResults([]);
      return;
    }

    if (!isInitialized) {
      if (!pendingSearches.current.includes(query)) {
        pendingSearches.current.push(query);
      }
      return;
    }

    setIsSearching(true);

    searchTimeoutRef.current = setTimeout(() => {
      const results = searchableContent.filter(item => {
        const searchableText = `
          ${item.title || ''} 
          ${item.content || ''} 
          ${item.category || ''} 
          ${item.tags ? item.tags.join(' ') : ''}
        `.toLowerCase();
        
        return searchableText.includes(query.toLowerCase());
      });
      
      setSearchResults(results);
      setIsSearching(false);
    }, 300);
  }, [isInitialized, searchableContent]);

  useEffect(() => {
    initializationTimeoutRef.current = setTimeout(() => {
      if (!isInitialized) {
        setIsInitialized(true);
        
        if (pendingSearches.current.length > 0) {
          pendingSearches.current.forEach(query => {
            performSearch(query);
          });
          pendingSearches.current = [];
        }
      }
    }, 5000);

    return () => {
      if (initializationTimeoutRef.current) {
        clearTimeout(initializationTimeoutRef.current);
      }
    };
  }, [isInitialized, performSearch]);

  const clearSearch = useCallback(() => {
    setSearchQuery('');
    setSearchResults([]);
  }, []);

  const value = useMemo(() => ({
    searchQuery,
    setSearchQuery,
    searchResults,
    isSearching,
    performSearch,
    clearSearch,
    registerContent,
    unregisterContent,
    markInitialized,
    isInitialized
  }), [searchQuery, searchResults, isSearching, performSearch, clearSearch, registerContent, unregisterContent, markInitialized, isInitialized]);

  return (
    <SearchContext.Provider value={value}>
      {children}
    </SearchContext.Provider>
  );
};