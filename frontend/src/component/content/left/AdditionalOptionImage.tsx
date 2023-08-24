import React, {useEffect, useRef} from 'react';
import styled, {css, keyframes} from 'styled-components';
import {flexCenter} from '../../../style/common';
import {cardDataType} from '../contentInterface';
import {useImageSrcState} from '@/provider/tempImageProvider';

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
    if (prevImgBox) {
      prevImgBox.style.display = '';
      prevImgBox.style.zIndex = '';
    }
  }

  if (imgBox instanceof HTMLElement) {
    imgBox.style.display = '';
    imgBox.style.zIndex = '10';
  }

  useEffect(() => {
    prevRef.current = selectedIndex;
  });

  const {imgSrc} = useImageSrcState();
  const imageList = imgSrc ? (
    <ImageBox>
      <ImageBoxImg src={imgSrc} />
    </ImageBox>
  ) : (
    cardData &&
    cardData.map((elem, index) => {
      return (
        <ImageBox
          key={index}
          style={{
            display:
              index === selectedIndex || index === prevRef.current
                ? ''
                : 'none',
          }}
        >
          <ImageBoxImg src={elem.imageSrc}></ImageBoxImg>
        </ImageBox>
      );
    })
  );

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

const ImageBox = styled.div`
  ${flexCenter}
  position: absolute;
  width: 100%;
  height: 100%;
  transition: clip-path 1s;
  background: #fff;
`;
const ImageBoxImg = styled.img`
  /* object-fit: cover; */
  width: 100%;
`;
