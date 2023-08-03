import React from 'react';
import styled from 'styled-components';
import Logo from './Logo';
import ModeSelector from './ModeSelector';
import l from '../../../assets/icons/l.svg';
import {flexCenter} from '../../../style/common';
function LeftMenu() {
  return (
    <Wrapper>
      <Logo />
      <img src={l} />
      <ModeSelector />
    </Wrapper>
  );
}

export default LeftMenu;
const Wrapper = styled.div`
  ${flexCenter};
  gap: 20px;
`;
