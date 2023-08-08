import {Title4_Regular} from '@/style/fonts';
import React from 'react';
import styled from 'styled-components';
import TrimDescriptionDetail from './trimDescriptionDetail/TrimDescriptionDetail';
type TrimDescriptionData = {
  title: string;
  hasDescription: boolean;
  descriptionData: Array<{
    main: string;
    sub: string;
  }>;
};

interface TrimDescriptionProps {
  trimDescription: TrimDescriptionData;
  name: string;
}
function TrimDescription({trimDescription, name}: TrimDescriptionProps) {
  return (
    <Description.Wrapper>
      <TrimDescriptionBorder>
        <TitleContainer>
          <TrimSubTitle>{trimDescription.title}</TrimSubTitle>
          <TrimTitle>{name}</TrimTitle>
        </TitleContainer>
        {trimDescription && (
          <TrimDescriptionDetail descriptionDetail={trimDescription} />
        )}
      </TrimDescriptionBorder>
    </Description.Wrapper>
  );
}

export default TrimDescription;

const Description = {
  Wrapper: styled.div`
    width: 609px;
    height: 237px;
    border-radius: 6px;
    background: linear-gradient(
      90deg,
      rgba(255, 255, 255, 0.2) 0%,
      rgba(255, 255, 255, 0) 100%
    );
    backdrop-filter: blur(6px);
    -webkit-backdrop-filter: blur(6px);

    color: white;
    z-index: 1;
  `,
};
export const TrimDescriptionBorder = styled.div`
  display: flex;
  gap: 50px;
  width: 100%;
  height: 100%;
  padding: 37px 26px 37px 33px;
  border-radius: 6px;
  box-shadow: 0px 10px 16px 0px rgba(0, 0, 0, 0.2);

  &::before {
    content: '';
    position: absolute;
    inset: 0;
    border-radius: 6px;
    padding: 2px;
    background: linear-gradient(
      320deg,
      rgba(255, 255, 255, 0.7) 0%,
      rgba(224, 224, 224, 0) 35%,
      rgba(0, 212, 255, 0) 65%,
      rgba(225, 225, 225, 0.7) 100%
    );
    -webkit-mask:
      linear-gradient(#fff 0 0) content-box,
      linear-gradient(#fff 0 0);
    mask:
      linear-gradient(#fff 0 0) content-box,
      linear-gradient(#fff 0 0);
    -webkit-mask-composite: xor;
    mask-composite: exclude;
  }
`;

export const TitleContainer = styled.div`
  display: flex;
  flex-direction: column;
  gap: 6px;
  margin: auto 0;
`;

export const TrimSubTitle = styled.div`
  ${Title4_Regular}
  text-shadow: 0px 2px 12px rgba(44, 44, 44, 0.3);
`;

export const TrimTitle = styled.div`
  font-family: 'Hyundai Sans Head Medium';
  font-size: 32px;
  font-weight: 500;
  line-height: 34px;
  letter-spacing: -0.96px;
  text-shadow: 0px 2px 12px rgba(44, 44, 44, 0.3);
`;
