import React, {useState, createContext} from 'react';

export interface Option {
  key: string;
  value?: string;
  name?: string;
  category: string;
  price: number;
  id: number;
  imgSrc: string;
}

interface SelectedOptionContextType {
  selectedOptions: Option[];
  addOption: (option: Option) => void;
}

const initialOptions: Option[] = [
  {
    key: '파워트레인',
    value: '디젤 2.2',
    category: 'car',
    price: 1480000,
    id: 1,
    imgSrc:
      'https://h3cardb.s3.ap-northeast-2.amazonaws.com/powertrain/%E1%84%83%E1%85%B5%E1%84%8C%E1%85%A6%E1%86%AF2.2.jpg',
  },
  {
    key: '구동 방식',
    value: '2WD',
    category: 'car',
    price: 0,
    id: 1,
    imgSrc:
      'https://h3cardb.s3.ap-northeast-2.amazonaws.com/drivingsystem/2WD.png',
  },
  {
    key: '바디 타입',
    value: '7인승',
    category: 'car',
    price: 0,
    id: 1,
    imgSrc: 'https://h3cardb.s3.ap-northeast-2.amazonaws.com/bodytype/7.jpg',
  },
  {
    key: '외장 색상',
    value: '어비스 블랙펄',
    category: 'color',
    price: 0,
    id: 1,
    imgSrc:
      'https://h3cardb.s3.ap-northeast-2.amazonaws.com/exterior_color/%E1%84%8B%E1%85%AC%E1%84%8C%E1%85%A1%E1%86%BC_%E1%84%8B%E1%85%A5%E1%84%87%E1%85%B5%E1%84%89%E1%85%B3%E1%84%87%E1%85%B3%E1%86%AF%E1%84%85%E1%85%A2%E1%86%A8%E1%84%91%E1%85%A5%E1%86%AF.png',
  },
  {
    key: '내장 색상',
    value: '퀼팅천연(블랙)',
    category: 'color',
    price: 0,
    id: 1,
    imgSrc:
      'https://h3cardb.s3.ap-northeast-2.amazonaws.com/interior_color/%E1%84%82%E1%85%A2%E1%84%8C%E1%85%A1%E1%86%BC_%E1%84%8F%E1%85%AF%E1%86%AF%E1%84%90%E1%85%B5%E1%86%BC%E1%84%8E%E1%85%A5%E1%86%AB%E1%84%8B%E1%85%A7%E1%86%AB_%E1%84%87%E1%85%B3%E1%86%AF%E1%84%85%E1%85%A2%E1%86%A8.png',
  },
  {
    key: '휠',
    value: '20인치 알로이 휠 & 타이어',
    category: 'car',
    price: 0,
    id: 1,
    imgSrc:
      'https://h3cardb.s3.ap-northeast-2.amazonaws.com/wheel/%E1%84%80%E1%85%B5%E1%84%87%E1%85%A9%E1%86%AB_20%E1%84%8B%E1%85%B5%E1%86%AB%E1%84%8E%E1%85%B5+%E1%84%8B%E1%85%A1%E1%86%AF%E1%84%85%E1%85%A9%E1%84%8B%E1%85%B5+%E1%84%92%E1%85%B1%E1%86%AF+%26+%E1%84%90%E1%85%A1%E1%84%8B%E1%85%B5%E1%84%8B%E1%85%A5.jpg',
  },
];

const defaultContextValue: SelectedOptionContextType = {
  selectedOptions: initialOptions,
  addOption: () => {},
};

export const SelectedOptionContext =
  createContext<SelectedOptionContextType>(defaultContextValue);

interface SelectedOptionProviderProps {
  children: React.ReactNode;
}

const SelectedOptionProvider = ({children}: SelectedOptionProviderProps) => {
  const [selectedOptionsState, setSelectedOptionsState] =
    useState<Option[]>(initialOptions);
  const order = [
    '파워트레인',
    '구동 방식',
    '바디 타입',
    '외장 색상',
    '내장 색상',
    '휠',
  ];

  const addOption = (newOption: Option) => {
    setSelectedOptionsState((prevOptions) => {
      // 기존 배열에서 동일한 key를 가진 아이템 제거
      const filteredOptions = prevOptions.filter(
        (opt) => opt.key !== newOption.key,
      );
      // 새로운 아이템 추가
      const sortedOptions = [...filteredOptions, newOption].sort((a, b) => {
        return order.indexOf(a.key) - order.indexOf(b.key);
      });

      return sortedOptions;
    });
  };

  const contextValue = {
    selectedOptions: selectedOptionsState,
    addOption,
  };

  return (
    <SelectedOptionContext.Provider value={contextValue}>
      {children}
    </SelectedOptionContext.Provider>
  );
};

export default SelectedOptionProvider;

// const { selectedOptions, addOption } = useContext(SelectedOptionContext);
