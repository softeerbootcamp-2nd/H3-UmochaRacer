import React from 'react';
import styled from 'styled-components';
import OptionItem from './OptionItem';
import {flexCenter} from '../../style/common';
import ProgressBar from './ProgressBar';
function Progress() {
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

  const menuItemController = () => {
    return menuItems.map((menuItem: string, index: number) => (
      <OptionItem
        key={index}
        idx={index}
        menuName={menuItem}
        selected={index === 0}
      />
    ));
  };

  return (
    <>
      <Wrapper>
        <OptionItemWrapper>{menuItemController()}</OptionItemWrapper>
      </Wrapper>
      <ProgressBar />
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
  ${flexCenter}
  gap: 60px;
`;
