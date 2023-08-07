import {colors} from '@/style/theme';
import React from 'react';
import {styled} from 'styled-components';
function TrimCard() {
  return <Card.Wrapper></Card.Wrapper>;
}

export default TrimCard;
const Card = {
  Wrapper: styled.div`
    width: 192px;
    height: 123px;
    border-radius: 6px;
    background: ${colors.Hyundai_White};
    flex-shrink: 0;
    backdrop-filter: blur(12px);
    padding: 20px;
  `,
};
