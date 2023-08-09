import React, {useState} from 'react';
import styled from 'styled-components';
import {colors} from '../../../style/theme';
import OptionCard from './card/OptionCard';

interface Data {
  optionId: number;
  label: string;
  rate: number;
  price: number;
}

interface OptionCardListProps {
  cardData: Data[];
  setNewIndex: (index: number) => void;
}

function OptionCardList({cardData, setNewIndex}: OptionCardListProps) {
  const [selectedItem, setSelectedItem] = useState<number | null>(0);

  const handleItemClick = (index: number) => {
    setNewIndex(index);
    setSelectedItem(index);
  };

  const cards: React.JSX.Element[] = cardData.map((elem, index) => (
    <OptionCard
      key={index}
      selected={selectedItem === index}
      onClick={() => handleItemClick(index)}
      data={elem}
    ></OptionCard>
  ));

  return (
    <Wrapper>
      <Container>{cards}</Container>
    </Wrapper>
  );
}

export default OptionCardList;

const Wrapper = styled.div`
  &::-webkit-scrollbar {
    display: none;
  }

  width: 100%;
  height: 375px;
  margin-top: 32px;
  overflow-y: scroll;
`;

const Container = styled.ul`
  li {
    width: 100%;
  }
  display: inline-flex;
  flex-direction: column;
  align-items: flex-start;
  width: 100%;
  max-height: 485px;
  gap: 16px;
`;
