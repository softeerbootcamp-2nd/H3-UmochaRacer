import React, {useRef, useState} from 'react';
import styled, {css} from 'styled-components';
import {Body1_Medium, Title1_Medium, Title3_Regular} from '@/style/fonts';
import {colors} from '@/style/theme';
import GridList from './selectflow/GridList';
import CardList from './selectflow/CardList';
import {flexCenter} from '@/style/common';
import {useGuideFlowState, GuideFlowState} from '@/provider/guideFlowProvider';

interface FlowDescription {
  comment: string;
  suggest: string;
  tip: string;
}

const flowTextArr: FlowDescription[] = [
  {
    comment: '만나서 반가워요!',
    suggest: '연령대를 선택해주세요.',
    tip: '비슷한 나이대의 사람들이 선호하는 컬러를 알려드려요.',
  },
  {
    comment: '금방 끝나요!',
    suggest: '성별을 선택해주세요.',
    tip: '더 자세한 욥션을 추천해드릴 수 있어요.',
  },
  {
    comment: '이제 마지막이에요.',
    suggest: '키워드를 중요한 순서로 3개 선택해주세요.',
    tip: '나의 관심사와 취향을 반영해 더 자세하게 추천해줄 수 있어요.',
  },
];

const LAST_FLOW_NUM: number = 2;
const FLOW_NUM = 3;

const CircleIcon = (isSelect: boolean) => {
  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="33"
      height="33"
      viewBox="0 0 33 33"
      fill="none"
    >
      <circle
        cx="16.5"
        cy="16.5"
        r="16.5"
        fill={isSelect ? colors.Main_Hyundai_Blue : '#DFDFDF'}
      />
    </svg>
  );
};

interface Props {
  setComplete: React.Dispatch<React.SetStateAction<boolean>>;
}

const isMove = (
  prevLevel: number,
  currLevel: number,
  state: GuideFlowState,
) => {
  let move: boolean | number | string | undefined = true;

  if (prevLevel < currLevel) {
    move = prevLevel === 0 ? state.dataObject.age : state.dataObject.gender;
  }

  return move;
};

const DISTANCE_BETWEEN = 48.99;

const CircleSwap = (
  leftCircle: HTMLDivElement | null,
  rightCircle: HTMLDivElement | null,
  swapLevel: number,
) => {
  const SWAP_PIXEL: number = DISTANCE_BETWEEN * swapLevel;
  if (leftCircle && rightCircle) {
    leftCircle.style.transform = `translateX(${SWAP_PIXEL}px)`;
    rightCircle.style.transform = `translateX(-${SWAP_PIXEL}px)`;
  }
};

const MAX_LENGTH = 3;

