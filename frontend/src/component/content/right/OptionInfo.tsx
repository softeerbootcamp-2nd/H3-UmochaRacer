import React from 'react';
import styled from 'styled-components';
import OptionCardList from './OptionCardList';
import Footer from './Footer';
import {flexCenter} from '../../../style/common';
import {colors} from '../../../style/theme';

function SelectedOptionInfo() {
  return (
    <Wrapper>
      <Container>
        <OptionTitle>파워트레인</OptionTitle>
        <Text>을 선택해주세요.</Text>
        <OptionCardList></OptionCardList>
        <Footer></Footer>
      </Container>
    </Wrapper>
  );
}

export default SelectedOptionInfo;

const Wrapper = styled.div`
  ${flexCenter}
  flex: 4;
`;

const Container = styled.div`
  position: relative;
  width: 375px;
  height: 565px;
  padding-top: 27px;

  &::before {
    content: '';
    position: absolute;
    bottom: 0;
    width: 100%;
    height: 284px;
    background: linear-gradient(
      180deg,
      rgba(255, 255, 255, 0) 38.32%,
      rgba(255, 255, 255, 0.53) 50.05%,
      #fff 75.57%
    );
    z-index: 3;
    pointer-events: none;
  }
`;

const OptionTitle = styled.span`
  font-family: 'Title1_Medium';
  font-size: 24px;
`;

const Text = styled.span`
  font-family: Title3_Regular;
  font-size: 24px;
`;
