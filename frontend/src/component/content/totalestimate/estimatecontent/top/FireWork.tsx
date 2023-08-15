import React from 'react';
import styled, {keyframes} from 'styled-components';
import Keyframes from 'styled-components/dist/models/Keyframes';

const explode = (
  positionX: number,
  positionY: number,
  rotate: number,
  direction: string,
) => {
  const resultAni =
    direction === 'left'
      ? keyframes`
  100% {
      transform: translate(-${positionX}px, -${positionY}px) 
      rotate(${rotate}deg);
  }
  `
      : keyframes`
  100% {
      transform: translate(${positionX}px, -${positionY}px)
      rotate(${rotate}deg);
      ;
  }
  `;

  return resultAni;
};

const colors = ['#FF7676', '#FFB876', '#76ADFF'];

interface Props {
  direction: 'left' | 'right';
  number: number;
}

function Fireworks({direction, number}: Props) {
  const firework: React.JSX.Element[] = Array.from({length: number}).map(
    (_, index) => {
      const animation = explode(
        Math.random() * 256 + 256,
        Math.random() * 150 + 250,
        Math.random() * 180,
        direction,
      );

      return (
        <ExplosionDiv
          key={index}
          $color={colors[index % colors.length]}
          $animation={animation}
          $width={Math.random() * (40 - 10) + 10}
          $height={Math.random() + 10}
        ></ExplosionDiv>
      );
    },
  );

  return <Wrapper>{firework}</Wrapper>;
}

export default Fireworks;

const Wrapper = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100%;
`;

const ExplosionDiv = styled.div<{
  $width: number;
  $height: number;
  $color: string;
  $animation: Keyframes;
}>`
  position: absolute;
  width: ${({$width}) => $width}px;
  height: ${({$height}) => $height}px;
  background-color: ${({$color}) => $color};
  animation: ${({$animation}) => $animation} 1s ease-out forwards;
`;
