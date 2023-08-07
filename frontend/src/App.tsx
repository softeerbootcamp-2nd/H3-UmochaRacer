import {BrowserRouter, Routes, Route} from 'react-router-dom';
import React from 'react';
import Self from './pages/Self';
import Main from './pages/Main';
function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Main />} />
        <Route path="/self" element={<Self />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
