import React, {
  useCallback,
  useContext,
  useEffect,
  useRef,
  useState,
} from 'react';
import styled from 'styled-components';
import OptionCardList from './OptionCardList';
import Modal from './optioninfo/Modal';
import Footer from './Footer';
import CardbModal from '@/component/common/CardbModal';
import {flexCenter} from '../../../style/common';
import {colors} from '../../../style/theme';
import {Title1_Medium, Title3_Regular} from '@/style/fonts';
import {cardDataType} from '../contentInterface';
import {OptionContext} from '@/provider/optionProvider';
import {textParse} from '@/component/common/textParse';

interface cardDataProps {
  cardData: cardDataType[];
  setNewIndex: (index: number) => void;
  selectedIndex: number;
}

function OptionInfo({cardData, setNewIndex, selectedIndex}: cardDataProps) {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [isSaved, setIsSaved] = useState(false);
  const {option} = useContext(OptionContext);
  const menuItems = [
    '<cardb>파워트레인</cardb>',
    '<cardb>구동방식</cardb>',
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

  useEffect(() => {
    setIsSaved(false);
  }, [option]);

  return (
    <Wrapper>
      <Container>
        <OptionTitle>{textParse(menuItems[option])}</OptionTitle>
        <Text>을 선택해주세요.</Text>
        <OptionCardList
          cardData={cardData}
          isSaved={isSaved}
          setNewIndex={setNewIndex}
          selectedIndex={selectedIndex}
        ></OptionCardList>
        <ModalWrapper ref={modalRef} $isopen={isModalOpen.toString()}>
          <Modal onClick={handleModalView}></Modal>
        </ModalWrapper>
        <Footer
          onClick={handleModalView}
          setIsSaved={setIsSaved}
          isOpen={isModalOpen}
        ></Footer>
        <CardbModal></CardbModal>
      </Container>
    </Wrapper>
  );
}

export default OptionInfo;

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

const OptionTitle = styled.div`
  ${Title1_Medium}
  display: inline-block;
  font-size: 24px;
`;

const Text = styled.span`
  ${Title3_Regular}
  font-size: 24px;
`;
