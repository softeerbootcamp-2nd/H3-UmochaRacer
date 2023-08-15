import React from 'react';
import styled from 'styled-components';
import EstimateList from '@/component/common/EstimateList';
import {Title1_Medium, Title3_Medium, Title4_Regular} from '@/style/fonts';

function Middle() {
  const headerLayout = {
    height: 57,
    fontSize: 22,
  };

  const selectionLayout = {
    flexWidth: 384,
    gap: 32,
    fontSize: 16,
  };

  const price = 47270000;
  return (
    <Wrapper>
      <Header>
        <Right>견적 요약</Right>
        <Left>
          <Text>차량 총 견적 금액</Text>
          <Price>{price.toLocaleString()} 원</Price>
        </Left>
      </Header>
      <EstimateList
        gap={36}
        sidePadding={24}
        headerLayout={headerLayout}
        selectionLayout={selectionLayout}
      ></EstimateList>
    </Wrapper>
  );
}

export default Middle;

const Wrapper = styled.div`
  width: 100%;
`;

const Header = styled.div`
  display: flex;
  justify-content: space-between;
  width: 100%;
  height: 44px;
  margin: 52px 0 14px 0;
  padding: 0 24px;
`;

const Right = styled.div`
  ${Title3_Medium}
  align-self: center;
`;

const Left = styled.div`
  display: flex;
  gap: 14px;
`;

const Text = styled.div`
  ${Title4_Regular}
  align-self: center;
`;

const Price = styled.div`
  ${Title1_Medium}
  font-size: 34px;
`;
