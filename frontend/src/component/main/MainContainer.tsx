import React from 'react';
import Header from '../header/Header';
import styled from 'styled-components';
import {colors} from '@/style/theme';
import Icon from '../common/icons';
import {Title5_Regular} from '@/style/fonts';
import {flexCenter} from '@/style/common';
import TrimCard from './trimCard/TrimCard';
function MainContainer() {
  return (
    <>
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
            <Icon name={'more1'} size={26} />
            <ShowMore.Abs>
              <Icon name={'more2'} size={26} />
            </ShowMore.Abs>
          </ShowMore.IconWrapper>
        </ShowMore.Wrapper>
      </Main.Content>
    </>
  );
}

export default MainContainer;
const Main = {
  Header: styled.div`
    position: fixed;
    top: 0;
    left: 0;
    z-index: 100;
    width: 100%;
  `,
  Content: styled.div`
    width: 100%;
    height: 100%;
    padding: 85px 128px 0 128px;
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
    line-height: 88%;
  `,
};

const TrimCardWrapper = styled.div`
  margin-top: auto;
  margin-bottom: 40px;
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
