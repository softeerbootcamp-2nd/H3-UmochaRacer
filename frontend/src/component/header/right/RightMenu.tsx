import React from 'react';
import styled from 'styled-components';
import l from '../../../assets/icons/l.svg';
import {flexCenter} from '../../../style/common';
import Dictionary from './Dictionary';
import CarMode from './CarMode';
function RightMenu() {
  return (
    <Wrapper>
      <Dictionary />
      <img src={l} />
      <CarMode />
    </Wrapper>
  );
}

export default RightMenu;
const Wrapper = styled.div`
  ${flexCenter};
  gap: 20px;
`;
