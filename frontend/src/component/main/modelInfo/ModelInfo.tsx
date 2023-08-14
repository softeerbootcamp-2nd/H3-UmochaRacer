import {flexBetween, flexCenter} from '@/style/common';
import React from 'react';
import {styled} from 'styled-components';

import model from '@/assets/mocks/main/modelData.json';
import {colors} from '@/style/theme';
import {Body1_Medium} from '@/style/fonts';

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
function ModelInfo({modelData}: modelDatProps) {
  return (
    <>
      <Model.Title>
        <Model.Img src={modelData.src} />
        <Model.Tag>{`${modelData.price.toLocaleString()}원 부터`}</Model.Tag>
      </Model.Title>
    </>
  );
}
function ModelInfoList() {
  return (
    <ModelInfoWrapper>
      {model.map((modelItem) => (
        <ModelInfo key={modelItem.id} modelData={modelItem} />
      ))}
    </ModelInfoWrapper>
  );
}

export default ModelInfoList;

const ModelInfoWrapper = styled.div`
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
  Img: styled.img`
    width: 214px;
    height: 155px;
    flex-shrink: 0;
  `,
  Tag: styled.p`
    color: ${colors.Cool_Grey};
    ${Body1_Medium};
  `,
};
