import React, {useEffect, useState, useContext, useRef} from 'react';
import styled, {keyframes} from 'styled-components';
import OptionCard from './card/OptionCard';
import {cardDataType} from '../contentInterface';
import {OptionContext} from '@/provider/optionProvider';
interface Data {
  optionId: number;
  name: string;
  rate: number;
  price: number;
}

interface carfListProps {
  cardData: cardDataType[];
  setNewIndex: (index: number) => void;
}

const moveTop = keyframes`
  0% {
    transform: translateY(100%);
  }
  100% {
    transform: translateY(0);
  }
`;

const scrollIntoSelected = (
  elem: React.RefObject<HTMLUListElement>,
  index: number,
) => {
  const scrollBlock: ScrollIntoViewOptions = {
    behavior: 'smooth',
    block: 'center',
  };

  if (elem && elem.current) {
    const scrollItem = elem.current.childNodes[index] as HTMLElement;

    if (elem.current.lastChild === scrollItem) {
      scrollBlock.block = 'end';
    }

    scrollItem.scrollIntoView(scrollBlock);
  }
};

function OptionCardList({cardData, setNewIndex}: carfListProps) {
  const [selectedItem, setSelectedItem] = useState<number>(0);
  const {option} = useContext(OptionContext);
  const ulRef = useRef<HTMLUListElement>(null);

  const handleItemClick = (index: number) => {
    setNewIndex(index);
    setSelectedItem(index);
  };

  useEffect(() => {
    setSelectedItem(0);
  }, [cardData]);

  useEffect(() => {
    scrollIntoSelected(ulRef, selectedItem);
  }, [selectedItem]);

  const cards: React.JSX.Element[] = cardData.map((elem, index) => (
    <OptionCard
      key={index}
      selected={selectedItem === index}
      onClick={() => handleItemClick(index)}
      data={elem}
      option={option}
    ></OptionCard>
  ));

  return (
    <Wrapper key={option}>
      <Container ref={ulRef}>{cards}</Container>
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
  margin-bottom: 30px;
  width: 100%;

  // animation: ${moveTop} 1s ease-out;
  gap: 16px;
`;
