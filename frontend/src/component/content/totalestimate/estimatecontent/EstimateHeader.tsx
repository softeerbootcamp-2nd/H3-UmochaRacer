import React from 'react';
import styled from 'styled-components';
import {Title1_Medium, Title4_Regular} from '@/style/fonts';

interface Props {
  text: string;
  price: number;
  padding?: number;
  onClick?: () => void;
}

function EstimateHeader({text, price, padding, onClick}: Props) {
  return (
    <Wrapper $padding={padding} onClick={onClick}>
      <Left>{text}</Left>
      <Right>
        <Text>차량 총 견적 금액</Text>
        <Price>{price.toLocaleString()} 원</Price>
      </Right>
    </Wrapper>
  );
}

export default EstimateHeader;

const Wrapper = styled.div<{$padding?: number}>`
  display: flex;
  justify-content: space-between;
  width: 100%;
  height: 44px;
  margin: 52px 0 14px 0;
  padding-left: ${({$padding}) => $padding && $padding}px;
`;

const Right = styled.div`
  display: flex;
  gap: 14px;
`;

const Left = styled.div`
  ${Title4_Regular}
  align-self: center;
`;

const Text = styled.div`
  ${Title4_Regular}
  align-self: center;
`;

const Price = styled.div`
  ${Title1_Medium}
  font-size: 34px;
`;
