import {
  Body1_Medium,
  Body1_Regular,
  Body2_Medium,
  Title1_Medium,
  Title3_Regular,
} from '@/style/fonts';
import {colors} from '@/style/theme';
import React from 'react';
import styled, {css} from 'styled-components';

function SelectFlow() {
  return (
    <Wrapper>
      <FlowContainer.Left>
        <Left.Level>
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="33"
            height="33"
            viewBox="0 0 33 33"
            fill="none"
          >
            <circle cx="16.5" cy="16.5" r="16.5" fill="#DFDFDF" />
          </svg>
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="33"
            height="33"
            viewBox="0 0 33 33"
            fill="none"
          >
            <circle cx="16.5" cy="16.5" r="16.5" fill="#DFDFDF" />
          </svg>
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="33"
            height="33"
            viewBox="0 0 33 33"
            fill="none"
          >
            <circle cx="16.5" cy="16.5" r="16.5" fill="#DFDFDF" />
          </svg>
        </Left.Level>
        <Left.Comment>만나서 반가워요!</Left.Comment>
        <Left.SelectionText>
          키워드를 중요한 순서로키워드를 중요한 순서로
        </Left.SelectionText>
        <Left.Tip>
          비슷한 나이대의 사람들이 선호하는 컬러를 알려드려요.
        </Left.Tip>
        <Left.Button>선택완료</Left.Button>
      </FlowContainer.Left>
      <FlowContainer.Right>
        <Right.GridBox>
          <Right.GridComment>
            내 차는 이런 부분에서 강했으면 좋겠어요
          </Right.GridComment>
          <Right.Grid>
            <Right.GridCard>
              <Right.Category>차박</Right.Category>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24"
                fill="none"
              >
                <circle cx="12" cy="12" r="11.5" stroke="#AEB1B7" />
              </svg>
            </Right.GridCard>
            <Right.GridCard></Right.GridCard>
            <Right.GridCard></Right.GridCard>
            <Right.GridCard></Right.GridCard>
          </Right.Grid>
        </Right.GridBox>
        <Right.GridBox>
          <Right.GridComment>
            내 차는 이런 부분에서 강했으면 좋겠어요
          </Right.GridComment>
          <Right.Grid>
            <Right.GridCard>
              <Right.Category>차박</Right.Category>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24"
                fill="none"
              >
                <circle cx="12" cy="12" r="11.5" stroke="#AEB1B7" />
              </svg>
            </Right.GridCard>
            <Right.GridCard></Right.GridCard>
            <Right.GridCard></Right.GridCard>
            <Right.GridCard></Right.GridCard>
            <Right.GridCard></Right.GridCard>
            <Right.GridCard></Right.GridCard>
          </Right.Grid>
        </Right.GridBox>
        <Right.GridBox>
          <Right.GridComment>
            내 차는 이런 부분에서 강했으면 좋겠어요
          </Right.GridComment>
          <Right.Grid>
            <Right.GridCard>
              <Right.Category>차박</Right.Category>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24"
                fill="none"
              >
                <circle cx="12" cy="12" r="11.5" stroke="#AEB1B7" />
              </svg>
            </Right.GridCard>
            <Right.GridCard></Right.GridCard>
            <Right.GridCard></Right.GridCard>
            <Right.GridCard></Right.GridCard>
          </Right.Grid>
        </Right.GridBox>
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
  Button: styled.button`
    ${Body1_Medium}
    display: inline-flex;
    padding: 19px 120px;
    justify-content: center;
    align-items: center;
    width: 297px;
    height: 59px;
    border-radius: 6px;
    opacity: 0;
    pointer-events: none;
    color: ${colors.Hyundai_White};
    background: ${colors.Main_Hyundai_Blue};
    gap: 10px;
  `,
};

const Right = {
  Card: styled.div`
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 343px;
    height: 60px;
    padding: 20px;
    border-radius: 6px;
    border: 2px solid ${colors.Main_Hyundai_Blue};
    background: ${colors.Hyundai_White};
  `,

  Category: styled.div`
    ${Body2_Medium}
  `,

  Icon: styled.div`
    width: 24px;
    height: 24px;
    flex-shrink: 0;
  `,

  GridBox: styled.div`
    display: flex;
    flex-direction: column;
    gap: 16px;
  `,

  GridComment: styled.div`
    ${Body1_Regular}
  `,

  Grid: styled.div`
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
    border: 2px solid ${colors.Main_Hyundai_Blue};
    background: ${colors.Hyundai_White};
    flex-shrink: 0;
  `,
};
