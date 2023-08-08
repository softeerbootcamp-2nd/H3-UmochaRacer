import React from 'react';
import styled from 'styled-components';
import {flexCenter} from '../../../style/common';

interface ImageProps {
  url: string;
}

function OptionImage({url}: ImageProps) {
  return (
    <Wrapper>
      <img src={url}></img>
    </Wrapper>
  );
}

export default OptionImage;

const Wrapper = styled.div`
  ${flexCenter}
  flex: 6;
`;
