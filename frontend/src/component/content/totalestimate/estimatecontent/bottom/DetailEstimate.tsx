import React, {useContext} from 'react';
import styled from 'styled-components';
import {OptionContext} from '@/provider/optionProvider';
import {Option} from '@/provider/selectedOptionProvider';

import {
  Title1_Medium,
  Title2_Medium,
  Title3_Medium,
  Title3_Regular,
} from '@/style/fonts';
import {colors} from '@/style/theme';
import {flexCenter} from '@/style/common';
import DetailBox from '@/component/common/DetilBox';

interface Props {
  detailOpen: boolean;
  optionIndex: number;
  option: Option;
}

const EditIcon = () => {
  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="20"
      height="20"
      viewBox="0 0 20 20"
      fill="none"
    >
      <path
        d="M5.345 13.3337L13.7967 4.88206L12.6183 3.70373L4.16667 12.1554V13.3337H5.345ZM6.03583 15.0004H2.5V11.4646L12.0292 1.9354C12.1854 1.77917 12.3974 1.69141 12.6183 1.69141C12.8393 1.69141 13.0512 1.77917 13.2075 1.9354L15.565 4.2929C15.7212 4.44917 15.809 4.66109 15.809 4.88206C15.809 5.10303 15.7212 5.31496 15.565 5.47123L6.03583 15.0004ZM2.5 16.6671H17.5V18.3337H2.5V16.6671Z"
        fill="#4CA7CE"
      />
    </svg>
  );
};

function DetailEstimate({detailOpen, optionIndex, option}: Props) {
  const {setOption} = useContext(OptionContext);

  const handleButtonClick = () => {
    setOption(optionIndex);
  };

  return (
    <Wrapper>
      <Header>
        <LeftText>{option.key}</LeftText>
        <RightPrice>{option.price.toLocaleString()}원</RightPrice>
      </Header>
      <DetailContent>
        <ImageBox $src={option.imgSrc}></ImageBox>
        <ContentBox>
          <ContentLeft>
            {option.value}
            <DeatailBoxWrapper>
              {/* <DetailBox isOpen={detailOpen} id={1}></DetailBox> */}
            </DeatailBoxWrapper>
          </ContentLeft>
          <ContentRight>
            {`+ ${option.price.toLocaleString()}원`}
            <EditButton onClick={handleButtonClick}>
              <IconBox>{EditIcon()}</IconBox>
              수정
            </EditButton>
          </ContentRight>
        </ContentBox>
      </DetailContent>
    </Wrapper>
  );
}

export default DetailEstimate;

const Wrapper = styled.li`
  width: 100%;
`;

const Header = styled.div`
  display: flex;
  justify-content: space-between;
  width: 100%;
  height: 31px;
  div {
    ${Title1_Medium}
    font-size: 24px;
  }
`;

const LeftText = styled.div``;

const RightPrice = styled.div``;

const DetailContent = styled.div`
  display: flex;
  margin-top: 16px;
  border-top: 1px solid ${colors.Cool_Grey_003};
`;

const ImageBox = styled.div<{$src: string}>`
  width: 194px;
  height: 144px;
  background: url(${({$src}) => $src}) no-repeat;
  background-size: cover;
  background-position: center;
`;

const ContentBox = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex: auto;
  padding-left: 43px;
`;

const ContentLeft = styled.div`
  ${Title2_Medium}
`;

const ContentRight = styled.div`
  ${Title3_Regular}
  position: relative;
  font-size: 20px;
`;

const IconBox = styled.div`
  ${flexCenter}
  height: 23px;
`;

const EditButton = styled.button`
  ${Title3_Medium}
  display: flex;
  position: absolute;
  top: 100%;
  right: 0;
  margin-top: 8px;
  width: 56px;
  color: ${colors.Sub_Active_Blue};
  gap: 6px;
`;

const DeatailBoxWrapper = styled.div`
  position: absolute;
`;
