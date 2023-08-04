import React from 'react';
import styled from 'styled-components';
import {colors} from '../../../style/theme';

function OptionCardList() {
  return (
    <Wrapper>
      <Container>
        <OptionCard>
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="24"
            height="24"
            viewBox="0 0 24 24"
            fill="none"
          >
            <path
              d="M12 22C6.477 22 2 17.523 2 12C2 6.477 6.477 2 12 2C17.523 2 22 6.477 22 12C22 17.523 17.523 22 12 22ZM10.643 16.243L17.713 9.172L16.299 7.758L10.643 13.415L7.814 10.586L6.4 12L10.643 16.243Z"
              fill="#0E2B5C"
            />
          </svg>
          <Text1>구매자의 63%가 선택했어요!</Text1>
          <Text2>디젤 2.2</Text2>
        </OptionCard>
        <OptionCard>
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="24"
            height="24"
            viewBox="0 0 24 24"
            fill="none"
          >
            <path
              d="M12 22C6.477 22 2 17.523 2 12C2 6.477 6.477 2 12 2C17.523 2 22 6.477 22 12C22 17.523 17.523 22 12 22ZM12 20C14.1217 20 16.1566 19.1571 17.6569 17.6569C19.1571 16.1566 20 14.1217 20 12C20 9.87827 19.1571 7.84344 17.6569 6.34315C16.1566 4.84286 14.1217 4 12 4C9.87827 4 7.84344 4.84286 6.34315 6.34315C4.84286 7.84344 4 9.87827 4 12C4 14.1217 4.84286 16.1566 6.34315 17.6569C7.84344 19.1571 9.87827 20 12 20ZM10.5 16L6.257 11.757L7.671 10.343L10.5 13.172L16.156 7.515L17.571 8.929L10.5 16Z"
              fill="#AEB1B7"
            />
          </svg>
          <Text1>구매자의 37%가 선택했어요!</Text1>
          <Text2>가솔린 2.8</Text2>
        </OptionCard>
      </Container>
    </Wrapper>
  );
}

export default OptionCardList;

const Wrapper = styled.div`
  width: 100%;
  height: 370px;
  margin-top: 32px;
`;

const Container = styled.ul`
  display: inline-flex;
  flex-direction: column;
  align-items: flex-start;
  width: 100%;
  height: 100%;
  gap: 16px;
  overflow-y: scroll;
`;

const OptionCard = styled.div`
  display: flex;
  flex-direction: column;
  width: 100%;
  height: 150px;
  padding: 20px;
  border-radius: 6px;
  border: 2px solid ${colors.Main_Hyundai_Blue};
  gap: 10px;
`;

const Text1 = styled.div`
  font-family: Body3_Regular;
  font-size: 12px;
  color: ${colors.Main_Hyundai_Blue};
`;

const Text2 = styled.div`
  font-family: Title2_Medium;
  font-size: 20px;
  color: ${colors.Cool_Grey};
`;
