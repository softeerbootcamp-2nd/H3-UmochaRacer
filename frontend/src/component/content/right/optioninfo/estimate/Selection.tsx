import React from 'react';
import styled from 'styled-components';
import {colors} from '@/style/theme';
import {Title4_Medium, Title3_Medium, Body2_Regular} from '@/style/fonts';

function Selection() {
  return (
    <Wrapper>
      <Option>
        <OptionTitle>파워트레인</OptionTitle>
        <OptionName>디젤 2.2</OptionName>
      </Option>
      <OptionPrice>+ 1,480,000 원</OptionPrice>
    </Wrapper>
  );
}

export default Selection;

const Wrapper = styled.div`
  display: flex;
  justify-content: space-between;
  width: 100%;
  div {
    ${Body2_Regular}
  }
`;

const Option = styled.div`
  display: flex;
  width: 215px;
`;

const OptionTitle = styled.div`
  color: ${colors.Cool_Grey_003};
  flex: 16;
`;

const OptionName = styled.div`
  color: ${colors.Cool_Grey};
  flex: 27;
`;

const OptionPrice = styled.div`
  color: ${colors.Cool_Grey};
  float: right;
`;
