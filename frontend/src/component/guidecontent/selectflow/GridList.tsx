import React, {useState} from 'react';
import styled, {keyframes} from 'styled-components';
import {Body1_Regular, Body2_Regular} from '@/style/fonts';
import {colors} from '@/style/theme';
import {flexCenter} from '@/style/common';

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
  const [selectNum, setSelectNum] = useState<number>(0);

  return (
    <Wrapper>
      <Grid.Container>
        <Grid.Comment>내 차는 이런 부분에서 강했으면 좋겠어요</Grid.Comment>
        <Grid.GridBox>
          <Grid.GridCard>
            <Card.Option>주행력</Card.Option>
            <Card.IconBox $number={selectNum}>{Circle()}</Card.IconBox>
          </Grid.GridCard>
          <Grid.GridCard>
            <Card.Option>소음</Card.Option>
            <Card.IconBox $number={selectNum}>{Circle()}</Card.IconBox>
          </Grid.GridCard>
          <Grid.GridCard></Grid.GridCard>
          <Grid.GridCard></Grid.GridCard>
        </Grid.GridBox>
      </Grid.Container>
      <Grid.Container>
        <Grid.Comment>나는 차를 탈 때 이런게 중요해요</Grid.Comment>
        <Grid.GridBox>
          <Grid.GridCard></Grid.GridCard>
          <Grid.GridCard></Grid.GridCard>
          <Grid.GridCard></Grid.GridCard>
          <Grid.GridCard></Grid.GridCard>
          <Grid.GridCard></Grid.GridCard>
          <Grid.GridCard></Grid.GridCard>
        </Grid.GridBox>
      </Grid.Container>
      <Grid.Container>
        <Grid.Comment>나는 차를 이렇게 활용하고 싶어요</Grid.Comment>
        <Grid.GridBox>
          <Grid.GridCard></Grid.GridCard>
          <Grid.GridCard></Grid.GridCard>
          <Grid.GridCard></Grid.GridCard>
          <Grid.GridCard></Grid.GridCard>
        </Grid.GridBox>
      </Grid.Container>
    </Wrapper>
  );
}

export default GirdList;

const circleAni = keyframes`
  0% {
    stroke: #aeb1b7;
    fill: transparent;
  }
  100% {
    stroke: none;
    fill: #0e2b5c;
  }
`;

const Wrapper = styled.ul`
  display: flex;
  flex-direction: column;
  gap: 36px;
`;

const Grid = {
  Container: styled.li`
    display: flex;
    flex-direction: column;
    cursor: pointer;
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

  GridCard: styled.div`
    display: flex;
    width: 166px;
    height: 60px;
    padding: 18px 18px 18px 20px;
    justify-content: space-between;
    align-items: center;
    border-radius: 6px;
    border: 2px solid transparent;
    background: ${colors.Cool_Grey_001};
    transition: 0.5s;

    circle {
      r: 11.5;
      stroke: #aeb1b7;
      transition: all 0.5s;
    }

    &:hover {
      background: ${colors.Hyundai_White};
      border: 2px solid ${colors.Main_Hyundai_Blue};
      div {
        color: #212121;
      }
      circle {
        animation: ${circleAni} 0.5s forwards;
      }

      :last-child::before {
        opacity: 1;
      }
    }
  `,
};

const Card = {
  Option: styled.div`
    ${Body1_Regular}
    color: ${colors.Cool_Grey_003};
    transition: 0.5s;
  `,

  IconBox: styled.div<{$number: number}>`
    position: relative;
    width: 24px;
    height: 24px;

    &::before {
      ${Body2_Regular}
      ${flexCenter}
      position: absolute;
      content: '${({$number}) => $number + 1}';
      width: 100%;
      height: 100%;
      color: ${colors.Hyundai_White};
      opacity: 0;
    }
  `,
};
