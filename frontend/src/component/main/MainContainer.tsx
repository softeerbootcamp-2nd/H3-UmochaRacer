import React, {useEffect, useState} from 'react';
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
function MainContainer() {
  const [scrollPosition, setScrollPosition] = useState(0);
  const updateScroll = () => {
    setScrollPosition(window.scrollY || document.documentElement.scrollTop);
  };
  useEffect(() => {
    window.addEventListener('scroll', updateScroll);
  }, []);

  useEffect(() => {
    window.scrollTo(0, 0);
  }, []);
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
      </Trim.OptionWrapper>
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
      background: #e7e7e7;
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
    background: #e7e7e7;
    ${flexBetween}
    flex-direction : column;
  `,
  IntroP: styled.p`
    color: #212121;
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
    background: #e7e7e7;
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
};
