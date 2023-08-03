import React from 'react';
import styled from 'styled-components';
import {flexBetween, flexCenter} from '../../style/common';
import LeftMenu from './left/LeftMenu';
import RightMenu from './right/RightMenu';
function Header() {
  return (
    <Wrapper>
      <Content>
        <LeftMenu />
        <RightMenu />
      </Content>
    </Wrapper>
  );
}

export default Header;
const Wrapper = styled.div`
  width: 100%;
  height: 85px;
  ${flexCenter};
`;

const Content = styled.div`
  width: 100%;
  ${flexBetween};
  margin-left: 128px;
  margin-right: 127px;
`;
