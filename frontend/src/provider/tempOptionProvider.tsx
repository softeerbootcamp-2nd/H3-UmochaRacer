import React, {useState, createContext} from 'react';

interface Option {
  key: string;
  value: string;
  category: string;
  price: number;
  id: number;
  imgSrc: string;
  userSelect: boolean;
}

const initialOption: Option = {
  key: '',
  value: '',
  category: '',
  price: 0,
  id: 0,
  imgSrc: '',
  userSelect: false,
};

export const TempOptionContext = createContext({
  tempOption: initialOption,
  setTempOption: (option: Option) => {},
});

interface TempOptionProviderProps {
  children: React.ReactNode;
}

const TempOptionProvider = ({children}: TempOptionProviderProps) => {
  const [tempOptionState, setTempOptionState] = useState<Option>(initialOption);

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
