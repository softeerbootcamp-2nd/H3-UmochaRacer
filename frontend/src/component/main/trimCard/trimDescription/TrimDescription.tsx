import React from 'react';
import styled from 'styled-components';
type TrimDescriptionData = {
  title: string;
  hasDescription: boolean;
  descriptionData: Array<{
    main: string;
    sub: string;
  }>;
} | null;

export interface TrimDescriptionProps {
  trimDescription: TrimDescriptionData;
}
function TrimDescription({trimDescription}: TrimDescriptionProps) {
  return <Description.Wrapper></Description.Wrapper>;
}

export default TrimDescription;

const Description = {
  Wrapper: styled.div`
    position: absolute;
    top: -253px;
    left: 0;
    padding: 37px 26px 37px 33px;
    border-radius: 6px;
    width: 609px;
    height: 237px;
    background: linear-gradient(
      90deg,
      rgba(255, 255, 255, 0.2) 0%,
      rgba(255, 255, 255, 0) 100%
    );
    justify-content: flex-end;
    align-items: center;
    gap: 50px;
    backdrop-filter: blur(6px);
  `,
};
