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
      <Detail.IconWrapper src={src} />
      <Detail.Name>{name}</Detail.Name>
    </Detail.Wrapper>
  );
}

export default ModelOptionDetail;
const Detail = {
  Wrapper: styled.div`
    ${flexBetween}
    gap : 16px;
    height: 60px;
  `,
  Name: styled.p`
    color: ${colors.Cool_Grey};
    ${Body2_Medium};
    white-space: pre-wrap;
    width: 100px;
  `,
  IconWrapper: styled.div<{src: string}>`
    width: 80px;
    height: 60px;
    border-radius: 6px;
    background-image: url(${(props) => props.src});
    background-position: center;
    background-size: cover;
  `,
  Icon: styled.img`
    border-radius: 6px;
    width: 80px;
    height: 60px;
  `,
};
