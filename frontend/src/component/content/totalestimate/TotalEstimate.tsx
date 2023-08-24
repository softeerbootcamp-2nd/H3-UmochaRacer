import React, {useState} from 'react';
import styled from 'styled-components';
import LoadingAnimation from '@/component/loding/LoadingAnimation';
import EstimateContent from './EstimateContent';
import {flexCenter} from '@/style/common';
import {useGuideFlowState} from '@/provider/guideFlowProvider';

function TotalEstimate() {
  const {showGuide} = useGuideFlowState();
  const [loaded, setLoaded] = useState(showGuide);

  return (
    <Wrapper>
      {loaded ? (
        <EstimateContent></EstimateContent>
      ) : (
        <LoadingAnimation setLoaded={setLoaded}></LoadingAnimation>
      )}
    </Wrapper>
  );
}

export default TotalEstimate;

const Wrapper = styled.div`
  ${flexCenter}
  width: 100%;
`;
