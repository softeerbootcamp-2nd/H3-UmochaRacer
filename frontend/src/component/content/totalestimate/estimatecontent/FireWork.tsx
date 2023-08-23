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
    }
    `;

  return resultAni;
};

const colors = ['#FF7676', '#FFB876', '#76ADFF'];

interface Props {
  width: number;
  height: number;
  number: number;
}
const directionArr: string[] = ['left', 'right'];

function Firework({number, width, height}: Props) {
  const firework: React.JSX.Element[] = directionArr.map(
    (direction: string, index: number) => {
      const explodes = Array.from({
        length: number,
      }).map((_, idx) => {
        let animation: Keyframes = keyframes``;
        if (height) {
          animation = explode(
            Math.random() * width + width,
            Math.random() * height + height * 0.1,
            Math.random() * 540,
            direction,
          );
        }

        return (
          <ExplosionDiv
            key={idx}
            $color={colors[idx % colors.length]}
            $animation={animation}
            $width={Math.random() * 30 + 10}
            $height={Math.random() + 10}
          ></ExplosionDiv>
        );
      });

      return <Container key={index}>{explodes}</Container>;
    },
  );

  return <Wrapper>{firework}</Wrapper>;
}

export default Firework;

const Wrapper = styled.div`
  width: 100%;
`;

const Container = styled.div`
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
