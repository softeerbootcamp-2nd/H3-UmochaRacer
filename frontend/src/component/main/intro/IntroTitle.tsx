import {colors} from '@/style/theme';
import React from 'react';
import styled from 'styled-components';
function IntroTitle() {
  return (
    <Title.Wrapper>
      <Title.Title>내 차 만들기</Title.Title>
      <Title.SubTitle>PALISADE</Title.SubTitle>
    </Title.Wrapper>
  );
}
export default IntroTitle;
const Title = {
  Wrapper: styled.div`
    margin-top: 16px;
  `,
  Title: styled.p`
    color: ${colors.Hyundai_White};
    font-family: 'Hyundai Sans Head Regular';
    font-size: 24px;
    font-style: normal;
    font-weight: 400;
    letter-spacing: -0.96px;
  `,
  SubTitle: styled.p`
    color: ${colors.Hyundai_White};
    font-family: 'Hyundai Sans Head Medium';
    font-size: 64px;
    font-style: normal;
    font-weight: 500;
    line-height: 130%;
  `,
};
