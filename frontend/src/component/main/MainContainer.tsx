import React from 'react';
import Header from '../header/Header';
import styled from 'styled-components';
import main from '@/assets/images/main.png';
import {flexCenter} from '@/style/common';
import TrimCardList from './intro/trimCard/TrimCard';

import IntroTitle from './intro/IntroTitle';
import IntroShowMore from './intro/IntroShowMore';
function MainContainer() {
  return (
    <>
      <Main.Intro>
        <Main.Header>
          <Header />
        </Main.Header>
        <Main.Content>
          <IntroTitle />
          <TrimCardList />
          <IntroShowMore />
        </Main.Content>
      </Main.Intro>
      asdfl;fsf
    </>
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
