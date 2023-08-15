import {flexBetween} from '@/style/common';
import {Body2_Medium} from '@/style/fonts';
import {colors} from '@/style/theme';
import React from 'react';
import styled from 'styled-components';
interface detailProps {
  border: boolean;
  src: string;
  name: string;
}
function ModelOptionDetail({border, src, name}: detailProps) {
  return (
    <Detail.Wrapper>
      <Detail.IconWrapper>
        <Detail.Icon $border={border} src={src}></Detail.Icon>
      </Detail.IconWrapper>
      <Detail.Name>{name}</Detail.Name>
    </Detail.Wrapper>
  );
}

export default ModelOptionDetail;
const Detail = {
  Wrapper: styled.div`
    ${flexBetween}
    gap : 24px;
  `,
  Name: styled.p`
    color: ${colors.Cool_Grey};
    ${Body2_Medium};
    white-space: pre-wrap;
    width: 135px;
  `,
  IconWrapper: styled.div`
    text-align: center;
  `,
  Icon: styled.img<{$border: boolean}>`
    border-radius: 50%;
    width: 20px;
    height: 20px;

    ${({$border}) => $border && `border: 1px solid ${colors.Cool_Grey_002};`}
  `,
};
