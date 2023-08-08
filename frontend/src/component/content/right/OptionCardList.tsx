import React, {useState} from 'react';
import styled from 'styled-components';
import {colors} from '../../../style/theme';
import OptionCard from './card/OptionCard';

function OptionCardList() {
  const [selectedItem, setSelectedItem] = useState<number | null>(0);

  const handleItemClick = (index: number) => {
    setSelectedItem(index);
  };

  const cards: React.JSX.Element[] = [0, 1, 2].map((index) => (
    <OptionCard
      key={index}
      isSelected={selectedItem === index}
      onClick={() => handleItemClick(index)}
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
  height: 485px;
  gap: 16px;
`;
