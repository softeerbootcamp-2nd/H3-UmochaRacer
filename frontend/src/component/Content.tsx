import React from 'react';
import styled from 'styled-components';
import SelectedOptionImage from './Content/SelectedOptionImage';
import SelectedOptionInfo from './Content/SelectedOptionInfo';

function Content() {
  return (
    <Wrapper>
      <Container>
        <SelectedOptionImage />
        <SelectedOptionInfo />
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
