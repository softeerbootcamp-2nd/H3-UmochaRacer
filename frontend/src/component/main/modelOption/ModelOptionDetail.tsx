import Icon, {IconType} from '@/component/common/icons';
import {flexBetween} from '@/style/common';
import {Label2_Regular} from '@/style/fonts';
import {colors} from '@/style/theme';
import React from 'react';
import styled from 'styled-components';
interface detailProps {
  icon: IconType;
  name: string;
}
function ModelOptionDetail({icon, name}: detailProps) {
  return (
    <Detail.Wrapper>
      <Detail.IconWrapper>
        <Icon name={icon} />
      </Detail.IconWrapper>
      <Detail.Name>{name}</Detail.Name>
    </Detail.Wrapper>
  );
}

export default ModelOptionDetail;
const Detail = {
  Wrapper: styled.div`
    width: 90%;
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
    width: 100px;
    text-align: center;
  `,
};
