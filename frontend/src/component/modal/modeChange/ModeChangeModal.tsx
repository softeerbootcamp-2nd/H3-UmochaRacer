import Icon from '@/component/common/icons';
import {getTitleByPath} from '@/component/util/getTitleByPath';
import {useModalContext} from '@/provider/modalProvider';
import {flexCenter} from '@/style/common';
import {Label2_Regular, Title2_Medium, Title5_Medium} from '@/style/fonts';
import {colors} from '@/style/theme';
import React from 'react';
import styled from 'styled-components';
function ModeChangeModal() {
  const {openModal, closeModal} = useModalContext();
  const isProgress = getTitleByPath(window.location.pathname);
  const handleSelfModeClick = () => {
    if (isProgress === 'self') {
      closeModal();
    } else {
      openModal('mode_to_self');
    }
  };

  const handleGuideModeClick = () => {
    if (isProgress === 'guide') {
      closeModal();
    } else {
      openModal('mode_to_guide');
    }
  };
  return (
    <Modal.Wrapper>
      <Modal.TitleWrapper>
        <Icon name="Fix" size={36} />
        <Modal.Title>내 차 만들기 방식 변경하기</Modal.Title>
      </Modal.TitleWrapper>
      <Modal.ModeWrapper>
        <Modal.Mode onClick={handleSelfModeClick}>
          <Modal.NameWrapper>
            <Modal.Name>셀프 모드</Modal.Name>
            {isProgress === 'self' && (
              <Modal.Progress>현재 진행중</Modal.Progress>
            )}
          </Modal.NameWrapper>
          <Modal.Description>
            가장 일반적으로 많은 사람들이 선택한
            <br />
            인기있는 옵션들을 보며 내 취향에 맞게 자유롭게
            <br />
            옵션을 선택할 수 있어요.
          </Modal.Description>
          <Icon name="ArrowRight" size={20} />
        </Modal.Mode>
        <Modal.Mode onClick={handleGuideModeClick}>
          <Modal.NameWrapper>
            <Modal.Name>가이드 모드</Modal.Name>
            {isProgress === 'guide' && (
              <Modal.Progress>현재 진행중</Modal.Progress>
            )}
          </Modal.NameWrapper>
          <Modal.Description>
            내 상황과 성향에 맞는 옵션들을 추천받아
            <br />
            나에게 딱 맞는 옵션들로 구성된 차량 견적을
            <br />
            받아볼 수 있어요. 옵션을 선택할 수 있어요.
          </Modal.Description>
          <Icon name="ArrowRight" size={20} />
        </Modal.Mode>
      </Modal.ModeWrapper>
    </Modal.Wrapper>
  );
}
export default ModeChangeModal;

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
  ModeWrapper: styled.div`
    display: flex;
    gap: 8px;
    flex-direction: column;
  `,
  Mode: styled.div`
    padding: 18px 18px 24px 18px;
    width: 301px;
    height: 116px;
    border-radius: 6px;
    border: 1px solid black;
    display: flex;
    gap: 8px;
    flex-direction: column;
    position: relative;
    svg {
      position: absolute;
      right: 0;
      top: 40%;
    }
    &:hover {
      background-color: ${colors.Sub_Active_Blue};
      border: none;
      p,
      div {
        color: white;
        opacity: 1;
      }
      svg {
        fill: white;
      }
    }
    cursor: pointer;
  `,
  NameWrapper: styled.div`
    display: flex;
    gap: 8px;
  `,
  Name: styled.p`
    ${Title5_Medium};
    color: #000;
  `,
  Progress: styled.div`
    width: 54px;
    height: 16px;
    border-radius: 2px;
    background: ${colors.Hyundai_Sky_Blue};
    color: ${colors.Main_Hyundai_Blue};
    font-family: 'Hyundai Sans Text Medium';
    font-size: 10px;
    font-style: normal;
    font-weight: 500;
    line-height: 130%;
    letter-spacing: -0.3px;
    ${flexCenter};
  `,
  Description: styled.p`
    color: #000;
    ${Label2_Regular};
    opacity: 0.5;
  `,
};
