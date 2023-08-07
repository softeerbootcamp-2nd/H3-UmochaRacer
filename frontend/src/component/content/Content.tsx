import React from 'react';
import styled from 'styled-components';
import OptionImage from './left/OptionImage';
import OptionInfo from './right/OptionInfo';

function Content() {
  return (
    <Wrapper>
      <Container>
        <OptionImage />
        <OptionInfo />
      </Container>
    </Wrapper>
  );
}

export default Content;

const Wrapper = styled.section`
  width: 100%;
  flex-grow: 1;
`;

const Container = styled.div`
  display: flex;
  width: 100%;
  height: 100%;
`;
