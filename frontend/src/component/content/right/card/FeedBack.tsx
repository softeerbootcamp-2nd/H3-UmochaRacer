import React from 'react';
import styled from 'styled-components';
import {colors} from '@/style/theme';
import {Body3_Regular, Title2_Medium} from '@/style/fonts';

interface Props {
  visible: boolean;
}

const SmileIcon = () => {
  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="30"
      height="30"
      viewBox="0 0 24 24"
      fill="none"
    >
      <g clipPath="url(#clip0_1816_8717)">
        <path
          d="M4.92901 19.071C3.99904 18.1434 3.26154 17.0413 2.75889 15.8278C2.25623 14.6143 1.99833 13.3135 2.00001 12C2.00001 6.477 6.47701 2 12 2C17.523 2 22 6.477 22 12C22 17.523 17.523 22 12 22H2.00001L4.92901 19.071ZM8.00001 13C8.00001 14.0609 8.42144 15.0783 9.17158 15.8284C9.92173 16.5786 10.9391 17 12 17C13.0609 17 14.0783 16.5786 14.8284 15.8284C15.5786 15.0783 16 14.0609 16 13H8.00001Z"
          fill="#FFA724"
        />
        <circle cx="10" cy="10" r="1" fill="#0E2B5C" />
        <circle cx="14" cy="10" r="1" fill="#0E2B5C" />
      </g>
      <defs>
        <clipPath id="clip0_1816_8717">
          <rect width="24" height="24" fill="white" />
        </clipPath>
      </defs>
    </svg>
  );
};
function FeedBack() {
  return (
    <Wrapper>
      <IconBox>{SmileIcon()}</IconBox>
      <TitleBox>디젤엔진은 효율이 좋아요!</TitleBox>
      <Description>
        알콘(alcon) 단조 브레이크 & 20인치 휠 패키지는 뛰어난 제동력이
        강점이에요! 안전과 디자인을 모두 원하신다면, 탁월한 선택입니다.
      </Description>
    </Wrapper>
  );
}

export default FeedBack;

const Wrapper = styled.div`
  position: absolute;
  width: 374px;
  height: 150px;
  top: 0;
  left: 0;
  padding: 20px;
  border-radius: 6px;
  background: ${colors.Main_Hyundai_Blue};
`;

const IconBox = styled.div`
  width: 30px;
  height: 30px;
`;

const TitleBox = styled.div`
  ${Title2_Medium}
  height: 26px;
  margin-top: 14px;
  color: ${colors.Hyundai_White};
`;

const Description = styled.div`
  ${Body3_Regular}
  margin-top: 8px;
  color: ${colors.Hyundai_White};
`;
