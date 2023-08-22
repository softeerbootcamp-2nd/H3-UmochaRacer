import React, {useEffect, useContext, useRef, useState} from 'react';
import styled, {keyframes} from 'styled-components';
import OptionCard from './card/OptionCard';
import {cardDataType} from '../contentInterface';
import {OptionContext} from '@/provider/optionProvider';

interface cardListProps {
  cardData: cardDataType[];
  isSaved: boolean;
  setNewIndex: (index: number) => void;
  selectedIndex: number;
  onClick: () => void;
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
  if (elem && elem.current && elem.current.childNodes[index]) {
    const scrollItem = elem.current.childNodes[index] as HTMLElement;

    if (elem.current.lastChild === scrollItem) {
      scrollBlock.block = 'end';
    }
    scrollItem.scrollIntoView(scrollBlock);
  }
};

function SelectedOptionCardList({
  cardData,
  setNewIndex,
  isSaved,
  selectedIndex,
}: cardListProps) {
  const {option} = useContext(OptionContext);
  const ulRef = useRef<HTMLUListElement>(null);
  const [selectedItems, setSelectedItems] = useState<cardDataType[]>([]);

  const handleItemClick = (index: number) => {
    const clickedItem = cardData[index];
    // 선택된 아이템 배열에 이미 해당 아이템이 존재하는지 확인
    if (selectedItems.includes(clickedItem)) {
      // 선택 취소: 배열에서 아이템 제거
      setSelectedItems((prev) => prev.filter((item) => item !== clickedItem));
    } else {
      // 선택: 배열에 아이템 추가
      setSelectedItems((prev) => [...prev, clickedItem]);
    }
    setNewIndex(index);
  };
  useEffect(() => {
    if (cardData) scrollIntoSelected(ulRef, selectedIndex);
  }, [selectedIndex, cardData]);

  const cards: React.JSX.Element[] =
    cardData &&
    cardData.map((elem, index) => (
      <OptionCard
        key={index}
        selected={selectedItems.includes(elem)}
        isSaved={isSaved}
        onClick={() => handleItemClick(index)}
        data={elem}
      />
    ));

  return (
    <Wrapper key={option}>
      <Container ref={ulRef}>{cards}</Container>
    </Wrapper>
  );
}

export default SelectedOptionCardList;

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
