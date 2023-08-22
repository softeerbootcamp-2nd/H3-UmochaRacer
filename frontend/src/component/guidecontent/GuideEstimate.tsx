import React, {useState} from 'react';
import styled from 'styled-components';
import EstimateContent from './guideestimate/EstimateContent';
import LoadingAnimation from '@/component/loding/LoadingAnimation';
import {flexCenter} from '@/style/common';

function GuideEstimate() {
  const [loaded, setLoaded] = useState(false);

  return (
    <Wrapper>
      {loaded ? (
        <EstimateContent />
      ) : (
        <LoadingAnimation setLoaded={setLoaded}></LoadingAnimation>
      )}
    </Wrapper>
  );
}

export default GuideEstimate;

const Wrapper = styled.div`
  ${flexCenter}
  width: 100%;
`;
