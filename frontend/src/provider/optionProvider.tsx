import React, {useState, createContext} from 'react';

export const OptionContext = createContext({
  option: 0,
  setOption: (option: number) => {}, // 초기값으로 빈 함수 설정
});

interface OptionProviderProps {
  children: React.ReactNode;
}

const OptionProvider = ({children}: OptionProviderProps) => {
  const [optionState, setOptionState] = useState<number>(0);

  const setOption = (option: number) => {
    if (option === -1) return;
    else if (option === 7) return;
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
