import {Body2_Medium} from '@/style/fonts';
import {colors} from '@/style/theme';
import React from 'react';
import styled, {css} from 'styled-components';

import {
  useGuideFlowState,
  useGuideFlowDispatch,
  UPDATE_AGE,
  UPDATE_GENDER,
} from '@/provider/guideFlowProvider';

const Selecticon = () => {
  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="24"
      height="24"
      viewBox="0 0 24 24"
      fill="none"
    >
      <path
        d="M12 22C6.477 22 2 17.523 2 12C2 6.477 6.477 2 12 2C17.523 2 22 6.477 22 12C22 17.523 17.523 22 12 22ZM10.643 16.243L17.713 9.172L16.299 7.758L10.643 13.415L7.814 10.586L6.4 12L10.643 16.243Z"
        fill="#0E2B5C"
      />
    </svg>
  );
};
const DefaultIcon = () => {
  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="24"
      height="24"
      viewBox="0 0 24 24"
      fill="none"
    >
      <path
        d="M12 22C6.477 22 2 17.523 2 12C2 6.477 6.477 2 12 2C17.523 2 22 6.477 22 12C22 17.523 17.523 22 12 22ZM12 20C14.1217 20 16.1566 19.1571 17.6569 17.6569C19.1571 16.1566 20 14.1217 20 12C20 9.87827 19.1571 7.84344 17.6569 6.34315C16.1566 4.84286 14.1217 4 12 4C9.87827 4 7.84344 4.84286 6.34315 6.34315C4.84286 7.84344 4 9.87827 4 12C4 14.1217 4.84286 16.1566 6.34315 17.6569C7.84344 19.1571 9.87827 20 12 20ZM10.5 16L6.257 11.757L7.671 10.343L10.5 13.172L16.156 7.515L17.571 8.929L10.5 16Z"
        fill="#AEB1B7"
      />
    </svg>
  );
};

interface MapType {
  [key: string]: string;
}
const ageMap: MapType = {
  20: '20대',
  30: '30대',
  40: '40대',
  50: '50대',
  60: '60대',
  70: '70대',
};

const gendersMap: MapType = {FEMALE: '여성', MALE: '남성', NONE: '선택 안함'};
const FIRST_FLOW: number = 0;

interface Props {
  flowLevel: number;
  onClick: (index: number) => void;
}

function CardList({flowLevel, onClick}: Props) {
  const giudeFlowState = useGuideFlowState();
  const giudeFlowDipatch = useGuideFlowDispatch();

  const handleClickCard = (nextOption: string | number) => {
    if (typeof nextOption === 'number')
      giudeFlowDipatch({
        type: UPDATE_AGE,
        payload: {dataObject: {age: nextOption}},
      });
    else
      giudeFlowDipatch({
        type: UPDATE_GENDER,
        payload: {dataObject: {gender: nextOption}},
      });
  };

  const dataMap = flowLevel === FIRST_FLOW ? ageMap : gendersMap;
  const dataArr =
    flowLevel === FIRST_FLOW ? giudeFlowState.ages : giudeFlowState.genders;

  const cards = dataArr.map((elem, index) => {
    let isSelected: boolean;

    if (flowLevel === FIRST_FLOW)
      isSelected = elem === giudeFlowState.dataObject.age;
    else isSelected = elem === giudeFlowState.dataObject.gender;

    return (
      <Card.Container
        key={index}
        $isSelected={isSelected}
        onClick={() => {
          handleClickCard(elem);
          onClick(flowLevel + 1);
        }}
      >
        <Card.Category>{dataMap[elem]}</Card.Category>
        <Card.Icon>{isSelected ? Selecticon() : DefaultIcon()}</Card.Icon>
      </Card.Container>
    );
  });

  return <Wrapper>{cards}</Wrapper>;
}

export default CardList;

const Wrapper = styled.ul`
  display: flex;
  flex-direction: column;
  gap: 12px;
`;

const SelectedCard = css`
  background: ${colors.Hyundai_White};
  border: 2px solid ${colors.Main_Hyundai_Blue};
  div {
    color: #212121;
  }
`;

const DefaultCard = css`
  background: ${colors.Cool_Grey_001};
  border: 2px solid transparent;
  div {
    color: ${colors.Cool_Grey_003};
  }
`;

const Card = {
  Container: styled.li<{$isSelected: boolean}>`
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 343px;
    height: 60px;
    padding: 20px;
    cursor: pointer;
    border-radius: 6px;
    transition: 0.5s;
    ${({$isSelected}) => ($isSelected ? SelectedCard : DefaultCard)}

    &:hover {
      ${SelectedCard}
    }
  `,

  Category: styled.div`
    ${Body2_Medium}
    transition: 0.5s;
  `,

  Icon: styled.div`
    width: 24px;
    height: 24px;
    flex-shrink: 0;
  `,
};
