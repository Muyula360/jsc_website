// LanguageContext.js
import { createContext, useState } from "react";

export const LanguageContext = createContext();

export const LanguageProvider = ({ children }) => {
  const [language, setLanguage] = useState("sw"); // default Swahili

  const toggleLanguage = () => {
    setLanguage(prev => (prev === "sw" ? "en" : "sw"));
  };

  return (
    <LanguageContext.Provider value={{ language, toggleLanguage }}>
      {children}
    </LanguageContext.Provider>
  );
};
