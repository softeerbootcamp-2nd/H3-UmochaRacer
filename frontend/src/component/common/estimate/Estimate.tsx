import React from 'react';
import styled from 'styled-components';
import {Title4_Medium} from '@/style/fonts';
import {colors} from '@/style/theme';
import {SelectionLayout} from '../estimateInterface';
import {Option} from '@/provider/selectedOptionProvider';
import Selection from './Selection';

interface HeaderProps {
  height: number;
  fontSize: number;
  title: string;
  price: number;
}

interface Props {
  header: HeaderProps;
  selectionLayout: SelectionLayout;
  sidePadding: number;
  options: Option[];
}

function Estimate({sidePadding, header, selectionLayout, options}: Props) {
  const selections: React.JSX.Element[] = options.map((elem, index) => {
    return (
      <Selection
        key={index}
        selectionLayout={selectionLayout}
        title={elem.key}
        name={elem.value || ''}
        price={elem.price}
      ></Selection>
    );
  });

  return (
    <Wrapper>
      <Wrapper>
        <Header
          $height={header.height}
          $padding={sidePadding}
          $fontSize={header.fontSize}
        >
          <OptionText>{header.title}</OptionText>
          <Price>{`+ ${header.price.toLocaleString()}`}원</Price>
        </Header>
        <SelectionList $gap={selectionLayout.gap}>{selections}</SelectionList>
      </Wrapper>
    </Wrapper>
  );
}

export default Estimate;

const Wrapper = styled.div`
  width: 100%;
  flex-shrink: 0;
`;

const Header = styled.div<{
  $height: number;
  $padding: number;
  $fontSize: number;
}>`
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  height: ${({$height}) => $height}px;
  padding: 0 ${({$padding}) => $padding}px;
  background: ${colors.Cool_Grey_001};
  div {
    ${Title4_Medium}
    font-size: ${({$fontSize}) => $fontSize}px;
  }
`;

const OptionText = styled.div`
  color: ${colors.Cool_Grey};
`;

const Price = styled.div`
  color: ${colors.Main_Hyundai_Blue};
`;

const SelectionList = styled.ul<{$gap: number}>`
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-top: 20px;
  padding: 0 20px;
  gap: ${({$gap}) => $gap}px;
  flex-shrink: 0;
  li {
    width: 100%;
  }
`;
