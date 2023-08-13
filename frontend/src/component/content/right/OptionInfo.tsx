import React, {useCallback, useRef, useState} from 'react';
import styled from 'styled-components';
import OptionCardList from './OptionCardList';
import Modal from './optioninfo/Modal';
import Footer from './Footer';
import {flexCenter} from '../../../style/common';
import {colors} from '../../../style/theme';
import {Title1_Medium, Title3_Regular} from '@/style/fonts';
import {cardDataType} from '../contentInterface';

interface Data {
  optionId: number;
  name: string;
  rate: number;
  price: number;
}

interface cardDataProps {
  cardData: cardDataType[];
  option: number;
  setNewIndex: (index: number) => void;
}

function OptionInfo({cardData, setNewIndex, option}: cardDataProps) {
  const [isModalOpen, setIsModalOpen] = useState(false);

  const menuItems = [
    '파워트레인',
    '구동 방식',
    '바디 타입',
    '외장 색상',
    '내장 색상',
    '휠',
    '옵션',
  ];

  const modalRef = useRef<HTMLDivElement>(null);
  const handleModalView = useCallback(() => {
    setIsModalOpen((prev) => !prev);
  }, []);

  return (
    <Wrapper>
      <Container>
        <OptionTitle>{menuItems[option]}</OptionTitle>
        <Text>을 선택해주세요.</Text>
        <OptionCardList
          cardData={cardData}
          setNewIndex={setNewIndex}
        ></OptionCardList>
        <ModalWrapper ref={modalRef} $isopen={isModalOpen.toString()}>
          <Modal onClick={handleModalView}></Modal>
        </ModalWrapper>
        <Footer onClick={handleModalView} isOpen={isModalOpen}></Footer>
      </Container>
    </Wrapper>
  );
}

export default React.memo(OptionInfo);

const Wrapper = styled.div`
  ${flexCenter}
  flex: 4;
`;

const ModalWrapper = styled.div<{$isopen: string}>`
  position: absolute;
  top: 26px;
  width: 375px;
  height: 440px;
  margin-top: ${(props) => (props.$isopen === 'true' ? '0px' : '130%')};
  padding: 50px 0px;
  border-radius: 6px;
  border: 2px solid ${colors.Cool_Grey_001};
  background: #fff;
  box-shadow: 0px 4px 14px 0px rgba(104, 104, 104, 0.1);
  z-index: 2;
  transition: margin 0.5s;
`;

const Container = styled.div`
  position: relative;
  width: 375px;
  height: 565px;
  padding-top: 27px;
  overflow: hidden;
  &::before {
    content: '';
    position: absolute;
    bottom: 0;
    width: 100%;
    height: 284px;
    background: linear-gradient(
      180deg,
      rgba(255, 255, 255, 0) 38.32%,
      rgba(255, 255, 255, 0.53) 50.05%,
      #fff 75.57%
    );
    z-index: 3;
    pointer-events: none;
  }
`;

const OptionTitle = styled.span`
  ${Title1_Medium}
  font-size: 24px;
`;

const Text = styled.span`
  ${Title3_Regular}
  font-size: 24px;
`;