import React from 'react';
import styled from 'styled-components';
import Header from '@/component/header/Header';
import GuideContent from '@/component/guidecontent/GuideContent';
import Content from '@/component/content/Content';
import Progress from '@/component/progress/Progress';
import {useGuideFlowState} from '@/provider/guideFlowProvider';

function Guide() {
  const {showGuide} = useGuideFlowState();
  return (
    <Wrapper>
      <TopWrapper>
        <Header />
        {showGuide && <Progress />}
      </TopWrapper>
      {showGuide ? <Content /> : <GuideContent />}
    </Wrapper>
  );
}

export default Guide;

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
