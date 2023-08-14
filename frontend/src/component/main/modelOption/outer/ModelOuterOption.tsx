import React from 'react';
import ModelOptionDetail from './ModelOptionDetail';
import styled from 'styled-components';
import {flexBetween, flexCenter} from '@/style/common';
import outerOption from '@/assets/mocks/main/outerOption.json';

type Option = {
  icon: string;
  name: string;
};

function ModelInnerOption() {
  const renderOptionDetails = (optionList: Option[]) => {
    return (
      <OptionWrapper>
        {optionList.map((item, index) => (
          <ModelOptionDetail
            key={index}
            border={index === 0}
            color={item.icon}
            name={item.name}
          />
        ))}
      </OptionWrapper>
    );
  };

  return (
    <Wrapper>
      {renderOptionDetails(outerOption.exclusive)}
      {renderOptionDetails(outerOption.LeBlanc)}
      {renderOptionDetails(outerOption.Prestige)}
      {renderOptionDetails(outerOption.Calligraphy)}
    </Wrapper>
  );
}

export default ModelInnerOption;

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
