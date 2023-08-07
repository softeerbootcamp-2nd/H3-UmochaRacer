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
  width: 375px;
  height: 565px;
`;

const OptionTitle = styled.span`
  font-family: 'Title1_Medium';
  font-size: 24px;
`;

const Text = styled.span`
  font-family: Title3_Regular;
  font-size: 24px;
`;
