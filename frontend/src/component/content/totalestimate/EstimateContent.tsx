import React from 'react';
import styled from 'styled-components';
import Top from './estimatecontent/Top';
function EstimateContent() {
  return (
    <Wrapper>
      <Top></Top>
    </Wrapper>
  );
}

export default EstimateContent;

const Wrapper = styled.div`
  width: 100%;
  max-width: 1024px;
`;
