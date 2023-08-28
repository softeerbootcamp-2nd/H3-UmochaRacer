import React from 'react';
import styled from 'styled-components';
import {colors} from '@/style/theme';
import {Body2_Regular} from '@/style/fonts';
import {SelectionLayout} from '../estimateInterface';
import {textParse} from '../textParse';

interface SelectionProps {
  selectionLayout: SelectionLayout;
  title: string;
  name: string | '';
  price: number;
}

function Selection({selectionLayout, title, name, price}: SelectionProps) {
  return (
    <Wrapper $fontSize={selectionLayout.fontSize}>
      <Option $width={selectionLayout.flexWidth}>
        <OptionTitle>{title}</OptionTitle>
        <OptionName>{textParse(name)}</OptionName>
      </Option>
      <OptionPrice>{`+ ${price.toLocaleString()}`} 원</OptionPrice>
    </Wrapper>
  );
}

export default Selection;

const Wrapper = styled.div<{$fontSize: number}>`
  display: flex;
  justify-content: space-between;
  width: 100%;
  div {
    ${Body2_Regular}
    font-size: ${({$fontSize}) => $fontSize}px;
  }
`;

const Option = styled.div<{$width: number}>`
  display: flex;
  width: ${({$width}) => $width}px;
`;

const OptionTitle = styled.div`
  color: ${colors.Cool_Grey_003};
  flex: 1;
`;

const OptionName = styled.div`
  color: ${colors.Cool_Grey};
  flex: 2;
`;

const OptionPrice = styled.div`
  color: ${colors.Cool_Grey};
  float: right;
`;
