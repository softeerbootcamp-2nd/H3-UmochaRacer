import React from 'react';
import ModalLayout from '../ModalLayout';
function SelfChangeModal() {
  const iconName = 'Change';
  const title = '[셀프 모드]로 변경하시겠어요?';
  const description = '지금까지 선택했던 옵션들이\n유지된 채로 변경됩니다.';
  const progressText = '안할래요';
  const closeText = '변경할래요!';
  const imgSrc = '';
  const onClickRight = () => {
    window.location.href = '/self';
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
export default SelfChangeModal;
