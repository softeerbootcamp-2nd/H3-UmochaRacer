import {BrowserRouter, Routes, Route} from 'react-router-dom';
import React, {useEffect} from 'react';
import Self from './pages/Self';
import Main from './pages/Main';
import Loading from './pages/Loading';
import OptionProvider from './provider/optionProvider';
interface AppProviderProps {
  contexts: React.ElementType[];
  children: React.ReactNode;
}

function App() {
  const AppProvider = ({contexts, children}: AppProviderProps) =>
    contexts.reduce(
      (prev: React.ReactNode, context: React.ElementType) =>
        React.createElement(context, {
          children: prev,
        }),
      children,
    );
  return (
    <AppProvider contexts={[OptionProvider]}>
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<Main />} />
          <Route path="/self" element={<Self />} />
          <Route path="/loading" element={<Loading />} />
        </Routes>
      </BrowserRouter>
    </AppProvider>
  );
}

export default App;
