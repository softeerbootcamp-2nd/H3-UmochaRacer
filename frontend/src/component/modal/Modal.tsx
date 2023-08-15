import React, {useEffect} from 'react';
import {useModalContext, ModalType} from '@/provider/modalProvider';
import styled from 'styled-components';
import {flexCenter} from '@/style/common';
import {colors} from '@/style/theme';
import ExitModal from './exit/ExitModal';
import ModelChangeModal from './modelChange/ModelChangeModal';
import PowerTrainModal from './powerTrainChange/PowerTrainModal';
import SelfChangeModal from './modeChange/SelfChangeModal';
import GuideChangeModal from './modeChange/GuideChangeModal';

type NonNullableModalType = Exclude<ModalType, null>;
const ModalContent: Record<NonNullableModalType, React.FC> = {
  exit: () => <ExitModal />,
  model_change: () => <ModelChangeModal />,
  powertrain_change: () => <PowerTrainModal />,
  type_change: () => <div>타입 바꾸는 모달</div>,
  mode_to_self: () => <SelfChangeModal />,
  mode_to_guide: () => <GuideChangeModal />,
};
function Modal() {
  const {isVisible, activeModal, closeModal} = useModalContext();

  useEffect(() => {
    const handlePopState = () => {
      closeModal();
    };

    window.addEventListener('popstate', handlePopState);

    return () => {
      window.removeEventListener('popstate', handlePopState);
    };
  }, [closeModal]);
  if (!isVisible || !activeModal) return null;

  const ContentComponent = ModalContent[activeModal] ?? (() => null);
  const handleWrapperClick = (e: React.MouseEvent) => {
    e.stopPropagation();
  };
  return (
    <>
      <Background />
      <Wrapper onClick={closeModal}>
        <M.Wrapper onClick={handleWrapperClick}>
          <ContentComponent />
        </M.Wrapper>
      </Wrapper>
    </>
  );
}

export default Modal;
const Wrapper = styled.div`
  width: 100vw;
  height: 100vh;
  position: fixed; // 위치를 fixed로 변경
  top: 0;
  left: 0;
  z-index: 99999; // z-index를 높게 설정
  ${flexCenter}
`;

const M = {
  Wrapper: styled.div`
    width: 343px;
    border-radius: 6px;
    box-shadow: 0px 4px 12px 0px rgba(0, 0, 0, 0.3);
    background: ${colors.Hyundai_White};
    opacity: 1;
    ${flexCenter}
    padding : 26px 18px 18px 18px;
  `,
};

const Background = styled.div`
  width: 100vw;
  height: 100vh;
  background: rgba(0, 0, 0, 0.8);
  position: fixed;
  top: 0;
  left: 0;
  z-index: 99998;
`;
