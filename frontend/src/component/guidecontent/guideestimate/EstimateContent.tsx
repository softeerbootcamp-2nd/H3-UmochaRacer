import React, {useContext, useEffect} from 'react';
import styled from 'styled-components';
import Firework from '@/component/content/totalestimate/estimatecontent/FireWork';
import {colors} from '@/style/theme';
import {
  Body1_Medium,
  Body1_Regular,
  Body2_Regular,
  Title1_Medium,
  Title2_Medium,
} from '@/style/fonts';
import {flexCenter} from '@/style/common';
import {GUIDE_TOGGLE, useGuideFlowDispatch} from '@/provider/guideFlowProvider';
import {OptionContext} from '@/provider/optionProvider';
import {SelectedOptionContext} from '@/provider/selectedOptionProvider';
interface ButtonData {
  text: string;
  background: string;
  color: string;
}
const buttonDatas: ButtonData[] = [
  {
    text: '완성된 견적을 바로 볼게요',
    background: colors.Main_Hyundai_Blue,
    color: colors.Hyundai_White,
  },
  {
    text: '옵션을 하나씩 살펴볼래요',
    background: '#F3F3F3',
    color: colors.Main_Hyundai_Blue,
  },
];

const TOP_HEIGHT: number = 309;
const TOP_WIDTH: number = 180;

function EstimateContent() {
  const dispatch = useGuideFlowDispatch();
  const {setOption} = useContext(OptionContext);

  const handleClickButton = (index: number) => {
    if (!index) {
      setOption(7);
    }
    dispatch({type: GUIDE_TOGGLE});
  };
  const {selectedOptions} = useContext(SelectedOptionContext);
  const buttons = buttonDatas.map((elem: ButtonData, index: number) => {
    return (
      <Bottom.Button
        key={index}
        $background={elem.background}
        $color={elem.color}
        onClick={() => {
          handleClickButton(index);
        }}
      >
        {elem.text}
      </Bottom.Button>
    );
  });

  return (
    <Wrapper>
      <Top.Container>
        <Top.Image src={selectedOptions[3].imgSrc}></Top.Image>
      </Top.Container>
      <Firework number={10} width={TOP_WIDTH} height={TOP_HEIGHT}></Firework>
      <Comment.Container>나만의 팰리세이드 견적 준비 완료!</Comment.Container>
      <SelectTrim.Container>
        <SelectTrim.Box>
          <SelectTrim.Text>선택된 트림</SelectTrim.Text>
          <SelectTrim.Trim>팰리세이드 Le Blanc (르블랑)</SelectTrim.Trim>
        </SelectTrim.Box>
      </SelectTrim.Container>
      <InfoText.Container>
        준비된 견적을 바로 확인하거나,
        <br></br>
        옵션을 차례로 살펴보며 변경할 수 있어요.
      </InfoText.Container>
      <Bottom.Container>{buttons}</Bottom.Container>
    </Wrapper>
  );
}

export default EstimateContent;

const Wrapper = styled.div`
  width: 100%;
  max-width: 1024px;
`;

const Top = {
  Container: styled.div`
    ${flexCenter}
    margin: 0 auto;
    width: 688.848px;
    height: 309px;
  `,

  Image: styled.img`
    width: 100%;
    height: 100%;
    object-fit: cover;
  `,
};

const Comment = {
  Container: styled.div`
    ${Title1_Medium}
    font-size: 32px;
    line-height: 140%;
    width: 100%;
    text-align: center;
  `,
};

const SelectTrim = {
  Container: styled.div`
    ${flexCenter}
    width: 100%;
    margin-top: 18px;
  `,
  Box: styled.div`
    ${flexCenter}
    flex-direction: column;
    width: 300px;
    height: 86px;
    border-radius: 6px;
    background: #f8f8f8;
  `,
  Text: styled.div`
    ${Body2_Regular}
    color: #737373;
  `,
  Trim: styled.div`
    ${Title2_Medium}
  `,
};

const InfoText = {
  Container: styled.div`
    ${Body1_Regular}
    margin-top: 16px;
    color: #737373;
    text-align: center;
  `,
};

const Bottom = {
  Container: styled.div`
    display: flex;
    justify-content: center;
    margin-top: 18px;
    width: 100%;
    gap: 12px;
    button {
      ${Body1_Medium}
    }
  `,
  Button: styled.button<{
    $background: string;
    $color: string;
  }>`
    width: 343px;
    height: 55px;
    background: ${({$background}) => $background};
    color: ${({$color}) => $color};
    border-radius: 6px;
  `,
};
