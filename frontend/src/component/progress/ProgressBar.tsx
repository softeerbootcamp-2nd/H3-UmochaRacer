import React from 'react';
import styled from 'styled-components';
import bar from '../../assets/icons/progressBar.svg';
function ProgressBar() {
  return (
    <Wrapper>
      <Progress src={bar}></Progress>
    </Wrapper>
  );
}

export default ProgressBar;

const Wrapper = styled.div``;
const Progress = styled.img`
  width: 100%;
  position: absolute;
  bottom: -16.5px;
  left: 0;
`;
