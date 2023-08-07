import React from 'react';
import styled from 'styled-components';
import {colors} from '@/style/theme';
import selector from '@/assets/icons/selector.svg';
import {Title3_Medium} from '@/style/fonts';
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
  cursor: pointer;
`;
const ModeName = styled.p`
  ${Title3_Medium};
  color: ${colors.Cool_Grey};
`;
const ModeSelect = styled.img``;
