// src/layouts/PublicLayout.jsx
import { Outlet } from "react-router-dom";
import Header from "../components/Header";
import Footer from "../components/Footer";
import { LanguageProvider } from "../context/Language";
import { SearchProvider } from "../context/searchContext";
import SearchInitializer from "../components/SearchInitializer"; // Now this will work

const PublicLayout = () => {
    return (
        <div style={{ backgroundColor: '#D7F8FA' }}>
            <LanguageProvider>
                <SearchProvider>
                    <SearchInitializer /> {/* This registers static content */}
                    <header>
                        <Header />
                    </header>
                    <main>
                        <Outlet />
                    </main>
                    <footer>
                        <Footer/>
                    </footer>
                </SearchProvider>
            </LanguageProvider>
        </div>
    );
}

export default PublicLayout;