import React from 'react';
import ModalLayout from '../ModalLayout';
function GuideChangeModal() {
  const iconName = 'Change';
  const title = '[가이드 모드]로 변경하시겠어요?';
  const description = '변경하면 지금까지 선택했던 옵션들은\n저장되지 않아요.';
  const progressText = '안할래요';
  const closeText = '변경할래요!';
  const imgSrc = '';
  const onClickRight = () => {
    window.location.href = '/guide';
  };
  return (
    <ModalLayout
      iconName={iconName}
      title={title}
      description={description}
      progressText={progressText}
      closeText={closeText}
      imgSrc={imgSrc}
      onClickRight={onClickRight}
    />
  );
}
export default GuideChangeModal;
