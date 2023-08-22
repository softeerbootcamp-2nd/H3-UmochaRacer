import React from 'react';
import styled from 'styled-components';
import EstimateHeader from './EstimateHeader';
import EstimateList from '@/component/common/EstimateList';

interface Props {
  totalPrice: number;
}
function Middle({totalPrice}: Props) {
  const headerLayout = {
    height: 57,
    fontSize: 22,
  };

  const selectionLayout = {
    flexWidth: 384,
    gap: 32,
    fontSize: 16,
  };

  return (
    <Wrapper>
      <EstimateHeader
        text={'견적 요약'}
        price={totalPrice}
        padding={24}
      ></EstimateHeader>
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
