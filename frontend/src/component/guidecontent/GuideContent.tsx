import React, {useState} from 'react';
import styled from 'styled-components';
import SelectFlow from './SelectFlow';
import TotalEstimate from '../content/totalestimate/TotalEstimate';

function GuideContent() {
  const [complete, setComplete] = useState(false);

  return (
    <Wrapper>
      <Container>
        {complete ? (
          <TotalEstimate />
        ) : (
          <SelectFlow setComplete={setComplete} />
        )}
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
