import React from 'react';
import styled from 'styled-components';
import {flexCenter} from '@/style/common';
import {colors} from '@/style/theme';
import {Label2_Regular, Title4_Medium} from '@/style/fonts';
interface warningProps {
  text: string;
  index: number;
  onClick: (index: number) => void;
  onPopup: (state: boolean) => void;
}
function Warning({text, index, onClick, onPopup}: warningProps) {
  const handleClickPopup = () => {
    onClick(index);
    onPopup(false);
  };
  return (
    <Warnings.Wrapper>
      <Warnings.Box>
        <Warnings.Text>{text}을(를) 선택 완료 눌러주세요.</Warnings.Text>
        <Warnings.Confrim onClick={() => handleClickPopup()}>
          <Warnings.ConfirmP>확인</Warnings.ConfirmP>
        </Warnings.Confrim>
      </Warnings.Box>
    </Warnings.Wrapper>
  );
}
export default Warning;
const Warnings = {
  Wrapper: styled.div`
    width: 100vw;
    height: 100vh;
    position: fixed;
    background: rgba(0, 0, 0, 0.8);
    top: 0;
    left: 0;
    z-index: 9999999;
    display: flex;
    align-items: center;
    justify-content: center;
  `,
  Box: styled.div`
    width: 300px;
    height: 200px;
    ${flexCenter};
    flex-direction: column;
    background-color: white;
    border-radius: 8px;
  `,
  Text: styled.p`
    color: ${colors.Main_Hyundai_Blue};
    ${Title4_Medium};
  `,
  Confrim: styled.div`
    width: 50px;
    height: 30px;
    background-color: ${colors.Main_Hyundai_Blue};
    border-radius: 8px;
    ${flexCenter};
    margin-top: 16px;
    cursor: pointer;
  `,
  ConfirmP: styled.p`
    color: white;
    ${Label2_Regular};
  `,
};
