import React from 'react';
import ModelOptionDetail from './ModelOptionDetail';
import styled from 'styled-components';
import {flexBetween, flexCenter} from '@/style/common';
import useFetch from '@/component/hooks/useFetch';
import {sortData} from '@/component/util/sortData';

type Option = {
  imageSrc: string;
  name: string;
};

type TrimData = {
  trim: string;
  sources: Option[];
};

function ModelOuterOption() {
  const {data} = useFetch<TrimData[]>('/intro/exterior-color');

  const renderOptionDetails = (optionList: Option[]) => {
    return (
      <OptionWrapper>
        {optionList.map((item, index) => (
          <ModelOptionDetail
            key={index}
            border={item.name === '크리미 화이트 펄'}
            src={item.imageSrc}
            name={item.name}
          />
        ))}
      </OptionWrapper>
    );
  };
  return (
    <Wrapper>
      {data &&
        sortData(data).map((trimData, index) => (
          <div key={index}>{renderOptionDetails(trimData.sources)}</div>
        ))}
    </Wrapper>
  );
}

export default ModelOuterOption;

const Wrapper = styled.div`
  ${flexBetween};
  align-items: flex-start;
  width: 100%;
  padding: 0 24px 0 24px;
`;

const OptionWrapper = styled.div`
  ${flexCenter}
  flex-direction: column;
  gap: 24px;
`;
