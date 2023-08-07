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
      </Container>
    </Wrapper>
  );
}

export default OptionCardList;

const Wrapper = styled.div`
  width: 100%;
  height: 370px;
  margin-top: 32px;
`;

const Container = styled.ul`
  display: inline-flex;
  flex-direction: column;
  align-items: flex-start;
  width: 100%;
  height: 100%;
  gap: 16px;
  overflow-y: scroll;
`;
