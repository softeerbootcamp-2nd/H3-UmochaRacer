import React, {useState} from 'react';
import styled, {css} from 'styled-components';
import {Body1_Regular, Body2_Regular} from '@/style/fonts';
import {colors} from '@/style/theme';
import {flexCenter} from '@/style/common';
import {GridData, gridData, selectData, MAX_LENGTH} from '../GuidData';

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

function GirdList() {
  const [selectArr, setSelectArr] = useState<string[]>([]);

  const handleClickCard = (e: React.MouseEvent) => {
    const target = e.currentTarget as HTMLDivElement;
    const firstChild = target.firstChild as HTMLElement;

    const selectedIndex = selectData.option?.indexOf(firstChild.innerHTML);

    if (selectedIndex > -1) {
      selectData.option = selectData.option.filter(
        (elem) => elem !== firstChild.innerHTML,
      );
    } else {
      selectData.option = selectArr.concat([firstChild.innerHTML]);
    }

    setSelectArr(selectData.option);
  };

  const GridList: React.JSX.Element[] = gridData.map(
    (gridData: GridData, gridIndex: number) => {
      return (
        <Grid.Container key={gridIndex}>
          <Grid.Comment>{gridData.comment}</Grid.Comment>
          <Grid.GridBox>
            {gridData.category.map(
              (categoryData: string, categoryIndex: number) => {
                let selectedIndex: number;
                if (selectData.option) {
                  selectedIndex = selectData.option.indexOf(categoryData);
                } else {
                  selectedIndex = -1;
                }

                return (
                  <Grid.GridCard
                    key={categoryIndex}
                    onClick={handleClickCard}
                    $isSelected={selectedIndex > -1}
                    $isSelectDone={selectData.option.length === MAX_LENGTH}
                  >
                    <Card.Option>{categoryData}</Card.Option>
                    <Card.IconBox
                      $number={selectArr.length}
                      $selectedIndex={selectedIndex}
                    >
                      {Circle()}
                    </Card.IconBox>
                  </Grid.GridCard>
                );
              },
            )}
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