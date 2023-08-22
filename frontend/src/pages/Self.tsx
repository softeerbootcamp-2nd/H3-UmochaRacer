import React from 'react';
import styled from 'styled-components';
import Header from '../component/header/Header';
import Progress from '../component/progress/Progress';
import Content from '@/component/content/Content';

function Self() {
  return (
    <Wrapper>
      <TopWrapper>
        <Header />
        <Progress />
      </TopWrapper>
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

const TopWrapper = styled.div`
  width: 100%;
  min-height: 111px;
  position: fixed;
  background: white;
  z-index: 999999;
`;
