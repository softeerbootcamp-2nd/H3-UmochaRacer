import React, {useState, createContext} from 'react';
import {cardDataType} from '@/component/content/contentInterface';

interface OptionContextType {
  additionOptions: cardDataType[];
  setAdditionalOptions: (options: cardDataType[]) => void;
  removeOption: (id: number) => void;
}

export const TempAdditionalOptionsContext = createContext<OptionContextType>({
  additionOptions: [],
  setAdditionalOptions: () => {},
  removeOption: () => {},
});

interface OptionsProviderProps {
  children: React.ReactNode;
}

const TempAdditionalOptionProvider: React.FC<OptionsProviderProps> = ({
  children,
}) => {
  const [optionsState, setOptionsState] = useState<cardDataType[]>([]);

  const setAdditionalOptions = (options: cardDataType[]) => {
    setOptionsState(options);
  };

  const removeOption = (id: number) => {
    setOptionsState((prevOptions) =>
      prevOptions.filter((opt) => opt.id !== id),
    );
  };

  const contextValue = {
    additionOptions: optionsState,
    setAdditionalOptions,
    removeOption,
  };

  return (
    <TempAdditionalOptionsContext.Provider value={contextValue}>
      {children}
    </TempAdditionalOptionsContext.Provider>
  );
};

export default TempAdditionalOptionProvider;
