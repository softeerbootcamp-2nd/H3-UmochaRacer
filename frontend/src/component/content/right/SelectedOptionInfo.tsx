import React, {
  useCallback,
  useContext,
  useEffect,
  useRef,
  useState,
} from 'react';
import styled from 'styled-components';
import Modal from './optioninfo/Modal';
import Footer from './Footer';
import {flexBetween, flexCenter} from '../../../style/common';
import {colors} from '../../../style/theme';
import {Body2_Medium, Title1_Medium, Title3_Regular} from '@/style/fonts';
import {cardDataType} from '../contentInterface';
import {OptionContext} from '@/provider/optionProvider';
import SelectedOptionCardList from './SelectedOptionCardList';
import CardbModal from '@/component/common/CardbModal';

interface cardDataProps {
  cardData: cardDataType[];
  setNewIndex: (index: number) => void;
  selectedIndex: number;
  setCategory: (index: number) => void;
  selectedCategory: number;
}

function SelectedOptionInfo({
  cardData,
  setNewIndex,
  selectedIndex,
  setCategory,
  selectedCategory,
}: cardDataProps) {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [isSaved, setIsSaved] = useState(false);
  const {option} = useContext(OptionContext);
  const modalRef = useRef<HTMLDivElement>(null);
  const handleModalView = useCallback(() => {
    setIsModalOpen((prev) => !prev);
  }, []);

  useEffect(() => {
    setIsSaved(false);
  }, [option]);
  const categories = ['시스템', '온도관리', '외부장치', '내부장치'];
  const handleCategoryClick = (idx: number) => {
    setCategory(idx);
    setNewIndex(0);
  };
  return (
    <Wrapper>
      <Category.Wrapper>
        {categories.map((category, idx) => (
          <Category.Button
            key={idx}
            $isSelected={idx === selectedCategory}
            onClick={() => handleCategoryClick(idx)}
          >
            <Category.ButtonP $isSelected={idx === selectedCategory}>
              {category}
            </Category.ButtonP>
          </Category.Button>
        ))}
      </Category.Wrapper>
      <Container>
        <OptionTitle>옵션</OptionTitle>
        <Text>을 선택해주세요.</Text>
        <SelectedOptionCardList
          cardData={cardData}
          isSaved={isSaved}
          setNewIndex={setNewIndex}
          selectedIndex={selectedIndex}
          categoryIdx={selectedCategory}
        ></SelectedOptionCardList>
        <ModalWrapper ref={modalRef} $isopen={isModalOpen.toString()}>
          <Modal onClick={handleModalView}></Modal>
        </ModalWrapper>
        <Footer
          onClick={handleModalView}
          setIsSaved={setIsSaved}
          isOpen={isModalOpen}
        ></Footer>
        <CardbModal />
      </Container>
    </Wrapper>
  );
}

export default SelectedOptionInfo;

const Wrapper = styled.div`
  ${flexCenter};
  flex: 4;
  flex-direction: column;
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

const Category = {
  Wrapper: styled.div`
    width: 375px;
    ${flexBetween};
    gap: 8px;
  `,
  Button: styled.div<{$isSelected: boolean}>`
    ${flexCenter}
    padding: 6px 20px;
    border-radius: 6px;
    cursor: pointer;
    background: ${(props) =>
      props.$isSelected ? colors.Main_Hyundai_Blue : colors.Cool_Grey_001};
  `,
  ButtonP: styled.p<{$isSelected: boolean}>`
    color: ${(props) =>
      props.$isSelected ? colors.Hyundai_White : colors.Cool_Grey_003};
    ${Body2_Medium};
  `,
};
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
