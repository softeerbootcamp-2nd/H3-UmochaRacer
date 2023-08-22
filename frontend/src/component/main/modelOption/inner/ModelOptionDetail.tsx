import {flexBetween} from '@/style/common';
import {Body2_Medium} from '@/style/fonts';
import {colors} from '@/style/theme';
import React from 'react';
import styled from 'styled-components';
interface detailProps {
  src: string;
  name: string;
}
function ModelOptionDetail({src, name}: detailProps) {
  return (
    <Detail.Wrapper>
      <Detail.IconWrapper>
        <Detail.Icon src={src} />
      </Detail.IconWrapper>
      <Detail.NameWrapper>
        <Detail.Name>{name}</Detail.Name>
        {/* <Detail.Description>{description}</Detail.Description> */}
      </Detail.NameWrapper>
    </Detail.Wrapper>
  );
}

export default ModelOptionDetail;
const Detail = {
  Wrapper: styled.div`
    ${flexBetween}
    gap: 12px;
  `,
  Name: styled.p`
    color: ${colors.Cool_Grey};
    ${Body2_Medium};
    white-space: pre-wrap;
  `,
  IconWrapper: styled.div`
    text-align: center;
  `,
  Icon: styled.img`
    width: 100px;
    height: 35px;
  `,
  NameWrapper: styled.div`
    display: flex;
    flex-direction: column;
  `,
  Description: styled.p`
    color: ${colors.Cool_Grey_003};
    font-family: 'Hyundai Sans Text Regular';
    font-size: 10px;
    font-style: normal;
    font-weight: 400;
    line-height: 130%;
    letter-spacing: -0.3px;
  `,
};
