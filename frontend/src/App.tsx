import {BrowserRouter, Routes, Route} from 'react-router-dom';
import React from 'react';
import Self from './pages/Self';
import Guide from './pages/Guide';
import Main from './pages/Main';
import OptionProvider from './provider/optionProvider';
import {ModalProvider} from './provider/modalProvider';
import Modal from './component/modal/Modal';
import SelectedOptionProvider from './provider/selectedOptionProvider';
import TempOptionProvider from './provider/tempOptionProvider';
import {CardbProvider} from './provider/cardbProvider';
import {GiudFlowProvider} from './provider/guideFlowProvider';
import TempAdditionalOptionProvider from './provider/tempAdditionalOptionProvider';
import SelectedAdditionalOptionProvider from './provider/additionalOptionProvider';
import {ImageSrcProvider} from './provider/tempImageProvider';
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
    <AppProvider
      contexts={[
        OptionProvider,
        ModalProvider,
        SelectedOptionProvider,
        TempOptionProvider,
        CardbProvider,
        GiudFlowProvider,
        TempAdditionalOptionProvider,
        SelectedAdditionalOptionProvider,
        ImageSrcProvider,
      ]}
    >
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<Main />} />
          <Route path="/self" element={<Self />} />
          <Route path="/guide" element={<Guide />} />
        </Routes>
      </BrowserRouter>
      <Modal />
    </AppProvider>
  );
}

export default App;
