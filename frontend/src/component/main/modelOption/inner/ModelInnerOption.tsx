import React from 'react';
import ModelOptionDetail from './ModelOptionDetail';
import styled from 'styled-components';
import {flexBetween, flexCenter} from '@/style/common';
import innerOption from '@/assets/mocks/main/innerOption.json';

type Option = {
  icon: string;
  name: string;
  description?: string;
};

function ModelInnerOption() {
  const renderOptionDetails = (optionList: Option[]) => {
    return (
      <OptionWrapper>
        {optionList.map((item, index) => (
          <ModelOptionDetail
            key={index}
            src={item.icon}
            name={item.name}
            description={item.description}
          />
        ))}
      </OptionWrapper>
    );
  };

  return (
    <Wrapper>
      {renderOptionDetails(innerOption.exclusive)}
      {renderOptionDetails(innerOption.LeBlanc)}
      {renderOptionDetails(innerOption.Prestige)}
      {renderOptionDetails(innerOption.Calligraphy)}
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
