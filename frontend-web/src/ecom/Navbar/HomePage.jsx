import React, { useEffect, useState } from "react";
import { VStack, Input, Button, FormControl, FormLabel } from "@chakra-ui/react";
import Navbar from "./Navbar";
import Footer from "./Footer";
import axios from "axios";
import { useNavigate } from "react-router-dom"; // Import useHistory from react-router-dom

const CarpoolHomePage = () => {
  const [fromCity, setFromCity] = useState("");
  const [toCity, setToCity] = useState("");
  const [selectedDate, setSelectedDate] = useState("");
  const [suggestions, setSuggestions] = useState([]);
  


  const handleFromCityChange = (e) => {
    setFromCity(e.target.value);
    if (e.target.value) {
      fetchSuggestions(e.target.value);
    }
  };

  const handleToCityChange = (e) => {
    setToCity(e.target.value);
    if (e.target.value) {
      fetchSuggestions(e.target.value);
    }
  };

  const handleDateChange = (e) => {
    setSelectedDate(e.target.value);
  };

  const fetchSuggestions = (input) => {
    axios
      .get(
        `https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${input}&key=${process.env.REACT_APP_GOOGLE_PLACES_API_KEY}`
      )
      .then((response) => {
        setSuggestions(response.data.predictions);
      })
      .catch((error) => {
        console.error("Error fetching suggestions:", error);
      });
  };

  return (
    <div className="carpool-homepage">
      <Navbar />

      <header className="header">
        <h1>Welcome to Carpool</h1>
        <p>Share Rides, Reduce Emissions</p>
      </header>

      <section className="search-form">
        <h2>Search for Rides</h2>
        <VStack spacing={4}>
          <FormControl>
            <FormLabel htmlFor="fromCity">From City:</FormLabel>
            <Input
              type="text"
              id="fromCity"
              name="fromCity"
              value={fromCity}
              onChange={handleFromCityChange}
            />
          </FormControl>
          <FormControl>
            <FormLabel htmlFor="toCity">To City:</FormLabel>
            <Input
              type="text"
              id="toCity"
              name="toCity"
              value={toCity}
              onChange={handleToCityChange}
            />
          </FormControl>
          <FormControl>
            <FormLabel htmlFor="selectedDate">Date:</FormLabel>
            <Input
              type="date"
              id="selectedDate"
              name="selectedDate"
              value={selectedDate}
              onChange={handleDateChange}
            />
          </FormControl>
          {suggestions.length > 0 && (
            <div>
              <h3>Suggestions:</h3>
              <ul>
                {suggestions.map((suggestion) => (
                  <li key={suggestion.place_id}>{suggestion.description}</li>
                ))}
              </ul>
            </div>
          )}
          <Button colorScheme="teal">Search</Button>
        </VStack>
      </section>

      <footer className="footer">
        <Footer />
        <p>&copy; 2023 Carpool</p>
      </footer>
    </div>
  );
};

export default CarpoolHomePage;
