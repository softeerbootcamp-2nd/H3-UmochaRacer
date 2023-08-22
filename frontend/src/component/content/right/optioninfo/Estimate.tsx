import React from 'react';
import styled from 'styled-components';
import {colors} from '@/style/theme';
import {Title4_Medium, Title3_Medium, Body2_Regular} from '@/style/fonts';

import Selection from './estimate/Selection';

function Estimate() {
  return (
    <Wrapper>
      <Header>
        <OptionText>팰리세이드 Le Blanc (르블랑)</OptionText>
        <Price>+ 43,460,000원</Price>
      </Header>
      <SelectionList>
        <Selection></Selection>
        <Selection></Selection>
        <Selection></Selection>
      </SelectionList>
    </Wrapper>
  );
}

export default Estimate;

const Wrapper = styled.div`
  width: 100%;
  flex-shrink: 0;
`;

const OptionText = styled.div`
  color: ${colors.Cool_Grey};
`;

const Price = styled.div`
  color: ${colors.Main_Hyundai_Blue};
`;

const SelectionList = styled.ul`
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-top: 20px;
  padding: 0 20px;
  gap: 12px;
  flex-shrink: 0;
  li {
    width: 100%;
  }
`;

const Header = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  height: 38px;
  padding: 0 20px;
  background: ${colors.Cool_Grey_001};
  div {
    ${Title4_Medium}
  }
`;
