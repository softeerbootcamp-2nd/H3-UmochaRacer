import React from 'react';
import styled from 'styled-components';
import Header from '../component/header/Header';
import Progress from '../component/progress/Progress';
import LoadingAnimation from '@/component/loding/LoadingAnimation';

function Loading() {
  return (
    <Wrapper>
      <Header />
      <Progress />
      <LoadingAnimation />
    </Wrapper>
  );
}

export default Loading;

const Wrapper = styled.div`
  width: 100vw;
  height: 100vh;
  display: flex;
  flex-direction: column;
`;
