import React from 'react';
import styled, {css} from 'styled-components';
import {Body1_Regular, Body2_Regular} from '@/style/fonts';
import {colors} from '@/style/theme';
import {flexCenter} from '@/style/common';
import {
  useGuideFlowDispatch,
  useGuideFlowState,
  GridData,
  Tag,
  UPDATE_OPTIONS,
} from '@/provider/guideFlowProvider';

const Circle = () => {
  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="24"
      height="24"
      viewBox="0 0 24 24"
      fill="none"
    >
      <circle cx="12" cy="12" />
    </svg>
  );
};

const MAX_LENGTH = 3;

function GirdList() {
  const giudeFlowState = useGuideFlowState();
  const giudeFlowDipatch = useGuideFlowDispatch();
  let selectArr = giudeFlowState.dataObject.options;

  const handleClickCard = (e: React.MouseEvent) => {
    const target = e.currentTarget as HTMLDivElement;
    const dataSet = Number(target.dataset.id);
    const selectedIndex = selectArr?.indexOf(dataSet);

    if (selectedIndex !== undefined && selectedIndex > -1) {
      selectArr = selectArr?.filter((elem) => elem !== dataSet);
    } else {
      selectArr = selectArr?.concat([dataSet]);
    }

    giudeFlowDipatch({
      type: UPDATE_OPTIONS,
      payload: {dataObject: {options: selectArr}},
    });
  };

  const GridList: React.JSX.Element[] = giudeFlowState.optionTag.map(
    (gridData: GridData, gridIndex: number) => {
      return (
        <Grid.Container key={gridIndex}>
          <Grid.Comment>{gridData.category}</Grid.Comment>
          <Grid.GridBox>
            {gridData.tags.map((tag: Tag, categoryIndex: number) => {
              let selectedIndex: number;
              if (selectArr) {
                selectedIndex = selectArr.indexOf(tag.id);
              } else {
                selectedIndex = -1;
              }

              if (selectArr === undefined) return;

              return (
                <Grid.GridCard
                  key={categoryIndex}
                  data-id={tag.id}
                  onClick={handleClickCard}
                  $isSelected={selectedIndex > -1}
                  $isSelectDone={selectArr.length === MAX_LENGTH}
                >
                  <Card.Option>{tag.name}</Card.Option>
                  <Card.IconBox
                    $number={selectArr.length}
                    $selectedIndex={selectedIndex}
                  >
                    {Circle()}
                  </Card.IconBox>
                </Grid.GridCard>
              );
            })}
          </Grid.GridBox>
        </Grid.Container>
      );
    },
  );

  return <Wrapper>{GridList}</Wrapper>;
}

export default GirdList;

const Wrapper = styled.ul`
  display: flex;
  flex-direction: column;
  gap: 36px;
`;

const SelectedCard = css`
  background: ${colors.Hyundai_White};
  border: 2px solid ${colors.Main_Hyundai_Blue};
  div {
    color: #212121;
  }

  :last-child::before {
    opacity: 1;
  }
`;

const defaultCard = css`
  background: ${colors.Cool_Grey_001};
  border: 2px solid transparent;
  div {
    color: ${colors.Cool_Grey_003};
  }

  :last-child::before {
    opacity: 0;
  }
`;

const Grid = {
  Container: styled.li`
    display: flex;
    flex-direction: column;
    gap: 16px;
  `,

  Comment: styled.div`
    ${Body1_Regular}
  `,

  GridBox: styled.div`
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 12px;
  `,

  GridCard: styled.div<{$isSelected: boolean; $isSelectDone: boolean}>`
    display: flex;
    width: 166px;
    height: 60px;
    padding: 18px 18px 18px 20px;
    justify-content: space-between;
    align-items: center;
    border-radius: 6px;
    transition: 0.5s;
    cursor: pointer;

    ${({$isSelected}) => ($isSelected ? SelectedCard : defaultCard)}

    ${({$isSelected, $isSelectDone}) =>
      $isSelectDone &&
      !$isSelected &&
      css`
        pointer-events: none;
        cursor: none;
      `};
    circle {
      r: 11.5;
      stroke: #aeb1b7;
      transition: all 0.5s;
    }

    ${({$isSelected}) =>
      !$isSelected &&
      css`
        &:hover {
          ${SelectedCard}
        }
      `}
  `,
};

const Card = {
  Option: styled.div`
    ${Body1_Regular}
    transition: 0.5s;
  `,

  IconBox: styled.div<{$number: number; $selectedIndex: number}>`
    position: relative;
    width: 24px;
    height: 24px;

    &::before {
      ${Body2_Regular}
      ${flexCenter}
      position: absolute;
      content: '${({$number, $selectedIndex}) =>
        $selectedIndex > -1 ? $selectedIndex + 1 : $number + 1}';
      width: 100%;
      height: 100%;
      border-radius: 100%;
      color: ${colors.Hyundai_White};
      background: ${colors.Main_Hyundai_Blue};
      opacity: 0;
      transition: 0.5s;
    }
  `,
};
