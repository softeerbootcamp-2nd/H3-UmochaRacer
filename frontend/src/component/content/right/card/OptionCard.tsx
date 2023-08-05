import React from 'react';
import styled from 'styled-components';
import {colors} from '@/style/theme';

function OptionCard() {
  return (
    <Wrapper>
      <svg
        xmlns="http://www.w3.org/2000/svg"
        width="24"
        height="24"
        viewBox="0 0 24 24"
        fill="none"
      >
        <path
          d="M12 22C6.477 22 2 17.523 2 12C2 6.477 6.477 2 12 2C17.523 2 22 6.477 22 12C22 17.523 17.523 22 12 22ZM10.643 16.243L17.713 9.172L16.299 7.758L10.643 13.415L7.814 10.586L6.4 12L10.643 16.243Z"
          fill="#0E2B5C"
        />
      </svg>
      <Text1>구매자의 63%가 선택했어요!</Text1>
      <Text2>디젤 2.2</Text2>
    </Wrapper>
  );
}

export default OptionCard;

const Wrapper = styled.div`
  display: flex;
  flex-direction: column;
  width: 100%;
  height: 150px;
  padding: 20px;
  border-radius: 6px;
  border: 2px solid ${colors.Main_Hyundai_Blue};
  gap: 10px;
`;

const Text1 = styled.div`
  font-family: Body3_Regular;
  font-size: 12px;
  color: ${colors.Main_Hyundai_Blue};
`;

const Text2 = styled.div`
  font-family: Title2_Medium;
  font-size: 20px;
  color: ${colors.Cool_Grey};
`;
