import React from 'react';
import styled, {keyframes} from 'styled-components';
import {flexCenter} from '@/style/common';
import {Title1_Medium} from '@/style/fonts';
import {colors} from '@/style/theme';
import Keyframes from 'styled-components/dist/models/Keyframes';
import Bottom from './Bottom';

const RADIUS = 174;
const ROUND = RADIUS * 2 * Math.PI;

const progressAni = keyframes`
100%{
    stroke-dashoffset: 0;
}`;

const blink = keyframes`
  0%{
    opacity:1;
  }
  50%{
    opacity:0;
  }
  100%{
    opacity:1;
  }
`;

const blink2 = keyframes`
  0%{
    opacity:0;
  }
  50%{
    opacity:1;
  }
  100%{
    opacity:0;
  }
`;

const ProgressBar = () => {
  const transform = 'rotate(-90deg)';
  return (
    <svg
      className="absolute z-10 -rotate-90"
      width="170"
      height="170"
      viewBox="0 0 360 360"
      fill="transparent"
      style={{transform}}
    >
      <circle
        stroke={colors.Cool_Grey_002}
        cx="180"
        cy="180"
        r={RADIUS}
        strokeWidth="12"
        strokeDasharray={ROUND}
      />
      <ProgressCircle
        stroke={colors.Main_Hyundai_Blue}
        cx="180"
        cy="180"
        r={RADIUS}
        strokeWidth="12"
        strokeDasharray={ROUND}
        strokeDashoffset={ROUND}
      ></ProgressCircle>
    </svg>
  );
};

const CarIcon = () => {
  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="106"
      height="106"
      viewBox="0 0 106 106"
      fill="none"
    >
      <path
        d="M83.9193 83.6667H22.0859V88.0833C22.0859 89.2547 21.6206 90.3781 20.7923 91.2064C19.964 92.0347 18.8406 92.5 17.6693 92.5H13.2526C12.0812 92.5 10.9578 92.0347 10.1295 91.2064C9.30126 90.3781 8.83594 89.2547 8.83594 88.0833V43.9167L19.7893 18.353C20.4709 16.763 21.6043 15.4081 23.049 14.4565C24.4937 13.5049 26.186 12.9985 27.9159 13H78.0893C79.8177 13.0002 81.5081 13.5075 82.9511 14.459C84.394 15.4105 85.5261 16.7644 86.2071 18.353L97.1693 43.9167V88.0833C97.1693 89.2547 96.704 90.3781 95.8757 91.2064C95.0474 92.0347 93.924 92.5 92.7526 92.5H88.3359C87.1646 92.5 86.0412 92.0347 85.2129 91.2064C84.3846 90.3781 83.9193 89.2547 83.9193 88.0833V83.6667ZM88.3359 52.75H17.6693V74.8333H88.3359V52.75ZM18.4466 43.9167H87.5586L78.0937 21.8333H27.9159L18.451 43.9167H18.4466ZM28.7109 70.4167C26.9539 70.4167 25.2688 69.7187 24.0264 68.4762C22.7839 67.2338 22.0859 65.5487 22.0859 63.7917C22.0859 62.0346 22.7839 60.3495 24.0264 59.1071C25.2688 57.8647 26.9539 57.1667 28.7109 57.1667C30.468 57.1667 32.1531 57.8647 33.3955 59.1071C34.638 60.3495 35.3359 62.0346 35.3359 63.7917C35.3359 65.5487 34.638 67.2338 33.3955 68.4762C32.1531 69.7187 30.468 70.4167 28.7109 70.4167ZM77.2943 70.4167C75.5372 70.4167 73.8521 69.7187 72.6097 68.4762C71.3673 67.2338 70.6693 65.5487 70.6693 63.7917C70.6693 62.0346 71.3673 60.3495 72.6097 59.1071C73.8521 57.8647 75.5372 57.1667 77.2943 57.1667C79.0513 57.1667 80.7364 57.8647 81.9789 59.1071C83.2213 60.3495 83.9193 62.0346 83.9193 63.7917C83.9193 65.5487 83.2213 67.2338 81.9789 68.4762C80.7364 69.7187 79.0513 70.4167 77.2943 70.4167Z"
        fill="#0E2B5C"
      />
    </svg>
  );
};

