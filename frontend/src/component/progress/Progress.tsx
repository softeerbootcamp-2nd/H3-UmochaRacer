import React, {useState} from 'react';
import styled from 'styled-components';
import {flexCenter} from '@/style/common';
import OptionItem from './OptionItem';
import ProgressBar from './ProgressBar';
import {colors} from '@/style/theme';
function Progress() {
  const [selectedOption, setSelectedOption] = useState(0);
  const menuItems = [
    '파워트레인',
    '구동 방식',
    '바디 타입',
    '외장 색상',
    '내장 색상',
    '휠 선택',
    '옵션 선택',
    '견적 내기',
  ];
  const handleOptionClick = (index: number) => {
    setSelectedOption(index);
  };
  const menuItemController = () => {
    return menuItems.map((menuItem: string, index: number) => (
      <OptionItem
        key={index}
        idx={index}
        menuName={menuItem}
        selected={index === selectedOption}
        onClick={() => handleOptionClick(index)}
      />
    ));
  };

  return (
    <>
      <Wrapper>
        <OptionItemWrapper>
          {menuItemController()}
          <SelectedBar active={selectedOption} />
        </OptionItemWrapper>
        <ProgressBar />
      </Wrapper>
    </>
  );
}

export default Progress;

const Wrapper = styled.div`
  position: relative;
  ${flexCenter}
  width: 100%;
  height: 26px;
  flex-direction: column;
`;

const OptionItemWrapper = styled.div`
  /* width: 100%; */
  height: 100%;
  ${flexCenter}
  position: relative;
`;
export const SelectedBar = styled.div<{active: number}>`
  position: absolute;
  left: ${({active}) => `${active * 120}px`};
  bottom: -2px;

  display: flex;
  justify-content: center;
  text-align: center;

  width: 120px;
  height: 2px;

  background-color: ${colors.Main_Hyundai_Blue};

  transition: 0.4s ease-in-out;

  z-index: 1;
`;
