import React from 'react';
import styled from 'styled-components';
import {flexCenter} from '@/style/common';
import {colors} from '@/style/theme';
import {Title5_Regular} from '@/style/fonts';
import Header from '@/component/header/Header';

function Guide() {
  return (
    <Wrapper>
      <TopWrapper>
        <Header />
      </TopWrapper>
      <MiddleWrapper>
        <p>아직 가이드 모드는 다 안 만들었습니다. 억까금지 ㅜㅜ</p>
        <GuideModeButton.Wrapper
          onClick={() => {
            window.location.href = '/';
          }}
        >
          <GuideModeButton.LinkWrapper>
            <GuideModeButton.Guide>메인페이지로 가기</GuideModeButton.Guide>
          </GuideModeButton.LinkWrapper>
        </GuideModeButton.Wrapper>
      </MiddleWrapper>
    </Wrapper>
  );
}

export default Guide;
const Wrapper = styled.div`
  width: 100vw;
  height: 100vh;
  display: flex;
  flex-direction: column;
`;
const TopWrapper = styled.div`
  width: 100%;
  min-height: 111px;
  position: fixed;
  background: white;
  z-index: 999999;
`;
const MiddleWrapper = styled.div`
  width: 100%;
  height: 100%;
  padding-top: 111px;
  ${flexCenter}
  flex-direction: column;
`;
const GuideModeButton = {
  Wrapper: styled.div`
    ${flexCenter};
    gap: 80px;
    width: 533px;
    height: 90px;
    border-radius: 6px;
    background: ${colors.Main_Hyundai_Blue};
    margin: 69px auto 204px auto;
    cursor: pointer;
  `,
  Suggest: styled.p`
    color: ${colors.Cool_Grey};
    ${Title5_Regular}
  `,
  LinkWrapper: styled.div`
    ${flexCenter};
    gap: 8px;
  `,
  Guide: styled.p`
    color: ${colors.Hyundai_White};
    font-family: 'Hyundai Sans Text Medium';
    font-size: 32px;
    font-style: normal;
    font-weight: 500;
    line-height: normal;
    letter-spacing: -0.96px;
  `,
};
