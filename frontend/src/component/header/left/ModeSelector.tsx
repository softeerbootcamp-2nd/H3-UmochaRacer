import React from 'react';
import styled from 'styled-components';
import {colors} from '@/style/theme';
import selector from '@/assets/icons/selector.svg';
import {Title3_Medium} from '@/style/fonts';
import {useModalContext} from '@/provider/modalProvider';
import {getTitleByPath} from '@/component/util/getTitleByPath';

function ModeSelector() {
  const {openModal} = useModalContext();
  const currentTitle = getTitleByPath(window.location.pathname);

  const getTitleContent = (title: string) => {
    switch (title) {
      case 'none':
        return '';
      case 'self':
        return '내 차 만들기 - 셀프 모드';
      case 'guide':
        return '내 차 만들기 - 가이드 모드';
      default:
        return title;
    }
  };

  return (
    <Wrapper onClick={() => openModal('mode_change')}>
      <ModeName $isGuide={window.location.pathname === '/guide'}>
        {getTitleContent(currentTitle)}
      </ModeName>
      {currentTitle !== 'none' && (
        <ModeSelect
          $isGuide={window.location.pathname === '/guide'}
          src={selector}
        />
      )}
    </Wrapper>
  );
}

export default ModeSelector;
const Wrapper = styled.div`
  display: flex;
  cursor: pointer;
`;
const ModeName = styled.p<{$isGuide: boolean}>`
  ${Title3_Medium};
  color: ${({$isGuide}) =>
    $isGuide ? colors.Sub_Active_Blue : colors.Cool_Grey};
`;
const ModeSelect = styled.img<{$isGuide: boolean}>`
  ${({$isGuide}) =>
    $isGuide &&
    'filter: invert(74%) sepia(11%) saturate(4376%) hue-rotate(167deg) brightness(87%) contrast(83%);'}
`;
