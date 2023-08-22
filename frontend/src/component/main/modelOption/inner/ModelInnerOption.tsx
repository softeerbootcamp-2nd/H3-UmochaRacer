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

function ModelInnerOption() {
  const {data} = useFetch<TrimData[]>('/intro/interior-color');
  const renderOptionDetails = (optionList: Option[]) => {
    return (
      <OptionWrapper>
        {optionList.map((item, index) => (
          <ModelOptionDetail key={index} src={item.imageSrc} name={item.name} />
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

export default ModelInnerOption;

const Wrapper = styled.div`
  ${flexBetween};
  align-items: flex-start;
  width: 100%;
  padding-left: 24px;
`;

const OptionWrapper = styled.div`
  ${flexCenter}
  align-items: flex-start;
  flex-direction: column;
  gap: 24px;
`;
