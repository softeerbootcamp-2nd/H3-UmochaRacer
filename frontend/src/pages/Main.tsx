import React from 'react';
import styled from 'styled-components';
import {Link} from 'react-router-dom';
import {flexCenter} from '@/style/common';
import main from '@/assets/images/main.png';
function Main() {
  return (
    <Container>
      <Link to="/self">
        <CarCard>
          <CarTag>#베스트셀러</CarTag>
          <CarName>Le Blanc</CarName>
          <CarPrice>38,960,000 원 부터</CarPrice>
        </CarCard>
      </Link>
    </Container>
  );
}

export default Main;
const Container = styled.div`
  height: 100vh;
  ${flexCenter}
  background-image: url(${main});
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
`;

const CarCard = styled.div`
  padding: 20px;
  width: 192px;
  height: 123px;
  border-radius: 6px;
  background: var(--hyundai-white, #fff);
  flex-shrink: 0;
  backdrop-filter: blur(12px);
  display: flex;
  align-items: baseline;
  justify-content: center;
  flex-direction: column;
`;
const CarTag = styled.p`
  color: var(--unnamed, #202732);
  font-family: Hyundai Sans Text KR;
  font-size: 12px;
  font-style: normal;
  font-weight: 400;
  line-height: 130%;
  letter-spacing: -0.36px;
  margin-bottom: 8px;
`;

const CarName = styled.p`
  color: var(--unnamed, #202732);
  font-family: Hyundai Sans Head KR;
  font-size: 20px;
  font-style: normal;
  font-weight: 500;
  line-height: 130%;
  margin-bottom: 17px;
  letter-spacing: -0.6px;
`;

const CarPrice = styled.p`
  opacity: 0.8;
  color: var(--unnamed, #202732);
  font-family: Hyundai Sans Text KR;
  font-size: 12px;
  font-style: normal;
  font-weight: 400;
  line-height: 130%;
  letter-spacing: -0.36px;
`;
