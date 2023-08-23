import React, {useState, createContext} from 'react';
import {cardDataType} from '@/component/content/contentInterface';

interface SelectedAdditionalOptionContextType {
  selectedAdditionalOption: cardDataType[];
  setSelectedAdditionalOption: (options: cardDataType[]) => void;
}

export const SelectedAdditionalOptionsContext =
  createContext<SelectedAdditionalOptionContextType>({
    selectedAdditionalOption: [],
    setSelectedAdditionalOption: () => {},
  });

interface SelectedAdditionalOptionsProviderProps {
  children: React.ReactNode;
}

const SelectedAdditionalOptionProvider: React.FC<
  SelectedAdditionalOptionsProviderProps
> = ({children}) => {
  const [optionsState, setOptionsState] = useState<cardDataType[]>([]);

  const setSelectedAdditionalOption = (options: cardDataType[]) => {
    setOptionsState(options);
  };

  const contextValue = {
    selectedAdditionalOption: optionsState,
    setSelectedAdditionalOption,
  };

  return (
    <SelectedAdditionalOptionsContext.Provider value={contextValue}>
      {children}
    </SelectedAdditionalOptionsContext.Provider>
  );
};

export default SelectedAdditionalOptionProvider;
