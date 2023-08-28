import React, {useEffect, useContext, useRef, useState} from 'react';
import styled, {keyframes} from 'styled-components';
import OptionCard from './card/OptionCard';
import {cardDataType} from '../contentInterface';
import {OptionContext} from '@/provider/optionProvider';
import {TempAdditionalOptionsContext} from '@/provider/tempAdditionalOptionProvider';
import {fetchData} from '@/api/fetchData';
import {getCategory} from '@/component/util/getCategory';
interface cardListProps {
  cardData: cardDataType[];
  isSaved: boolean;
  setNewIndex: (index: number) => void;
  selectedIndex: number;
  categoryIdx: number;
}
interface SelectionRatioProps {
  id: number;
  selectionRatio: number;
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
  categoryIdx,
}: cardListProps) {
  const {option} = useContext(OptionContext);
  const {additionOptions, setAdditionalOptions, removeOption} = useContext(
    TempAdditionalOptionsContext,
  );

  const [ratioList, setRatioList] = useState<SelectionRatioProps[]>([]);
  const ulRef = useRef<HTMLUListElement>(null);

  const handleItemClick = (index: number) => {
    const clickedItem = cardData[index];
    const isItemIncluded = additionOptions.some(
      (item) => item.id === clickedItem.id,
    );
    if (isItemIncluded) {
      removeOption(clickedItem.id);
    } else {
      setAdditionalOptions([...additionOptions, clickedItem]);
    }
    setNewIndex(index);
  };
  const categoryName = getCategory(option);
  useEffect(() => {
    if (cardData) scrollIntoSelected(ulRef, selectedIndex);
  }, [selectedIndex, cardData]);
  useEffect(() => {
    const fetchRateList = async () => {
      const categoryMap: Record<number, string> = {
        0: 'system',
        1: 'inner_device',
        2: 'outer_device',
        3: 'temperature',
      };
      const queryCategory = categoryMap[categoryIdx] || 'system';
      const endpoint = `/sale/${categoryName}/select?category=${queryCategory}`;

      const getRatioList = await fetchData(endpoint);
      setRatioList(getRatioList);
    };
    fetchRateList();
  }, [cardData, categoryIdx]);
  const cards: React.JSX.Element[] =
    cardData &&
    cardData.map((elem, index) => (
      <OptionCard
        key={index}
        selected={
          additionOptions.find((element) => elem.id === element.id) !==
          undefined
        }
        isSaved={isSaved}
        onClick={() => handleItemClick(index)}
        data={elem}
        ratioList={ratioList}
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
