import {flexBetween} from '@/style/common';
import {Label2_Regular} from '@/style/fonts';
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
        <Detail.Icon src={`/image/main/${src}.png`} />
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
    color: ${colors.Cool_Grey_004};
    ${Label2_Regular};
    white-space: pre-wrap;
    width: 100px;
  `,
  IconWrapper: styled.div`
    text-align: center;
  `,
  Icon: styled.img`
    width: 60px;
    height: 60px;
  `,
};
