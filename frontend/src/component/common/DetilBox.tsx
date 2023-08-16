import {colors} from '@/style/theme';
import React, {useContext, useEffect, useRef, useState} from 'react';
import styled from 'styled-components';
import {getCategory} from '../util/getCategory';
import {OptionContext} from '@/provider/optionProvider';
import useFetch from '../hooks/useFetch';

interface Info {
  title: string;
  description: string;
}

interface DeatailData {
  title: string;
  description: string;
  info?: Info[];
}

interface Props {
  isOpen: boolean;
  id: number;
}

function DetilBox({isOpen, id}: Props) {
  const contentRef = useRef<HTMLDivElement>(null);
  const {option} = useContext(OptionContext);
  const categoryName = getCategory(option);

  const fetchedDetails = useFetch<DeatailData>(`/detail/${categoryName}/${id}`);

  return (
    <Wrapper $isOpen={isOpen} $height={contentRef?.current?.clientHeight}>
      <DetailContent ref={contentRef}>
        {fetchedDetails.data?.description}
      </DetailContent>
    </Wrapper>
  );
}

export default DetilBox;

const Wrapper = styled.div<{$isOpen: boolean; $height?: number}>`
  position: relative;
  height: ${({$isOpen, $height}) => ($isOpen ? $height : '0')}px;
  opacity: ${({$isOpen}) => ($isOpen ? '1' : '0')};
  pointer-events: ${({$isOpen}) => !$isOpen && 'none'};
  overflow: hidden;
  transition:
    height 1s,
    opacity 1s;
`;

const DetailContent = styled.div`
  position: absolute;
  width: 100%;
  padding-top: 10px;
  padding-bottom: 10px;
  border-top: 1px solid ${colors.Cool_Grey_001};
`;
