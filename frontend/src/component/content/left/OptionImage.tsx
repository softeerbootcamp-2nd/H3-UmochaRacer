import React, {useEffect, useRef} from 'react';
import styled, {css, keyframes} from 'styled-components';
import {flexCenter} from '../../../style/common';
import {cardDataType} from '../contentInterface';

interface ImageProps {
  cardData: cardDataType[];
  selectedIndex: number;
}

const growAnimation = keyframes`
  0% {
    clip-path: polygon(0% 0%, 0% 0%, 0% 100%, 0% 100%);
  }
  100% {
    clip-path: polygon(0% 0%, 100% 0%, 100% 100%, 0% 100%);
  }
`;

function OptionImage({cardData, selectedIndex}: ImageProps) {
  const wrapperRef = useRef<HTMLDivElement>(null);
  const prevRef = useRef<number | undefined>(undefined);
  const imgBox = wrapperRef.current?.childNodes[selectedIndex];

  if (prevRef.current !== undefined) {
    const prevImgBox = wrapperRef.current?.childNodes[
      prevRef.current
    ] as HTMLElement;
    prevImgBox.style.display = '';
    prevImgBox.style.zIndex = '';
  }

  if (imgBox instanceof HTMLElement) {
    imgBox.style.display = '';
    imgBox.style.zIndex = '10';
  }

  useEffect(() => {
    prevRef.current = selectedIndex;
  });

  const imageList = cardData.map((elem, index) => {
    return (
      <ImageBox
        key={index}
        $isActive={index === selectedIndex}
        style={{
          display:
            index === selectedIndex || index === prevRef.current ? '' : 'none',
        }}
        onAnimationEnd={() => {
          if (prevRef.current !== undefined && wrapperRef.current) {
            const prevImgBox = wrapperRef.current.childNodes[prevRef.current];
            const currImgBox = wrapperRef.current.childNodes[selectedIndex];
            if (
              prevImgBox instanceof HTMLElement &&
              currImgBox instanceof HTMLElement
            ) {
              if (prevRef.current !== selectedIndex) {
                prevImgBox.style.display = 'none';
                currImgBox.style.zIndex = '';
              }
            }
            prevRef.current = selectedIndex;
          }
        }}
      >
        <ImageBoxImg src={elem.imageSrc}></ImageBoxImg>
      </ImageBox>
    );
  });

  return (
    <Wrapper $currheight={wrapperRef.current?.clientHeight}>
      <Container ref={wrapperRef}>{imageList}</Container>
    </Wrapper>
  );
}

export default OptionImage;

const Wrapper = styled.div<{$currheight?: number}>`
  flex: 6;
`;

const Container = styled.div`
  position: relative;
  width: 100%;
  height: 100%;
  overflow: hidden;
`;

const ImageBox = styled.div<{$isActive: boolean}>`
  ${flexCenter}
  position: absolute;
  width: 100%;
  height: 100%;
  transition: clip-path 1s;
  background: #fff;
  ${({$isActive}) =>
    $isActive &&
    css`
      animation: ${growAnimation} 0.5s both cubic-bezier(1, 0, 0.5, 1);
      animation-delay: 0.2s;
    `}
`;
const ImageBoxImg = styled.img`
  /* object-fit: cover; */
  width: 100%;
`;
