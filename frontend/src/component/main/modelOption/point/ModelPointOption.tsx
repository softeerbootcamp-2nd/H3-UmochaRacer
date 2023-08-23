import React from 'react';
import ModelOptionDetail from './ModelOptionDetail';
import styled from 'styled-components';
import {flexBetween, flexCenter} from '@/style/common';
import mainOption from '@/assets/mocks/main/mainOption.json';

type Option = {
  icon: string;
  name: string;
};

function ModelPointOption() {
  const renderOptionDetails = (optionList: Option[]) => {
    return (
      <OptionWrapper>
        {optionList.map((item, index) => (
          <ModelOptionDetail key={index} src={item.icon} name={item.name} />
        ))}
      </OptionWrapper>
    );
  };

  return (
    <Wrapper>
      {renderOptionDetails(mainOption.exclusive)}
      {renderOptionDetails(mainOption.LeBlanc)}
      {renderOptionDetails(mainOption.Prestige)}
      {renderOptionDetails(mainOption.Calligraphy)}
    </Wrapper>
  );
}

export default ModelPointOption;

const Wrapper = styled.div`
  ${flexBetween};
  width: 100%;
  padding: 0 24px 0 24px;
`;

const OptionWrapper = styled.div`
  ${flexCenter}
  flex-direction: column;
  gap: 24px;
`;
