import React, {useState, createContext} from 'react';

export const OptionContext = createContext({
  option: 0,
  setOption: (option: number) => {},
});

interface OptionProviderProps {
  children: React.ReactNode;
}

const OptionProvider = ({children}: OptionProviderProps) => {
  const [optionState, setOptionState] = useState<number>(0);

  const setOption = (option: number) => {
    if (option === -1 || option === 8) return;
    setOptionState(option);
  };

  const contextValue = {
    option: optionState,
    setOption: setOption,
  };

  return (
    <OptionContext.Provider value={contextValue}>
      {children}
    </OptionContext.Provider>
  );
};

export default OptionProvider;
