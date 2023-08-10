import React from 'react';
import {IconType} from '@/component/common/icons';
import ModelOptionDetail from './ModelOptionDetail';
import styled from 'styled-components';
import {flexCenter} from '@/style/common';

interface ModelOptionGroupProps {
  options: {icon: string; name: string}[];
}

function ModelOptionGroup({options}: ModelOptionGroupProps) {
  return (
    <Wrapper>
      {options.map((item, index) => (
        <ModelOptionDetail
          key={index}
          icon={item.icon as IconType}
          name={item.name}
        />
      ))}
    </Wrapper>
  );
}

export default ModelOptionGroup;
const Wrapper = styled.div`
  width: 214px;
  ${flexCenter}
  flex-direction: column;
  gap: 36px;
`;
