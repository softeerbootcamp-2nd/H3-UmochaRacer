import React from 'react';
import styled from 'styled-components';
import Header from '../component/header/Header';
import Progress from '../component/progress/Progress';
import Content from '../component/Content';

function Self() {
  return (
    <Wrapper>
      <Header />
      <Progress />
      <Content />
    </Wrapper>
  );
}

export default Self;
const Wrapper = styled.div`
  width: 100vw;
  height: 100vh;
  display: flex;
  flex-direction: column;
`;
