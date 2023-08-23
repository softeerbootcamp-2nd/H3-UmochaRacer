import React, {useState, createContext} from 'react';

interface Option {
  key: string;
  value: string;
  category: string;
  price: number;
  id: number;
  imgSrc: string;
}

const initailOption: Option = {
  key: '',
  value: '',
  category: '',
  price: 0,
  id: 0,
  imgSrc: '',
};

export const TempOptionContext = createContext({
  tempOption: Option,
  setTempOption: (option: Option) => {},
});

interface TempOptionProviderProps {
  children: React.ReactNode;
}

const TempOptionProvider = ({children}: TempOptionProviderProps) => {
  const [tempOptionState, setTempOptionState] = useState<Option>(initailOption);

  const setTempOption = (option: Option) => {
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
