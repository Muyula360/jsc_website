import React, { useState } from "react";

const SearchWithToggle = () => {
  const [showSearch, setShowSearch] = useState(false);

  const handleToggle = () => {
    setShowSearch((prev) => !prev);
  };

  return (
    <li className="nav-item nav-search d-none d-md-flex">
      <div className="nav-link">
        <div className="input-group">
          {showSearch ? (
            <div className="input-group">
              <input
                type="text"
                className="form-control"
                placeholder="Search"
                aria-label="Search"
                autoFocus // Autofocus on input when shown
              />
              <div className="input-group-append">
                <button
                  className="btn btn-outline-secondary"
                  onClick={handleToggle}
                >
                  <i className="fas fa-times"></i> {/* Close icon */}
                </button>
              </div>
            </div>
          ) : (
            <span
              className="input-group-text"
              onClick={handleToggle}
              style={{ cursor: "pointer" }}
            >
              <i className="fas fa-search"></i> {/* Search icon */}
            </span>
          )}
        </div>
      </div>
    </li>
  );
};

export default SearchWithToggle;
