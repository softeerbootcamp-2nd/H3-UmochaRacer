import React from 'react';
import styled from 'styled-components';
import {flexCenter} from '../../../style/common';
import {colors} from '../../../style/theme';

function Footer() {
  return (
    <Wrapper>
      <ModalToggle>
        <button>
          총 견적금액
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="16"
            height="16"
            viewBox="0 0 16 16"
            fill="none"
          >
            <path
              d="M7.99952 7.21865L4.69952 10.5186L3.75685 9.57598L7.99952 5.33331L12.2422 9.57598L11.2995 10.5186L7.99952 7.21865Z"
              fill="#AEB1B7"
            />
          </svg>
        </button>
        47,270,000 원
      </ModalToggle>
      <OptionSwitcher>
        <PrevOptionButton>이전</PrevOptionButton>
        <NextOptionButton>선택 완료</NextOptionButton>
      </OptionSwitcher>
    </Wrapper>
  );
}

export default Footer;

const Wrapper = styled.div`
  display: flex;
  justify-content: space-between;
  width: 100%;
  height: 47px;
`;

const ModalToggle = styled.div`
  display: flex;
  flex-wrap: wrap;
  flex-direction: row;
  width: 132px;
  height: 100%;
  gap: 10px;
`;

const OptionSwitcher = styled.div`
  display: flex;
  justify-content: space-between;
  width: 150px;
  height: 100%;
`;

const NextOptionButton = styled.button`
  ${flexCenter}
  width: 113px;
  padding: 14px 20px;
  border-radius: 6px;
  background: ${colors.Main_Hyundai_Blue};
  color: white;
  gap: 8px;
`;

const PrevOptionButton = styled.button`
  color: ${colors.Cool_Grey_003};
`;
