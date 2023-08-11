import React from 'react';
import {IconType} from '@/component/common/icons';
import ModelOptionDetail from './ModelOptionDetail';
import styled from 'styled-components';
import {flexCenter} from '@/style/common';

interface ModelOptionGroupProps {
  options: {icon: string; name: string}[];
}

function ModelOptionGroup({options}: ModelOptionGroupProps) {
  const showDetailItems = () => {
    return (
      <>
        {options.map((item, index) => (
          <ModelOptionDetail
            key={index}
            icon={item.icon as IconType}
            name={item.name}
          />
        ))}
      </>
    );
  };
  return <Wrapper>{showDetailItems()}</Wrapper>;
}

export default ModelOptionGroup;
const Wrapper = styled.div`
  width: 214px;
  ${flexCenter}
  flex-direction: column;
  gap: 24px;
`;
