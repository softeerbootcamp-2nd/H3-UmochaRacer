import React, {useState} from 'react';
import styled from 'styled-components';
import LoadingAnimation from '@/component/loding/LoadingAnimation';
import {flexCenter} from '@/style/common';

function TotalEstimate() {
  const [loaded, setLoaded] = useState(false);

  return (
    <Wrapper>
      {loaded ? (
        '얍'
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
