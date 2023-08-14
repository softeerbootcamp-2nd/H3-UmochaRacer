import React, {useRef} from 'react';
import styled, {keyframes} from 'styled-components';
import {flexCenter} from '@/style/common';
import {Body1_Regular} from '@/style/fonts';
import {colors} from '@/style/theme';

interface Props {
  isActive: boolean;
  loadingText: string;
  doneText: string;
  onAnimationEnd: () => void;
}

const ActiveCircle = (onAnimationEnd?: () => void) => {
  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="22"
      height="22"
      viewBox="0 0 22 22"
      fill="none"
    >
      <circle cx="11" cy="11" r="11" fill={colors.Main_Hyundai_Blue} />
      <AnimationPath
        d="M6.5 10.8L9.63043 14L15.5 8"
        stroke="white"
        strokeWidth="2"
        strokeLinecap="round"
        strokeLinejoin="round"
        onAnimationEnd={onAnimationEnd}
      ></AnimationPath>
    </svg>
  );
};

const DefaultCircle = () => {
  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="22"
      height="22"
      viewBox="0 0 22 22"
      fill="none"
    >
      <circle cx="11" cy="11" r="11" fill="#6E809D" />
    </svg>
  );
};

const growAnimation = keyframes`
  0% {
    opacity: 0;
    clip-path: polygon(-20% 0%, 0% -20%, 0% 100%, 0% 125%);
  }
  100% {
    opacity: 1;
    clip-path: polygon(-20% 0, 120% -20%, 100% 100%, 0% 125%);
  }
`;

function ProgressIndicator({
  isActive,
  loadingText,
  doneText,
  onAnimationEnd,
}: Props) {
  const textRef = useRef<HTMLDivElement>(null);
  const animationEnd = () => {
    const textElem = textRef.current;
    if (textElem) {
      textElem.innerHTML = doneText;
    }

    onAnimationEnd();
  };
  return (
    <Wrapper>
      <CheckBox>
        {isActive ? ActiveCircle(animationEnd) : DefaultCircle()}
      </CheckBox>
      <Text ref={textRef} $isActive={isActive}>
        {loadingText}
      </Text>
    </Wrapper>
  );
}

export default ProgressIndicator;

const Wrapper = styled.div`
  display: flex;
  align-items: center;
  gap: 12px;
`;

const CheckBox = styled.div`
  ${flexCenter}
  width: 22px;
  height: 22px;
`;

const AnimationPath = styled.path`
  opacity: 0;
  animation: ${growAnimation} 1s forwards;
`;

const Text = styled.div<{$isActive: boolean}>`
  ${Body1_Regular}
  text-wrap: nowrap;
  color: ${({$isActive}) => ($isActive ? colors.Main_Hyundai_Blue : '#9D9FA3')};
`;
