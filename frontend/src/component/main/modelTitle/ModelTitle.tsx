import {flexBetween, flexCenter} from '@/style/common';
import React, {useState} from 'react';
import {styled} from 'styled-components';

import trim from '@/assets/mocks/trim.json';
import {colors} from '@/style/theme';
import {Body2_Regular} from '@/style/fonts';

type TrimData = {
  id: number;
  name: string;
  tag: string;
  price: number;
  route: string;
  description?: {
    title: string;
    hasDescription: boolean;
    descriptionData: Array<{
      main: string;
      sub: string;
    }>;
  } | null;
};

interface TrimCardProps {
  trimData: TrimData;
}
function ModelTitle({trimData}: TrimCardProps) {
  return (
    <>
      <Model.Title>
        <Model.Name>{trimData.name}</Model.Name>
        <Model.Tag>{trimData.tag}</Model.Tag>
      </Model.Title>
    </>
  );
}
function ModelTitleList() {
  return (
    <ModelTitleWrapper>
      {trim.map((trimItem) => (
        <ModelTitle key={trimItem.id} trimData={trimItem} />
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
    background: red;
    width: 214px;
    ${flexCenter}
    flex-direction: column;
    gap: 16px;
  `,
  Name: styled.p`
    color: ${colors.Cool_Grey};
    font-family: Hyundai Sans Head KR;
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
