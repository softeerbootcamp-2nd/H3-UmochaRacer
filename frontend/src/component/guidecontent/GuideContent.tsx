import React from 'react';
import styled from 'styled-components';
import SelectFlow from './SelectFlow';

function GuideContent() {
  return (
    <Wrapper>
      <Container>
        <SelectFlow />
      </Container>
    </Wrapper>
  );
}

export default GuideContent;

const Wrapper = styled.div`
  width: 100%;
  flex-grow: 1;
  padding-top: 111px;
`;

const Container = styled.div`
  display: flex;
  width: 100%;
  max-width: 1024px;
  height: 100%;
  margin: auto;
`;