const ToolIcon = () => {
  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="100"
      height="100"
      viewBox="0 0 100 100"
      fill="none"
    >
      <g clipPath="url(#clip0_182_9158)">
        <path
          d="M22.2074 13.6291C24.8076 12.7015 27.6176 12.531 30.3109 13.1375C33.0042 13.7439 35.47 15.1024 37.4217 17.0549C39.3734 19.0075 40.7307 21.4739 41.336 24.1674C41.9412 26.861 41.7695 29.671 40.8407 32.2708L86.0282 77.4583L77.1865 86.2958L31.999 41.1125C29.3988 42.0401 26.5887 42.2106 23.8955 41.6041C21.2022 40.9977 18.7364 39.6392 16.7847 37.6867C14.833 35.7341 13.4756 33.2677 12.8704 30.5741C12.2652 27.8806 12.4369 25.0706 13.3657 22.4708L22.6824 31.7916C23.2589 32.3886 23.9486 32.8647 24.7111 33.1923C25.4736 33.5198 26.2937 33.6922 27.1236 33.6994C27.9535 33.7066 28.7765 33.5485 29.5446 33.2343C30.3127 32.92 31.0105 32.4559 31.5973 31.8691C32.1842 31.2823 32.6482 30.5844 32.9625 29.8163C33.2767 29.0482 33.4349 28.2252 33.4277 27.3954C33.4205 26.5655 33.248 25.7454 32.9205 24.9828C32.5929 24.2203 32.1168 23.5307 31.5199 22.9541L22.2032 13.625L22.2074 13.6291ZM65.4032 21.4791L78.6615 14.1125L84.5532 20.0041L77.1865 33.2625L69.8199 34.7375L60.9865 43.575L55.0907 37.6833L63.9282 28.8458L65.4032 21.4791ZM35.9407 53.8874L44.7782 62.7291L24.1532 83.3541C23.0158 84.4808 21.4895 85.1281 19.8889 85.1625C18.2884 85.1969 16.7356 84.6158 15.5509 83.5391C14.3662 82.4623 13.6398 80.972 13.5217 79.3754C13.4035 77.7788 13.9024 76.1978 14.9157 74.9583L15.3199 74.5124L35.9449 53.8874H35.9407Z"
          fill="#0E2B5C"
        />
      </g>
      <defs>
        <clipPath id="clip0_182_9158">
          <rect width="100" height="100" fill="white" />
        </clipPath>
      </defs>
    </svg>
  );
};

interface Props {
  setLoaded: React.Dispatch<React.SetStateAction<boolean>>;
}

function LoadingAnimation({setLoaded}: Props) {
  return (
    <Wrapper>
      <Container>
        <Top>
          {ProgressBar()}
          <IconBox $ani={blink}>{CarIcon()}</IconBox>
          <IconBox $ani={blink2}>{ToolIcon()}</IconBox>
        </Top>
        <Middle>나만의 팰리세이드가 만들어지고 있어요!</Middle>
        <Bottom setLoaded={setLoaded}></Bottom>
      </Container>
    </Wrapper>
  );
}

export default LoadingAnimation;

const Wrapper = styled.div`
  ${flexCenter}
  width: 100%;
  flex-grow: 1;
`;

const Container = styled.div`
  display: flex;
  flex-direction: column;
  width: 200px;
  height: 417px;
  gap: 40px;
`;

const Top = styled.div`
  ${flexCenter}
  position: relative;
  width: 171px;
  height: 171px;
  margin: 0 auto;
`;

const ProgressCircle = styled.circle`
  animation: ${progressAni} 3s linear forwards;
`;

const IconBox = styled.div<{$ani: Keyframes}>`
  ${flexCenter}
  position: absolute;
  width: 106px;
  height: 106px;
  animation: ${({$ani}) => $ani} 1.5s forwards;
  animation-iteration-count: 2;
`;

const Middle = styled.div`
  ${Title1_Medium}
  font-size: 24px;
  width: 187px;
  margin: 0 auto;
  text-align: center;
  color: ${colors.Main_Hyundai_Blue};
`;
