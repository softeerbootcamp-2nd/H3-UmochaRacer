import React from 'react';
import styled from 'styled-components';
import {colors} from '@/style/theme';
import selector from '@/assets/icons/selector.svg';
import {Title3_Medium} from '@/style/fonts';
import {useModalContext} from '@/provider/modalProvider';
function getTitleByPath(path: string) {
  switch (path) {
    case '/self':
      return '내 차 만들기 - 셀프모드';
    case '/guide':
      return '내 차 만들기 - 가이드모드';
    default:
      return '내 차 만들기';
  }
}
function ModeSelector() {
  const {openModal} = useModalContext();
  const currentTitle = getTitleByPath(window.location.pathname);
  const handleWrapperClick = () => {
    if (currentTitle === '내 차 만들기 - 셀프모드') {
      openModal('mode_to_guide');
    } else if (currentTitle === '내 차 만들기 - 가이드모드') {
      openModal('mode_to_self');
    }
  };
  return (
    <Wrapper onClick={handleWrapperClick}>
      <ModeName>{currentTitle}</ModeName>
      {currentTitle !== '내 차 만들기' && <ModeSelect src={selector} />}
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
