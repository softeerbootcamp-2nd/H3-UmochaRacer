import React from 'react';
import styled from 'styled-components';
import {colors} from '../../../style/theme';
import OptionCard from './card/OptionCard';

function OptionCardList() {
  return (
    <Wrapper>
      <Container>
        <OptionCard></OptionCard>
        <OptionCard></OptionCard>
        <OptionCard></OptionCard>
      </Container>
    </Wrapper>
  );
}

export default OptionCardList;

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
  width: 100%;
  height: 485px;
  gap: 16px;
`;
