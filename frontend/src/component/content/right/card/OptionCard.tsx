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
      <Footer>
        <Price>+ 1,480,000원</Price>
        <Detail>
          자세히 보기
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="14"
            height="14"
            viewBox="0 0 14 14"
            fill="none"
          >
            <path
              d="M7.77818 7.84802L12.0129 3.88813L13.2226 5.0193L7.77818 10.1104L2.33374 5.0193L3.54343 3.88813L7.77818 7.84802Z"
              fill="#AEB1B7"
            />
          </svg>
        </Detail>
      </Footer>
    </Wrapper>
  );
}

export default OptionCard;

const Wrapper = styled.div`
  display: flex;
  flex-shrink: 0;
  flex-direction: column;
  width: 375px;
  height: 150px;
  padding: 20px;
  border-radius: 6px;
  border: 2px solid ${colors.Main_Hyundai_Blue};
`;

const Text1 = styled.div`
  margin-top: 10px;
  height: 16px;
  line-height: 130%;
  font-family: Body3_Regular;
  font-size: 12px;
  color: ${colors.Main_Hyundai_Blue};
`;

const Text2 = styled.div`
  margin-top: 4px;
  height: 26px;
  line-height: 130%;
  font-family: Title2_Medium;
  font-size: 20px;
  color: ${colors.Cool_Grey};
`;

const Footer = styled.div`
  display: flex;
  justify-content: space-between;
  height: 18px;
  margin-top: 13px;
`;

const Price = styled.div`
  line-height: 130%;
  font-family: Body2_Regular;
  font-size: 14px;
  color: ${colors.Main_Hyundai_Blue};
`;

const Detail = styled.div`
  display: inline-flex;
  align-items: center;
  height: 16px;
  font-size: 12px;
  font-style: normal;
  font-weight: 500;
  line-height: 130%; /* 15.6px */
  letter-spacing: -0.36px;
  color: ${colors.Cool_Grey_003};
  gap: 2px;
`;
