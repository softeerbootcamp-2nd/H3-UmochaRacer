import React from 'react';
import styled from 'styled-components';
interface IconProps {
  name: string;
  size: number;
}
function Icon({name, size}: IconProps) {
  return (
    <IconImg
      src={`../src/assets/icons/${name}.svg`}
      width={size}
      height={size}
    ></IconImg>
  );
}

export default Icon;
const IconImg = styled.img``;
