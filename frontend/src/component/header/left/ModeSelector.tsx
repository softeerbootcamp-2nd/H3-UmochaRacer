import React from 'react';
import styled from 'styled-components';
import {colors} from '../../../style/theme';
import selector from '../../../assets/icons/selector.svg';
function ModeSelector() {
  return (
    <Wrapper>
      <ModeName>내 차 만들기 - 셀프 모드</ModeName>
      <ModeSelect src={selector} />
    </Wrapper>
  );
}

export default ModeSelector;
const Wrapper = styled.div`
  display: flex;
`;
const ModeName = styled.p`
  font-family: 'Title3_Medium';
  color: ${colors.Cool_Grey};
`;
const ModeSelect = styled.img``;
