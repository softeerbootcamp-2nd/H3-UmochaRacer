import React, {useState, createContext} from 'react';

interface Option {
  key: string;
  value: string;
  category: string;
  price: number;
  id: number;
  imgSrc: string;
}

export const TempOptionContext = createContext({
  tempOption: null as Option | null,
  setTempOption: (option: Option | null) => {},
});

interface TempOptionProviderProps {
  children: React.ReactNode;
}

const TempOptionProvider = ({children}: TempOptionProviderProps) => {
  const [tempOptionState, setTempOptionState] = useState<Option | null>(null);

  const setTempOption = (option: Option | null) => {
    setTempOptionState(option);
  };

  const contextValue = {
    tempOption: tempOptionState,
    setTempOption: setTempOption,
  };

  return (
    <TempOptionContext.Provider value={contextValue}>
      {children}
    </TempOptionContext.Provider>
  );
};

export default TempOptionProvider;
