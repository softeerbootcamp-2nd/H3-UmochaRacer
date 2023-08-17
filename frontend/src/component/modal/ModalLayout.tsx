import {flexCenter} from '@/style/common';
import React from 'react';
import styled from 'styled-components';
import Icon, {IconType} from '../common/icons';
import {colors} from '@/style/theme';
import {Body2_Medium, Popup_Regular, Title2_Medium} from '@/style/fonts';
import {useModalContext} from '@/provider/modalProvider';
interface ModalLayoutProps {
  iconName: string;
  title: string;
  description: string;
  progressText: string;
  closeText: string;
  imgSrc?: string;
  onClickLeft?: () => void;
  onClickRight?: () => void;
}
function ModalLayout({
  iconName,
  title,
  description,
  progressText,
  closeText,
  imgSrc,
  onClickLeft,
  onClickRight,
}: ModalLayoutProps) {
  const {closeModal} = useModalContext();
  const handleBtnRightClick = () => {
    if (onClickRight) {
      onClickRight();
    } else {
      closeModal();
    }
  };
  const handleBtnLeftClick = () => {
    if (onClickLeft) {
      onClickLeft();
    } else {
      closeModal();
    }
  };
  return (
    <Modal.Wrapper>
      <Modal.TitleWrapper>
        <Icon name={iconName as IconType} size={36} />
        <Modal.Title>{title}</Modal.Title>
      </Modal.TitleWrapper>
      <Modal.DescriptionWrapper>
        <Modal.Description>{description}</Modal.Description>
        {imgSrc && <Modal.DescriptionImg src={`/image/${imgSrc}.png`} />}
      </Modal.DescriptionWrapper>
      <Modal.ButtonWrapper>
        <Modal.ButtonProgress onClick={handleBtnLeftClick}>
          {progressText}
        </Modal.ButtonProgress>
        <Modal.ButtonClose onClick={handleBtnRightClick}>
          {closeText}
        </Modal.ButtonClose>
      </Modal.ButtonWrapper>
    </Modal.Wrapper>
  );
}
export default ModalLayout;
const Modal = {
  Wrapper: styled.div`
    ${flexCenter}
    flex-direction : column;
  `,
  TitleWrapper: styled.div`
    ${flexCenter};
    flex-direction: column;
    gap: 8px;
    margin-bottom: 12px;
  `,
  Title: styled.p`
    color: ${colors.Main_Hyundai_Blue};
    ${Title2_Medium};
  `,
  DescriptionWrapper: styled.div`
    ${flexCenter};
    gap: 12px;
    flex-direction: column;
    margin-bottom: 24px;
  `,
  Description: styled.p`
    color: ${colors.Main_Hyundai_Blue};
    text-align: center;
    ${Popup_Regular}
    white-space: pre-wrap;
  `,
  DescriptionImg: styled.img`
    width: 100%;
  `,
  ButtonWrapper: styled.div`
    ${flexCenter};
    gap: 8px;
  `,
  ButtonProgress: styled.div`
    ${flexCenter}
    width: 150px;
    height: 46px;
    border-radius: 6px;
    background: ${colors.Cool_Grey_001};
    gap: 10px;
    color: ${colors.Main_Hyundai_Blue};
    ${Body2_Medium};
    cursor: pointer;
  `,
  ButtonClose: styled.div`
    ${flexCenter}
    width: 150px;
    height: 46px;
    border-radius: 6px;
    background: ${colors.Main_Hyundai_Blue};
    gap: 10px;
    color: ${colors.Hyundai_White};
    ${Body2_Medium};
    cursor: pointer;
  `,
};