function SelectFlow({setComplete}: Props) {
  const [flowLevel, setFlowLevel] = useState<number>(0);
  const guideFlowState = useGuideFlowState();
  const artistRef = useRef<null[] | HTMLDivElement[]>([]);
  const prevFlowRef = useRef<number>(0);
  const swapTargetRef = useRef<HTMLDivElement | null>();

  const handleCardClick = (nextFlow: number) => {
    setFlowLevel(nextFlow);
  };

  const handleSwapEnd = (e: React.TransitionEvent, index: number) => {
    const target = e.target as HTMLDivElement;
    target.style.transition = 'none';
    target.style.transform = '';

    const circle = target.firstChild?.firstChild as HTMLElement;
    if (index === flowLevel) {
      circle.style.fill = colors.Main_Hyundai_Blue;
    } else {
      circle.style.fill = '#DFDFDF';
    }

    prevFlowRef.current = flowLevel;
  };

  if (artistRef.current) {
    let leftElem: HTMLDivElement | null,
      rightElem: HTMLDivElement | null,
      swapLevel: number;

    if (prevFlowRef.current !== undefined) {
      swapTargetRef.current = artistRef.current[prevFlowRef.current];

      if (prevFlowRef.current > flowLevel) {
        leftElem = artistRef.current[flowLevel];
        rightElem = swapTargetRef.current;
        swapLevel = prevFlowRef.current - flowLevel;
      } else {
        leftElem = swapTargetRef.current;
        rightElem = artistRef.current[flowLevel];
        swapLevel = flowLevel - prevFlowRef.current;
      }

      if (leftElem && rightElem) {
        leftElem.style.transition = '0.5s';
        rightElem.style.transition = '0.5s';
      }

      CircleSwap(leftElem, rightElem, swapLevel);
    }
  }

  const icons: React.JSX.Element[] = Array.from({length: FLOW_NUM}).map(
    (_, index) => {
      return (
        <Left.IconBox
          key={index}
          style={{transition: 'all 0.5s'}}
          onClick={() => {
            if (!isMove(flowLevel, index, guideFlowState)) return;
            handleCardClick(index);
          }}
          onTransitionEnd={(e) => {
            handleSwapEnd(e, index);
          }}
          ref={(element) => {
            artistRef.current[index] = element;
          }}
        >
          {CircleIcon(index === prevFlowRef.current)}
        </Left.IconBox>
      );
    },
  );

  const levels: React.JSX.Element[] = Array.from({length: FLOW_NUM}).map(
    (_, index) => <Left.IconBox key={index}>{index + 1}</Left.IconBox>,
  );

  return (
    <Wrapper>
      <FlowContainer.Left>
        <Left.Level>
          {icons}
          <Left.LevelBox>{levels}</Left.LevelBox>
        </Left.Level>
        <Left.Comment>{flowTextArr[flowLevel].comment}</Left.Comment>
        <Left.SelectionText>
          {flowTextArr[flowLevel].suggest}
        </Left.SelectionText>
        <Left.Tip>{flowTextArr[flowLevel].tip}</Left.Tip>
        <Left.Button
          $isVisible={flowLevel === LAST_FLOW_NUM}
          onClick={() => {
            const selectArr = guideFlowState.dataObject.options;
            if (selectArr !== undefined && selectArr.length < MAX_LENGTH)
              return;
            setComplete(true);
          }}
        >
          선택완료
        </Left.Button>
      </FlowContainer.Left>
      <FlowContainer.Right>
        {flowLevel !== LAST_FLOW_NUM ? (
          <CardList
            key={flowLevel}
            flowLevel={flowLevel}
            onClick={handleCardClick}
          />
        ) : (
          <GridList />
        )}
      </FlowContainer.Right>
    </Wrapper>
  );
}

export default SelectFlow;

const Wrapper = styled.div`
  display: flex;
  width: 100%;
  height: 100%;
`;

const flexLayout = css`
  display: flex;
  flex-direction: column;
  justify-content: center;
  flex: 1;
`;

const FlowContainer = {
  Left: styled.div`
    ${flexLayout}
    gap: 16px;
  `,
  Right: styled.div`
    ${flexLayout}
    align-items: flex-end;
    gap: 12px;
  `,
};

const Left = {
  Level: styled.div`
    display: inline-flex;
    align-items: flex-start;
    position: relative;
    width: 131px;
    height: 33px;
    gap: 16px;
  `,

  LevelBox: styled.div`
    display: flex;
    justify-content: space-between;
    position: absolute;
    width: 100%;
    height: 100%;
    pointer-events: none;

    div {
      ${Title1_Medium}
      font-size: 20px;
      font-weight: 400;
      ${flexCenter}
      color: ${colors.Hyundai_White};
    }
  `,
  IconBox: styled.div`
    width: 33px;
    height: 33px;
    cursor: pointer;
    transition: transform 0.5s;
  `,
  FlowBtn: styled.button`
    width: 33px;
    height: 33px;
    cursor: pointer;
  `,
  Comment: styled.div`
    ${Title3_Regular}
    font-size: 32px;
    width: 290px;
  `,
  SelectionText: styled.div`
    ${Title1_Medium}
    font-size: 32px;
    line-height: 140%;
    width: 290px;
  `,
  Tip: styled.div`
    ${Title3_Regular}
    color: #8C8C8C;
    font-size: 20px;
  `,
  Button: styled.button<{$isVisible: boolean}>`
    ${Body1_Medium}
    display: inline-flex;
    padding: 19px 120px;
    justify-content: center;
    align-items: center;
    width: 297px;
    height: 59px;
    border-radius: 6px;
    opacity: ${({$isVisible}) => ($isVisible ? 1 : 0)};
    pointer-events: ${({$isVisible}) => ($isVisible ? '' : 'none')};
    color: ${colors.Hyundai_White};
    background: ${colors.Main_Hyundai_Blue};
    transition: 0.5s;
    gap: 10px;
  `,
};
