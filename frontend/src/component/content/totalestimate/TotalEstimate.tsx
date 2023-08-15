import React, {useState} from 'react';
import styled from 'styled-components';
import LoadingAnimation from '@/component/loding/LoadingAnimation';
import EstimateContent from './EstimateContent';
import {flexCenter} from '@/style/common';

function TotalEstimate() {
  const [loaded, setLoaded] = useState(true);

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
