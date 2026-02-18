// SearchableContent.js
import { useEffect } from 'react';
import { useSearch } from '../context/searchContext';

const SearchableContent = ({ id, title, content, category, tags, children }) => {
  const { registerContent, unregisterContent } = useSearch();

  useEffect(() => {
    const contentItem = {
      id,
      title,
      content: typeof content === 'string' ? content : '',
      category,
      tags,
      // Add path for navigation
      path: window.location.pathname
    };

    registerContent(contentItem);

    return () => {
      unregisterContent(id);
    };
  }, [id, title, content, category, tags, registerContent, unregisterContent]);

  return children;
};

export default SearchableContent;