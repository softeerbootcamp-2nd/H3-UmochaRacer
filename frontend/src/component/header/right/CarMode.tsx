import React from 'react';
import styled from 'styled-components';
import {flexCenter} from '@/style/common';
import car from '@/assets/icons/car.svg';
import selector from '@/assets/icons/selector.svg';
import {colors} from '@/style/theme';
import {Title5_Regular} from '@/style/fonts';
import {useModalContext} from '@/provider/modalProvider';
function CarMode() {
  const {openModal} = useModalContext();
  const handleClickMode = () => {
    if (window.location.pathname !== '/') {
      openModal('model_change');
    }
  };
  return (
    <Wrapper onClick={() => handleClickMode()}>
      <CLogo src={car}></CLogo>
      <CarWrapper>
        <CarP>팰리세이드</CarP>
        <CarSelect src={selector} />
      </CarWrapper>
    </Wrapper>
  );
}

export default CarMode;
const Wrapper = styled.div`
  ${flexCenter}
  gap : 4px;
  cursor: pointer;
`;

const CLogo = styled.img``;

const CarWrapper = styled.div`
  display: flex;
`;
const CarSelect = styled.img``;
const CarP = styled.p`
  ${Title5_Regular};
  color: ${colors.Cool_Grey};
`;
