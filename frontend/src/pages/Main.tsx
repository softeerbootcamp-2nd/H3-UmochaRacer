import React from 'react';
import styled from 'styled-components';
import {flexCenter} from '@/style/common';
import main from '@/assets/images/main.png';
import MainContainer from '@/component/main/MainContainer';
function Main() {
  return (
    <Container>
      <MainContainer />
    </Container>
  );
}

export default Main;
const Container = styled.div`
  height: 100vh;
  ${flexCenter}
  width: 100vw;
  background-image: url(${main});
  background-size: cover;
  background-position: center;
`;
