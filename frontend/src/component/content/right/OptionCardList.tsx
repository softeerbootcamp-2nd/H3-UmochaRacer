import React, {useEffect, useContext, useRef, useState} from 'react';
import styled, {keyframes} from 'styled-components';
import OptionCard from './card/OptionCard';
import {cardDataType} from '../contentInterface';
import {OptionContext} from '@/provider/optionProvider';
import {fetchData} from '@/api/fetchData';
import {getCategory} from '@/component/util/getCategory';

interface cardListProps {
  cardData: cardDataType[];
  isSaved: boolean;
  setNewIndex: (index: number) => void;
  selectedIndex: number;
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
interface SelectionRatioProps {
  id: number;
  selectionRatio: number;
}
function OptionCardList({
  cardData,
  setNewIndex,
  isSaved,
  selectedIndex,
}: cardListProps) {
  const {option} = useContext(OptionContext);
  const ulRef = useRef<HTMLUListElement>(null);
  const [ratioList, setRatioList] = useState<SelectionRatioProps[]>([]);

  const handleItemClick = (index: number) => {
    if (selectedIndex === index) return;
    setNewIndex(index);
  };

  useEffect(() => {
    if (cardData) scrollIntoSelected(ulRef, selectedIndex);
  }, [selectedIndex, cardData]);
  const categoryName = getCategory(option);
  useEffect(() => {
    const fetchRateList = async () => {
      const getRatioList = await fetchData(`/sale/${categoryName}/select`);
      setRatioList(getRatioList);
    };
    fetchRateList();
  }, [cardData]);

  const cards: React.JSX.Element[] =
    cardData &&
    cardData.map((elem, index) => (
      <OptionCard
        key={index}
        selected={selectedIndex === index}
        isSaved={isSaved}
        onClick={() => {
          handleItemClick(index);
        }}
        data={elem}
        ratioList={ratioList}
      />
    ));

  return (
    <>
      <Wrapper key={option}>
        <Container ref={ulRef}>{cards}</Container>
      </Wrapper>
    </>
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
