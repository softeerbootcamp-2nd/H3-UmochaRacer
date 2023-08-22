import {flexBetween, flexCenter} from '@/style/common';
import React from 'react';
import {styled} from 'styled-components';

import model from '@/assets/mocks/main/modelData.json';
import {colors} from '@/style/theme';
import {Body2_Regular} from '@/style/fonts';

type modelDataType = {
  id: number;
  name: string;
  tag: string;
  price: number;
  src: string;
};

interface modelDatProps {
  modelData: modelDataType;
}
function ModelTitle({modelData}: modelDatProps) {
  return (
    <>
      <Model.Title>
        <Model.Name>{modelData.name}</Model.Name>
        <Model.Tag>{modelData.tag}</Model.Tag>
      </Model.Title>
    </>
  );
}
function ModelTitleList() {
  return (
    <ModelTitleWrapper>
      {model.map((modelItem) => (
        <ModelTitle key={modelItem.id} modelData={modelItem} />
      ))}
    </ModelTitleWrapper>
  );
}

export default ModelTitleList;

const ModelTitleWrapper = styled.div`
  ${flexBetween};
  width: 1024px;
`;
const Model = {
  Title: styled.div`
    width: 214px;
    ${flexCenter}
    flex-direction: column;
    gap: 16px;
  `,
  Name: styled.p`
    color: ${colors.Cool_Grey};
    font-family: Hyundai Sans Head Medium;
    font-size: 28px;
    font-style: normal;
    font-weight: 500;
    letter-spacing: -0.84px;
  `,
  Tag: styled.p`
    color: ${colors.Cool_Grey};
    ${Body2_Regular};
  `,
};
