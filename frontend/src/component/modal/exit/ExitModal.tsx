import React from 'react';
import ModalLayout from '../ModalLayout';
function ExitModal() {
  const iconName = 'Sad';
  const title = '내 차 만들기에서 나가시겠어요?';
  const description =
    '완료까지 얼마 남지 않았어요!\n지금 종료하면 선택사항은 저장되지 않아요.';
  const progressText = '나갈래요';
  const closeText = '나가지 않을래요!';
  const imgSrc = '';
  const onClickLeft = () => {
    window.location.href = '/';
  };
  return (
    <ModalLayout
      iconName={iconName}
      title={title}
      description={description}
      progressText={progressText}
      closeText={closeText}
      imgSrc={imgSrc}
      onClickLeft={onClickLeft}
    />
  );
}
export default ExitModal;
