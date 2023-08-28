import React, {useContext} from 'react';
import styled from 'styled-components';
import Top from './estimatecontent/Top';
import Middle from './estimatecontent/Middle';
import Bottom from './estimatecontent/Bottom';
import Firework from './estimatecontent/FireWork';
import {colors} from '@/style/theme';
import {Body2_Medium} from '@/style/fonts';
import {SelectedOptionContext} from '@/provider/selectedOptionProvider';
import {SelectedAdditionalOptionsContext} from '@/provider/additionalOptionProvider';
interface ButtonLayout {
  text: string;
  background: string;
  color: string;
  border?: string;
}

const contents: ButtonLayout[] = [
  {
    text: '구매 상담 신청',
    color: colors.Hyundai_White,
    background: colors.Main_Hyundai_Blue,
  },
  {
    text: '시승 신청하기',
    color: '#000000',
    background: colors.Hyundai_White,
    border: '#000000',
  },
  {
    text: '공유하기',
    color: colors.Main_Hyundai_Blue,
    background: colors.Cool_Grey_001,
  },
  {
    text: '저장하기',
    color: colors.Main_Hyundai_Blue,
    background: colors.Cool_Grey_001,
  },
];

const DEFAULT_PRICE = 43460000;

function EstimateContent() {
  const {selectedOptions} = useContext(SelectedOptionContext);
  const {selectedAdditionalOption} = useContext(
    SelectedAdditionalOptionsContext,
  );
  let totalPrice = DEFAULT_PRICE;

  selectedOptions.forEach((elem) => {
    totalPrice += elem.price;
  });
  selectedAdditionalOption.forEach((elem) => {
    totalPrice += elem.price;
  });

  const buttons: React.JSX.Element[] = contents.map((elem, index) => {
    return (
      <Button
        key={index}
        $background={elem.background}
        $color={elem.color}
        $border={elem.border}
      >
        {elem.text}
      </Button>
    );
  });
  console.log(selectedAdditionalOption);
  return (
    <Wrapper>
      <Top></Top>
      <Firework number={10} width={266} height={480}></Firework>
      <Middle totalPrice={totalPrice}></Middle>
      <ButtonBox>{buttons}</ButtonBox>
      <Bottom totalPrice={totalPrice}></Bottom>
    </Wrapper>
  );
}

export default EstimateContent;

const Wrapper = styled.div`
  width: 100%;
  max-width: 1024px;
`;

const ButtonBox = styled.div`
  display: flex;
  justify-content: space-between;
  margin-top: 60px;
  width: 100%;
  button {
    ${Body2_Medium}
  }
`;

const Button = styled.button<{
  $background: string;
  $color: string;
  $border?: string;
}>`
  width: 244px;
  height: 57px;
  background: ${({$background}) => $background};
  color: ${({$color}) => $color};
  ${({$border}) => $border && `border: 1px solid ${$border}`};
  border-radius: 6px;
`;
