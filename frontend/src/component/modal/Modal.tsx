import React, {useEffect} from 'react';
import {useModalContext, ModalType} from '@/provider/modalProvider';
import styled from 'styled-components';
import {flexCenter} from '@/style/common';

interface ModalProps {}
type NonNullableModalType = Exclude<ModalType, null>;
type ButtonTextType = {
  [key in NonNullableModalType]?: {
    activate: string;
    deactivate: string;
  };
};
const ModalContent: Record<NonNullableModalType, React.FC> = {
  exit: () => <div>나가기 모달</div>,
  model_change: () => <div>모델 바꾸는 모달</div>,
  powertrain_change: () => <div>파워트레인 바꾸는 모달</div>,
  type_change: () => <div>타입 바꾸는 모달</div>,
  mode_to_self: () => <div>셀프모드로 바꾸는 모달</div>,
  mode_to_guide: () => <div>가이듣모드로 바꾸는 모달</div>,
};
const ButtonText: ButtonTextType = {
  exit: {
    activate: '나갈래요',
    deactivate: '나가지 않을래요!',
  },
};
const Modal: React.FC<ModalProps> = () => {
  const {isVisible, activeModal, closeModal} = useModalContext(); // 현재 위치를 가져옵니다.

  useEffect(() => {
    const handlePopState = () => {
      closeModal();
    };

    // popstate 이벤트를 감지하여 모달을 닫습니다.
    window.addEventListener('popstate', handlePopState);

    return () => {
      window.removeEventListener('popstate', handlePopState);
    };
  }, [closeModal]);
  if (!isVisible || !activeModal) return null;

  const ContentComponent = ModalContent[activeModal] ?? (() => null);
  const deActiveText = ButtonText[activeModal]?.deactivate ?? '';
  const handleWrapperClick = (e: React.MouseEvent) => {
    e.stopPropagation();
  };
  return (
    <>
      <Background />
      <Wrapper onClick={closeModal}>
        <M.Wrapper onClick={handleWrapperClick}>
          <button onClick={closeModal}>{deActiveText}</button>
        </M.Wrapper>
      </Wrapper>
    </>
  );
};

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
    width: 200px;
    height: 300px;
    background: #fff;
    opacity: 1;
    ${flexCenter}
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
