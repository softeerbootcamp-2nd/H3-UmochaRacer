import React from 'react';
import styled from 'styled-components';
import {HeaderLayout, SelectionLayout} from './estimateInterface';
import Estimate from './estimate/Estimate';

interface Option {
  title: string;
  name: string;
  price: number;
}

interface Props {
  gap: number;
  sidePadding: number;
  headerLayout: HeaderLayout;
  selectionLayout: SelectionLayout;
}

const headerTitles: string[] = ['팰리세이드 Le Blanc (르블랑)', '색상', '옵션'];
const prices: number[] = [43460000, 100000, 2570000];

const first: Option[] = [
  {title: '파워트레인', name: '디젤 2.2', price: 1480000},
  {title: '구동 방식', name: '2WD', price: 0},
  {title: '바디 타입', name: '7인승', price: 0},
];

const second: Option[] = [
  {title: '외장 색상', name: '크리미 화이트 펄', price: 0},
  {title: '내장 색상', name: '2WD', price: 0},
];

const third: Option[] = [
  {title: '선택옵션', name: '컴포트 2', price: 1090000},
  {title: '', name: '현대스마트센스 1', price: 790000},
  {title: '', name: '주차보조 시스템 2', price: 690000},
  {title: '', name: '프로텍션 매트 패키지 1', price: 250000},
];

const options = [first, second, third];

function EstimateList({
  gap,
  sidePadding,
  headerLayout,
  selectionLayout,
}: Props) {
  const estimates: React.JSX.Element[] = headerTitles.map((elem, index) => {
    const haederProps = {
      height: headerLayout.height,
      fontSize: headerLayout.fontSize,
      title: elem,
      price: prices[index],
    };

    return (
      <Estimate
        key={index}
        sidePadding={sidePadding}
        header={haederProps}
        selectionLayout={selectionLayout}
        options={options[index]}
      ></Estimate>
    );
  });
  return <Wrapper $gap={gap}>{estimates}</Wrapper>;
}

export default EstimateList;

const Wrapper = styled.ul<{$gap: number}>`
  display: inline-flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
  gap: ${({$gap}) => $gap}px;
  flex-shrink: 0;
`;
