import React from 'react';
import styled from 'styled-components';
import {colors} from '@/style/theme';

interface props {
  onClick: (event: React.MouseEvent) => void;
  isOpen: boolean;
}

const DetailIcon = (isOpen: boolean) => {
  const transform: string = isOpen ? 'rotate(180deg)' : 'rotate(0deg)';
  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="14"
      height="14"
      viewBox="0 0 14 14"
      fill="none"
      style={{transform}}
    >
      <path
        d="M7.77818 7.84802L12.0129 3.88813L13.2226 5.0193L7.77818 10.1104L2.33374 5.0193L3.54343 3.88813L7.77818 7.84802Z"
        fill="#AEB1B7"
      />
    </svg>
  );
};

function DetailToggle({onClick, isOpen}: props) {
  const buttonText: string = isOpen ? '접기' : '자세히보기';

  return (
    <Wrapper onClick={onClick}>
      {buttonText}
      {DetailIcon(isOpen)}
    </Wrapper>
  );
}

export default DetailToggle;

const Wrapper = styled.button`
  display: inline-flex;
  align-items: center;
  height: 16px;
  font-size: 12px;
  font-style: normal;
  font-weight: 500;
  line-height: 130%; /* 15.6px */
  letter-spacing: -0.36px;
  color: ${colors.Cool_Grey_003};
  gap: 2px;
`;
