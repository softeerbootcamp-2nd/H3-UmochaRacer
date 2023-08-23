import React, {useContext, useEffect, useState} from 'react';
import styled, {keyframes} from 'styled-components';
import {colors} from '@/style/theme';
import {Body3_Regular, Title2_Medium} from '@/style/fonts';
import {fetchData} from '@/api/fetchData';
import {OptionContext} from '@/provider/optionProvider';

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

const SmileIcon2 = () => {
  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="30"
      height="30"
      viewBox="0 0 24 25"
      fill="none"
    >
      <g clipPath="url(#clip0_601_18916)">
        <path
          d="M4.92901 19.4372C3.99904 18.5097 3.26154 17.4075 2.75889 16.194C2.25623 14.9805 1.99833 13.6797 2.00001 12.3662C2.00001 6.84321 6.47701 2.36621 12 2.36621C17.523 2.36621 22 6.84321 22 12.3662C22 17.8892 17.523 22.3662 12 22.3662H2.00001L4.92901 19.4372Z"
          fill="#FFA724"
        />
        <ellipse cx="10" cy="10.3662" rx="1" ry="1" fill="#0E2B5C" />
        <ellipse cx="14" cy="10.3662" rx="1" ry="1" fill="#0E2B5C" />
        <path
          d="M8.46447 15.9017C7.52678 14.9641 7 13.6923 7 12.3662H9C9 13.1619 9.31607 13.9249 9.87868 14.4875C10.4413 15.0501 11.2044 15.3662 12 15.3662C12.7956 15.3662 13.5587 15.0501 14.1213 14.4875C14.6839 13.9249 15 13.1619 15 12.3662H17C17 13.6923 16.4732 14.9641 15.5355 15.9017C14.5979 16.8394 13.3261 17.3662 12 17.3662C10.6739 17.3662 9.40215 16.8394 8.46447 15.9017Z"
          fill="#0E2B5C"
        />
      </g>
      <defs>
        <clipPath id="clip0_601_18916">
          <rect
            width="24"
            height="24"
            fill="white"
            transform="translate(0 0.366211)"
          />
        </clipPath>
      </defs>
    </svg>
  );
};

const GoodIcon = () => {
  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="26"
      height="33"
      viewBox="0 0 26 33"
      fill="none"
    >
      <path
        d="M2.83845 17.0006H5.98659V29.5931H2.83845C2.56013 29.5931 2.29322 29.4826 2.09642 29.2858C1.89962 29.089 1.78906 28.8221 1.78906 28.5438V18.0499C1.78906 17.7716 1.89962 17.5047 2.09642 17.3079C2.29322 17.1111 2.56013 17.0006 2.83845 17.0006ZM8.39283 15.6437L15.1089 8.92765C15.1981 8.83813 15.3167 8.78385 15.4428 8.77479C15.5689 8.76573 15.694 8.80249 15.7952 8.87833L16.6903 9.54993C16.9389 9.73656 17.1267 9.99262 17.2299 10.2858C17.3332 10.579 17.3474 10.8962 17.2706 11.1975L16.0607 15.9512H22.7767C23.3333 15.9512 23.8672 16.1723 24.2608 16.5659C24.6544 16.9595 24.8755 17.4933 24.8755 18.0499V20.2578C24.8758 20.5321 24.8223 20.8038 24.7181 21.0575L21.4702 28.9436C21.391 29.1358 21.2564 29.3002 21.0836 29.4159C20.9108 29.5315 20.7075 29.5932 20.4996 29.5931H9.13474C8.85643 29.5931 8.58951 29.4826 8.39272 29.2858C8.19592 29.089 8.08536 28.8221 8.08536 28.5438V16.3856C8.08542 16.1073 8.19602 15.8405 8.39283 15.6437Z"
        fill="#FFA724"
      />
      <rect
        x="7.03906"
        y="3.77734"
        width="2.51852"
        height="5.03704"
        transform="rotate(-30 7.03906 3.77734)"
        fill="#FFA724"
      />
      <rect x="14.5938" width="2.51852" height="5.03704" fill="#FFA724" />
      <rect
        width="2.51852"
        height="5.03704"
        transform="matrix(-0.866025 -0.5 -0.5 0.866025 25.25 3.77734)"
        fill="#FFA724"
      />
    </svg>
  );
};

interface Props {
  id: number;
}

interface FeedbackData {
  title: string;
  description: string;
}

const urlMap: Record<number, string> = {
  0: '/comment/powertrain',
  1: '/comment/driving-system',
  2: '/comment/bodytype',
  3: '/comment/exterior-color',
  4: '/comment/interior-color',
  5: '/comment/wheel',
};

function FeedBack({id}: Props) {
  const [comment, setComment] = useState<FeedbackData>({
    title: '',
    description: '',
  });

  const {option} = useContext(OptionContext);
  useEffect(() => {
    const getComment = async () => {
      const response = await fetchData(`${urlMap[option]}/${id}`);
      const feedbackDatas = response.comment.split('! ');
      const title = feedbackDatas[0];
      const description = feedbackDatas[1];

      setComment({title, description});
    };

    getComment();
  }, []);

  return (
    <Wrapper>
      <IconContainer>
        <IconBox>{SmileIcon()}</IconBox>
        <IconBox className="smile2">{SmileIcon2()}</IconBox>
        <IconBox className="good">{GoodIcon()}</IconBox>
      </IconContainer>
      <TitleBox>{comment.title}!</TitleBox>
      <Description>{comment.description}</Description>
    </Wrapper>
  );
}

export default FeedBack;

const opacityAni = keyframes`
0%{
    opacity: 0;
}
100%{
    opacity: 1;
}
`;

const moveOpacityAni = keyframes`
0%{
    opacity: 0;
    left: 0;
}
100%{
    opacity: 1;
    left: 100%;
}
`;
const Wrapper = styled.div`
  position: absolute;
  width: 375px;
  height: 154px;
  top: -2px;
  left: -2px;
  padding: 20px;
  border-radius: 6px;
  background: ${colors.Main_Hyundai_Blue};
  animation: ${opacityAni} 0.5s forwards;
`;

const IconContainer = styled.div`
  position: relative;
  width: 30px;
  height: 30px;

  div {
    transition: 0.5s;
  }

  .smile2 {
    opacity: 0;
    animation: ${opacityAni} 0.5s forwards;
    animation-delay: 0.5s;
  }

  .good {
    opacity: 0;
    top: -3px;
    animation: ${moveOpacityAni} 0.5s forwards;
    animation-delay: 0.5s;
  }
`;

const IconBox = styled.div`
  position: absolute;
  top: 0;
  left: 0;
`;

const TitleBox = styled.div`
  ${Title2_Medium}
  margin-top: 14px;
  color: ${colors.Hyundai_White};
`;

const Description = styled.div`
  ${Body3_Regular}
  margin-top: 8px;
  color: ${colors.Hyundai_White};
`;
