import React, {useContext} from 'react';
import styled from 'styled-components';
import {colors} from '@/style/theme';
import {Title2_Medium, Title3_Medium} from '@/style/fonts';
import {SelectedOptionContext} from '@/provider/selectedOptionProvider';
import EstimateList from '@/component/common/EstimateList';
import {TempOptionContext} from '@/provider/tempOptionProvider';

interface props {
  onClick: () => void;
}

const IconClose = () => {
  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="24"
      height="24"
      viewBox="0 0 24 24"
      fill="none"
    >
      <path
        d="M12 10.586L16.95 5.636L18.364 7.05L13.414 12L18.364 16.95L16.95 18.364L12 13.414L7.04999 18.364L5.63599 16.95L10.586 12L5.63599 7.05L7.04999 5.636L12 10.586Z"
        fill="#AEB1B7"
      />
    </svg>
  );
};

const DEFAULT_PRICE = 43460000;

const headerLayout = {
  height: 38,
  fontSize: 16,
};

const selectionLayout = {
  flexWidth: 215,
  gap: 12,
  fontSize: 14,
};

function Modal({onClick}: props) {
  const {selectedOptions} = useContext(SelectedOptionContext);
  const {tempOption} = useContext(TempOptionContext);

  let totalPrice = DEFAULT_PRICE;
  let copyOption = selectedOptions.slice();

  if (tempOption !== null) {
    copyOption = copyOption.map((elem) => {
      if (elem.key === tempOption.key) {
        return tempOption;
      } else {
        return elem;
      }
    });
  }
  copyOption.map((elem) => {
    totalPrice += elem.price;
  });

  return (
    <>
      <IconBox onClick={onClick}>{IconClose()}</IconBox>
      <Title>
        <SummaryText>견적요약</SummaryText>
        <SummaryPrice>{totalPrice.toLocaleString()}원</SummaryPrice>
      </Title>
      <Container>
        <EstimateList
          gap={36}
          sidePadding={20}
          headerLayout={headerLayout}
          selectionLayout={selectionLayout}
        ></EstimateList>
      </Container>
    </>
  );
}

export default Modal;

const Title = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 26px;
  padding: 0px 20px;
`;

const SummaryText = styled.div`
  ${Title3_Medium}
  color: ${colors.Cool_Grey}
`;

const SummaryPrice = styled.div`
  ${Title2_Medium}
  color: ${colors.Main_Hyundai_Blue}
`;

const IconBox = styled.button`
  position: absolute;
  top: 16px;
  right: 16px;
  width: 24px;
  height: 24px;
  flex-shrink: 0;
`;

const Container = styled.div`
  &::-webkit-scrollbar {
    display: none;
  }

  margin-top: 36px;
  height: 274px;
  overflow-y: scroll;
`;

// const EstimateList = styled.ul`
//   display: inline-flex;
//   flex-direction: column;
//   align-items: center;
//   width: 100%;
//   gap: 36px;
//   flex-shrink: 0;
// `;
