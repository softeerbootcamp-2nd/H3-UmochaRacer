import React from 'react';
import styled from 'styled-components';
import bar from '@/assets/icons/progressBar.svg';
function ProgressBar() {
  return (
    <Wrapper>
      <Progress src={bar}></Progress>
    </Wrapper>
  );
}

export default ProgressBar;

const Wrapper = styled.div`
  font-size: 0;
  width: 100%;
`;
const Progress = styled.img`
  width: 100%;
`;
