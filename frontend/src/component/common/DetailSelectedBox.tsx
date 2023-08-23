import {colors} from '@/style/theme';
import React, {useState, useRef, useEffect} from 'react';
import styled from 'styled-components';
import {Label1_Medium, Label2_Regular} from '@/style/fonts';

interface DetailData {
  title: string;
  description: string;
  info?: string;
}

interface DetailSelectedBoxProps {
  isOpen: boolean;
  id: number;
  descriptionData: DetailData[] | null;
}

function DetailSelectedBox({
  isOpen,
  id,
  descriptionData,
}: DetailSelectedBoxProps) {
  const contentRef = useRef<HTMLDivElement>(null);
  const [height, setHeight] = useState<number | undefined>(0);
  const [selectedDataIndex, setSelectedDataIndex] = useState<number>(0);
  const handleTitleClick = (event: React.MouseEvent, index: number) => {
    event.stopPropagation();
    setSelectedDataIndex(index);
  };
  useEffect(() => {
    setSelectedDataIndex(0);
  }, [isOpen]);
  useEffect(() => {
    setHeight(contentRef?.current?.clientHeight);
  }, [selectedDataIndex]);
  return (
    <Wrapper $isOpen={isOpen} $height={height}>
      <DetailContent ref={contentRef}>
        <TitleWrapper>
          {descriptionData?.map((data, index) => (
            <Title
              key={index}
              onClick={(event) => handleTitleClick(event, index)}
              $isSelected={selectedDataIndex === index}
            >
              {data.title}
            </Title>
          ))}
        </TitleWrapper>
        <DescriptionBox>
          {descriptionData && descriptionData[selectedDataIndex].description}
        </DescriptionBox>
      </DetailContent>
    </Wrapper>
  );
}
export default DetailSelectedBox;

const Wrapper = styled.div<{$isOpen: boolean; $height?: number}>`
  position: relative;
  width: 334px;
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

const DescriptionBox = styled.div`
  ${Label2_Regular}
`;
const TitleWrapper = styled.div`
  display: flex;
  width: 335px;
  align-items: flex-start;
  align-content: flex-start;
  gap: 4px 0px;
  flex-wrap: wrap;
  justify-content: flex-start;
  margin-bottom: 8px;

  & > * {
    margin-right: 1px;
  }

  & > *:not(:last-child)::after {
    content: 'ㆍ';
    margin: 0 1px;
  }
`;

const Title = styled.div<{$isSelected: boolean}>`
  cursor: pointer;
  ${(props) => (props.$isSelected ? {Label1_Medium} : Label2_Regular)};
  white-space: nowrap;
  transition: background-color 0.3s;
  color: ${(props) =>
    props.$isSelected ? colors.Cool_Grey : colors.Cool_Grey_003};
  &:hover {
    opacity: 0.8;
  }
`;
