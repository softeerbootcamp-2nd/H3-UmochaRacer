import React from 'react';
import Header from '../header/Header';
import styled from 'styled-components';
import main from '@/assets/images/main.png';
import {flexBetween, flexCenter} from '@/style/common';
import TrimCardList from './intro/trimCard/TrimCard';

import IntroTitle from './intro/IntroTitle';
import IntroShowMore from './intro/IntroShowMore';
import ModelTitleList from './modelTitle/ModelTitle';
import ModelInfoList from './modelInfo/ModelInfo';
import ModelOption from './modelOption/ModelOption';
import {colors} from '@/style/theme';
import {Body1_Medium, Title5_Regular} from '@/style/fonts';
import Icon from '../common/icons';
import {useScroll} from '../hooks/useScroll';
function MainContainer() {
  const scrollPosition = useScroll();

  return (
    <>
      <Intro.Wrapper>
        <Intro.Header className={scrollPosition < 1 ? '' : 'change_header'}>
          <Header />
        </Intro.Header>
        <Intro.Content>
          <IntroTitle />
          <TrimCardList />
          <IntroShowMore />
        </Intro.Content>
      </Intro.Wrapper>
      <Trim.Header>
        <Trim.IntroP>모델 한 눈에 비교하기</Trim.IntroP>
      </Trim.Header>
      <Trim.ModelWrapper>
        <ModelTitleList />
      </Trim.ModelWrapper>
      <Trim.InfoWrapper>
        <ModelInfoList />
      </Trim.InfoWrapper>
      <Trim.OptionWrapper>
        <ModelOption name="핵심 옵션" />
        <ModelOption name="외장 색상" />
        <ModelOption name="내장 색상" />
        <ModelOption name="기본 포함 품목" />
      </Trim.OptionWrapper>
      <Trim.CarMakeWrapper>
        <Trim.CarMake>
          <Trim.CarMakeP>내 차 만들기</Trim.CarMakeP>
        </Trim.CarMake>
        <Trim.CarMake>
          <Trim.CarMakeP>내 차 만들기</Trim.CarMakeP>
        </Trim.CarMake>
        <Trim.CarMake>
          <Trim.CarMakeP>내 차 만들기</Trim.CarMakeP>
        </Trim.CarMake>
        <Trim.CarMake>
          <Trim.CarMakeP>내 차 만들기</Trim.CarMakeP>
        </Trim.CarMake>
      </Trim.CarMakeWrapper>
      <GuideModeButton.Wrapper>
        <GuideModeButton.Suggest>
          무엇을 골라야 할 지 모르겠다면?
        </GuideModeButton.Suggest>
        <GuideModeButton.LinkWrapper>
          <GuideModeButton.Guide>Guide Mode</GuideModeButton.Guide>
          <Icon name="ArrowRight" size={36} />
        </GuideModeButton.LinkWrapper>
      </GuideModeButton.Wrapper>
    </>
  );
}

export default MainContainer;
const Intro = {
  Wrapper: styled.div`
    height: 100vh;
    ${flexCenter}
    background-image: url(${main});
    background-size: cover;
    background-position: center;
  `,
  Header: styled.div`
    position: fixed;
    top: 0;
    left: 0;
    z-index: 100;
    width: 100%;
    transition: 0.2s ease-in-out;
    &.change_header {
      background: #f2f4f7;
    }
  `,
  Content: styled.div`
    width: 1024px;
    height: 100%;
    padding-top: 85px;
    display: flex;
    flex-direction: column;
  `,
};

const Trim = {
  Header: styled.div`
    width: 100%;
    height: 200px;
    background: #f2f4f7;
    ${flexBetween}
    flex-direction : column;
  `,
  IntroP: styled.p`
    color: #202732;
    font-family: Hyundai Sans Head Medium;
    font-size: 40px;
    font-style: normal;
    font-weight: 500;
    line-height: 130%;
    letter-spacing: -1.6px;
    text-align: center;
    padding-top: 65px;
    height: 150px;
  `,
  ModelWrapper: styled.div`
    width: 100%;
    height: 100px;
    padding-bottom: 36px;
    ${flexCenter}
    background: #F2F4F7;
    position: sticky;
    top: 85px;
  `,
  InfoWrapper: styled.div`
    width: 100%;
    ${flexCenter}
    margin-top : 40px;
    margin-bottom: 56px;
  `,
  OptionWrapper: styled.div`
    width: 100%;
    ${flexCenter}
    flex-direction : column;
  `,
  CarMakeWrapper: styled.div`
    ${flexCenter};
    gap: 120px;
    margin-top: 44px;
  `,
  CarMake: styled.div`
    ${flexCenter};
    width: 140px;
    height: 50px;
    border-radius: 6px;
    background: ${colors.Main_Hyundai_Blue};
    cursor: pointer;
  `,
  CarMakeP: styled.p`
    color: ${colors.Hyundai_White};
    ${Body1_Medium}
  `,
};

const GuideModeButton = {
  Wrapper: styled.div`
    ${flexCenter};
    gap: 80px;
    width: 533px;
    height: 90px;
    border-radius: 6px;
    background: ${colors.Cool_Grey_001};
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
    color: ${colors.Cool_Grey};
    font-family: 'Hyundai Sans Text Medium';
    font-size: 32px;
    font-style: normal;
    font-weight: 500;
    line-height: normal;
    letter-spacing: -0.96px;
  `,
};
