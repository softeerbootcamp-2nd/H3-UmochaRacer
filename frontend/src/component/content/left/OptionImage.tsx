import React, {useRef} from 'react';
import styled from 'styled-components';
import {flexCenter} from '../../../style/common';

interface ImageProps {
  url: string;
}

function OptionImage({url}: ImageProps) {
  const wrapperRef = useRef<HTMLDivElement>(null);
  return (
    <Wrapper ref={wrapperRef} currHeight={wrapperRef.current?.clientHeight}>
      <img src={url}></img>
    </Wrapper>
  );
}

export default OptionImage;

const Wrapper = styled.div<{currHeight: any}>`
  ${flexCenter}
  overflow: hidden;
  flex: 6;
  height: 100%;
  img {
    height: auto;
    max-height: ${(props) => props.currHeight}px;
  }
`;
