import React, {useState} from 'react';
import styled from 'styled-components';
import OptionItem from './OptionItem';
import {flexCenter} from '../../style/common';
import ProgressBar from './ProgressBar';
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
          <ProgressBar />
          {menuItemController()}
        </OptionItemWrapper>
      </Wrapper>
    </>
  );
}

export default Progress;

const Wrapper = styled.div`
  ${flexCenter}
  width: 100%;
  height: 26px;
`;

const OptionItemWrapper = styled.div`
  width: 100%;
  height: 100%;
  ${flexCenter}
  gap: 60px;
  position: relative;
`;
