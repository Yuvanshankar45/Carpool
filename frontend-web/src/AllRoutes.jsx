import { Navigate, Route, Routes } from "react-router-dom";
import Login from "./ecom/LoginSignups/Login";
import Signup from "./ecom/LoginSignups/Signup";
import HomePage from "./ecom/Navbar/HomePage";

// import Admin from "./Admin";
const MainRoute = () => {
  const Token=(child)=>{
    let token=JSON.parse(localStorage.getItem("token"));
    console.log(token);
    if(token!=null){
      return child;
    } else {
      alert("Login First");
      return <Navigate to="/login" />
    }
  };
  return (
    <Routes>
        <Route path="/login" element={<Login />}/>
        <Route path="/signup" element={<Signup />}/>
        <Route path="/" element={<HomePage />}/>
    </Routes>
  );
};

export default MainRoute;