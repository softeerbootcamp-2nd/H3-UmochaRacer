import React from 'react';
import Header from '../header/Header';
import styled from 'styled-components';
import {colors} from '@/style/theme';
import Icon from '../common/icons';
import main from '@/assets/images/main.png';
import {Title5_Regular} from '@/style/fonts';
import {flexCenter} from '@/style/common';
import TrimCard from './trimCard/TrimCard';
function MainContainer() {
  return (
    <Main.Intro>
      <Main.Header>
        <Header />
      </Main.Header>
      <Main.Content>
        <Title.Wrapper>
          <Title.Title>내 차 만들기</Title.Title>
          <Title.SubTitle>PALISADE</Title.SubTitle>
        </Title.Wrapper>
        <TrimCardWrapper>
          <TrimCard />
        </TrimCardWrapper>
        <ShowMore.Wrapper>
          <ShowMore.Text>자세한 설명과 비교를 원한다면</ShowMore.Text>
          <ShowMore.IconWrapper>
            <Icon name="More1" size={26} />
            <ShowMore.Abs>
              <Icon name="More2" size={26} />
            </ShowMore.Abs>
          </ShowMore.IconWrapper>
        </ShowMore.Wrapper>
      </Main.Content>
    </Main.Intro>
  );
}

export default MainContainer;
const Main = {
  Intro: styled.div`
    height: 100vh;
    ${flexCenter}
    width: 100vw;
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
  `,
  Content: styled.div`
    width: 1024px;
    height: 100%;
    padding-top: 85px;
    display: flex;
    flex-direction: column;
  `,
};

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

const TrimCardWrapper = styled.div`
  margin-top: auto;
  margin-bottom: 40px;
  display: flex;
  gap: 16px;
`;

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
