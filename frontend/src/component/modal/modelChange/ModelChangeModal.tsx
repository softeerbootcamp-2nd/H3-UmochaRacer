import React from 'react';
import ModalLayout from '../ModalLayout';
function ModelChangeModal() {
  const iconName = 'Change';
  const title = '모델을 변경하시겠어요?';
  const description =
    '모델을 변경하면 선택할 수 있는 옵션이 바뀌어요!\n지금 변경하면 선택사항은 저장되지 않아요.';
  const progressText = '변경할래요!';
  const closeText = '안할래요';
  const imgSrc = '';
  return (
    <ModalLayout
      iconName={iconName}
      title={title}
      description={description}
      progressText={progressText}
      closeText={closeText}
      imgSrc={imgSrc}
    />
  );
}
export default ModelChangeModal;
