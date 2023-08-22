import Icon from '@/component/common/icons';
import {flexCenter} from '@/style/common';
import {Title5_Regular} from '@/style/fonts';
import {colors} from '@/style/theme';
import React from 'react';
import styled from 'styled-components';
function IntroShowMore() {
  return (
    <ShowMore.Wrapper>
      <ShowMore.Text>자세한 설명과 비교를 원한다면</ShowMore.Text>
      <ShowMore.IconWrapper>
        <Icon name="More1" size={26} />
        <ShowMore.Abs>
          <Icon name="More2" size={26} />
        </ShowMore.Abs>
      </ShowMore.IconWrapper>
    </ShowMore.Wrapper>
  );
}
export default IntroShowMore;

const ShowMore = {
  Wrapper: styled.div`
    ${flexCenter}
    flex-direction: column;
    gap: 4px;
    margin-bottom: 32px;
  `,
  Text: styled.p`
    opacity: 0.6;
    color: ${colors.Hyundai_White};
    ${Title5_Regular}
  `,
  IconWrapper: styled.div`
    ${flexCenter}
    flex-direction: column;
    position: relative;
  `,
  Abs: styled.div`
    position: absolute;
    top: 10px;
  `,
};
