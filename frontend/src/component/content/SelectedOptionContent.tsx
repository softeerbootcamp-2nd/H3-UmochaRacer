import React, {useState} from 'react';
import SelectedOptionInfo from './right/SelectedOptionInfo';
import AdditionalOptionImage from './left/AdditionalOptionImage';
interface cardData {
  id: number;
  name: string;
  imageSrc: string;
  price: number;
}

interface cardDataProps {
  selectedOptionData: cardData[][];
  setNewIndex: (index: number) => void;
  selectedIndex: number;
}

function SelectedOptionContent({
  selectedOptionData,
  setNewIndex,
  selectedIndex,
}: cardDataProps) {
  const [selectedOptionCategory, setSelectedOptionCategory] =
    useState<number>(0);
  return (
    <>
      <AdditionalOptionImage
        cardData={selectedOptionData[selectedOptionCategory]}
        selectedIndex={selectedIndex}
      />
      <SelectedOptionInfo
        key={selectedOptionCategory}
        cardData={selectedOptionData[selectedOptionCategory]}
        setNewIndex={setNewIndex}
        selectedIndex={selectedIndex}
        setCategory={setSelectedOptionCategory}
        selectedCategory={selectedOptionCategory}
      />
    </>
  );
}

export default SelectedOptionContent;
