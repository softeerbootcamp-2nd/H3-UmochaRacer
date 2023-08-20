import React, {useState} from 'react';
import styled, {css} from 'styled-components';
import {Body1_Medium, Title1_Medium, Title3_Regular} from '@/style/fonts';
import {colors} from '@/style/theme';
import {selectData} from './GuidData';
import GridList from './selectflow/GridList';
import CardList from './selectflow/CardList';

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

const CircleIcon = () => {
  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="33"
      height="33"
      viewBox="0 0 33 33"
      fill="none"
    >
      <circle cx="16.5" cy="16.5" r="16.5" fill="#DFDFDF" />
    </svg>
  );
};

interface Props {
  setComplete: React.Dispatch<React.SetStateAction<boolean>>;
}

const isMove = (prevLevel: number, currLevel: number) => {
  const category: string[] = ['age', 'gender'];
  if (prevLevel < currLevel) {
    return selectData[category[prevLevel]] !== undefined;
  }
  return true;
};

function SelectFlow({setComplete}: Props) {
  const [flowLevel, setFlowLevel] = useState(0);
  const handleCardClick = (nextFlow: number) => {
    setFlowLevel(nextFlow);
  };

  const icons: React.JSX.Element[] = Array.from({length: FLOW_NUM}).map(
    (_, index) => {
      return (
        <Left.IconBox
          key={index}
          onClick={() => {
            if (!isMove(flowLevel, index)) return;
            handleCardClick(index);
          }}
        >
          {CircleIcon()}
        </Left.IconBox>
      );
    },
  );

  return (
    <Wrapper>
      <FlowContainer.Left>
        <Left.Level>{icons}</Left.Level>
        <Left.Comment>{flowTextArr[flowLevel].comment}</Left.Comment>
        <Left.SelectionText>
          {flowTextArr[flowLevel].suggest}
        </Left.SelectionText>
        <Left.Tip>{flowTextArr[flowLevel].tip}</Left.Tip>
        <Left.Button
          $isVisible={flowLevel === LAST_FLOW_NUM}
          onClick={() => {
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
    width: 131px;
    height: 33px;
    gap: 16px;
  `,
  IconBox: styled.div`
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
