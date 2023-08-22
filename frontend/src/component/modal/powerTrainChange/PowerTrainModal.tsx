import React from 'react';
import ModalLayout from '../ModalLayout';
function PowerTrainModal() {
  const iconName = 'Change';
  const title = '[가솔린 3.8]으로 변경하시겠어요?';
  const description = '[듀얼 머플러 패키지]는 ‘디젤 2.2’ 만 선택 가능해요.';
  const progressText = '안할래요';
  const closeText = '변경할래요!';
  const imgSrc = 'powerTrainChange';
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
export default PowerTrainModal;
