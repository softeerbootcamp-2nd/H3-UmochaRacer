import {flexBetween, flexCenter} from '@/style/common';
import {Title4_Medium} from '@/style/fonts';
import React, {useEffect, useState} from 'react';
import styled from 'styled-components';
import Icon from '@/component/common/icons';
import ModelOptionGroup from './ModelOptiongroup';

import mainOption from '@/assets/mocks/mainOption.json';
import outerOption from '@/assets/mocks/outerColorOption.json';

type Option = {
  icon: string;
  name: string;
};

type ExclusiveOption = {
  exclusive: Option[];
  LeBlanc: Option[];
  Prestige: Option[];
  Calligraphy: Option[];
};

function ModelOption({name}: {name: string}) {
  const [optionData, setOptionData] = useState<ExclusiveOption | null>(null);

  useEffect(() => {
    let selectedData = null;

    switch (name) {
      case '핵심 옵션':
        selectedData = mainOption;
        break;
      case '외장 색상':
        selectedData = outerOption;
        break;
      case '내장 색상':
        selectedData = mainOption;
        break;
    }
    if (selectedData) {
      setOptionData(selectedData);
    }
  }, [name]);

  if (!optionData) {
    return null;
  }

  const DetailWrapperComponent =
    name === '외장 색상' ? FlexCenterWrapper : FlexBetweenWrapper;

  return (
    <Option.Wrapper>
      <Option.Title>{name}</Option.Title>
      <Icon name="OptionSeparator" />
      <DetailWrapperComponent>
        <ModelOptionGroup options={optionData.exclusive} />
        <ModelOptionGroup options={optionData.LeBlanc} />
        <ModelOptionGroup options={optionData.Prestige} />
        <ModelOptionGroup options={optionData.Calligraphy} />
      </DetailWrapperComponent>
    </Option.Wrapper>
  );
}

export default ModelOption;

const Option = {
  Wrapper: styled.div`
    width: 1024px;
    ${flexCenter}
    gap: 24px;
    flex-direction: column;
  `,
  Title: styled.p`
    width: 100%;
    ${Title4_Medium}
  `,
};

const FlexBetweenWrapper = styled.div`
  width: 100%;
  ${flexBetween}
  margin-bottom: 56px;
`;

const FlexCenterWrapper = styled.div`
  width: 100%;
  ${flexBetween}
  align-items: self-start;
  margin-bottom: 56px;
`;
