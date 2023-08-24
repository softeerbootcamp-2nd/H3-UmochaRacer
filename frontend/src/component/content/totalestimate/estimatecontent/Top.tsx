import React, {useContext, useState} from 'react';
import styled from 'styled-components';
import {flexCenter} from '@/style/common';
import {Title1_Medium, Title4_Regular} from '@/style/fonts';
import {colors} from '@/style/theme';
import {SelectedOptionContext} from '@/provider/selectedOptionProvider';

function Top() {
  const {selectedOptions} = useContext(SelectedOptionContext);
  const [imgsrc, setImgsrc] = useState(selectedOptions[3].imgSrc);
  const buttonClick = (url: string) => {
    setImgsrc(url);
  };

  return (
    <Wrapper>
      <Text>나를 위한 팰리세이드가 완성되었어요!</Text>
      <ImageBox>
        <img src={imgsrc}></img>
      </ImageBox>
      <ButtonBox>
        <ImageButton
          onClick={() => buttonClick(selectedOptions[3].imgSrc)}
          $background={colors.Main_Hyundai_Blue}
          $color={colors.Hyundai_White}
        >
          외부
        </ImageButton>
        <ImageButton
          onClick={() => buttonClick(selectedOptions[4].imgSrc)}
          $background={'#F2F2F2'}
          $color={colors.Main_Hyundai_Blue}
        >
          내부
        </ImageButton>
      </ButtonBox>
    </Wrapper>
  );
}

export default Top;

const Wrapper = styled.div`
  ${flexCenter}
  flex-direction: column;
  margin-top: 60px;
  gap: 10px;
`;

const Text = styled.div`
  ${Title1_Medium}
  text-align: center;
  font-size: 30px;
  line-height: 140%;
  width: 293px;
  height: 96px;
`;

const ImageBox = styled.div`
  height: 326px;
  img {
    height: 100%;
  }
`;

const ButtonBox = styled.div`
  display: inline-flex;
  align-items: flex-start;
  width: 184px;
  height: 37px;
`;

const ImageButton = styled.button<{$background: string; $color: string}>`
  ${flexCenter}
  ${Title4_Regular}
  width: 50%;
  height: 100%;
  padding: 8px 32px;
  color: ${({$color}) => $color};
  background: ${({$background}) => $background};
  gap: 10px;
`;
