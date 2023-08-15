import React from 'react';
import styled from 'styled-components';
import Top from './estimatecontent/Top';
import Middle from './estimatecontent/Middle';

function EstimateContent() {
  return (
    <Wrapper>
      <Top></Top>
      <Middle></Middle>
    </Wrapper>
  );
}

export default EstimateContent;

const Wrapper = styled.div`
  width: 100%;
  max-width: 1024px;
`;
