import React, {useState} from 'react';
import './App.css';
import {BrowserRouter, Route, Routes} from "react-router-dom";
import Header from "../Header/Header";
import Boody from "../Boody/Boody";
import Select from "../Select/Select";

const App = () => {
    const [loading, setLoading] = useState<boolean>(false);

    return (
        <BrowserRouter>
            <Header/>
            <Boody isLoading={loading}>
                <Routes>
                    <Route path="/select/:id" element={<Select setLoading={setLoading}/>}/>
                    <Route path="/*" element={<div> h x h x h x </div>}/>
                </Routes>
            </Boody>
        </BrowserRouter>
    );
}

export default App;
