import React from 'react';
import styled from 'styled-components';
import EstimateHeader from './EstimateHeader';
import EstimateList from '@/component/common/EstimateList';

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
      <EstimateHeader text={'견적 요약'} price={price}></EstimateHeader>
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
