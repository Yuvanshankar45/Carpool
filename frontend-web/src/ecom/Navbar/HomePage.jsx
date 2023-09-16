// CarpoolHomePage.js

import React from "react";
import Navbar from "./Navbar";
import Footer from "./Footer";

const CarpoolHomePage = () => {
  return (
    <div className="carpool-homepage">
      <Navbar />

      <header className="header">
        <h1>Welcome to Carpool</h1>
        <p>Share Rides, Reduce Emissions</p>
      </header>

      <section className="features">
        <div className="feature">
          <h2>Find Rides</h2>
          <p>Discover rides going your way and save money.</p>
        </div>

        <div className="feature">
          <h2>Offer Rides</h2>
          <p>Share your ride and reduce your carbon footprint.</p>
        </div>

        <div className="feature">
          <h2>Join the Community</h2>
          <p>Connect with like-minded commuters.</p>
        </div>
      </section>

      <footer className="footer">
      <Footer/>
        <p>&copy; 2023 Carpool</p>
      </footer>
    </div>
   
  );
};

export default CarpoolHomePage;
