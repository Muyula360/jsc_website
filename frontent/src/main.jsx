import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App.jsx";

// Import Bootstrap CSS and JS
//import "bootstrap/dist/js/bootstrap.bundle.min.js"; (this import is replaced with '<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>' in index.html)
// import "bootstrap/dist/css/bootstrap.min.css";

// Import Bootstrap Icons
import "bootstrap-icons/font/bootstrap-icons.css";

// Import Fonts
import "@fontsource/cabin"; 
import "@fontsource/nunito-sans"; 
import "@fontsource/cormorant-garamond/700.css";

// website front layout styles
import "./styles/mainStylesheet.css";

// website contents manager layout styles
import "./styles/contentsMgrStylesheet.css"; 

// import "slick-carousel/slick/slick.css"; 
// import "slick-carousel/slick/slick-theme.css";


ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
