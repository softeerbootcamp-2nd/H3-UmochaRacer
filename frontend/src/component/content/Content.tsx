import React, {useContext, useEffect, useState} from 'react';
import styled from 'styled-components';
import OptionImage from './left/OptionImage';
import OptionInfo from './right/OptionInfo';
import TotalEstimate from './totalestimate/TotalEstimate';

import {OptionContext} from '@/provider/optionProvider';
import useFetch from '../hooks/useFetch';
import {TempOptionContext} from '@/provider/tempOptionProvider';
import {SelectedOptionContext} from '@/provider/selectedOptionProvider';
import {flexCenter} from '@/style/common';
type cardData = {
  id: number;
  name: string;
  imageSrc: string;
  price: number;
};
type OptionUrls = Record<number, string>;
interface Option {
  key: string;
  value: string;
  category: string;
  price: number;
  id: number;
  imgSrc: string;
}
const keyMapping: Record<number, string> = {
  0: '파워트레인',
  1: '구동 방식',
  2: '바디 타입',
  3: '외장 색상',
  4: '내장 색상',
  5: '휠',
};

const categoryMapping: Record<number, string> = {
  0: 'car',
  1: 'car',
  2: 'car',
  3: 'color',
  4: 'color',
  5: 'car',
};

function Content() {
  const [selectedIndex, setIndex] = useState<number>(0);
  const {option} = useContext(OptionContext);
  const {setTempOption} = useContext(TempOptionContext);
  const [cardData, setcardData] = useState<cardData[]>([]);
  const updateTempOption = (index: number) => {
    const selectedCardData = cardData[index];

    if (selectedCardData) {
      const tempOpt: Option = {
        key: keyMapping[option],
        value: selectedCardData.name,
        category: categoryMapping[option],
        price: selectedCardData.price,
        id: selectedCardData.id,
        imgSrc: selectedCardData.imageSrc,
      };

      setTempOption(tempOpt);
    }
  };
  const setNewIndex = (nextIndex: number) => {
    setIndex(nextIndex);
    updateTempOption(nextIndex);
  };
  const urlEndpoint: OptionUrls = {
    0: '/info/powertrain',
    1: '/info/driving-system',
    2: '/info/bodytype',
    3: '/info/exterior-color',
    4: '/info/interior-color?exteriorColorId=1',
    5: '/info/wheel',
    6: '',
    7: '',
  };
  const fetchedResponse = useFetch<cardData[]>(urlEndpoint[option]);
  useEffect(() => {
    if (fetchedResponse.data) {
      setcardData(fetchedResponse.data);
    } else {
      setcardData([]);
    }
  }, [option, fetchedResponse]);
  const {selectedOptions} = useContext(SelectedOptionContext);
  useEffect(() => {
    const currentKey = keyMapping[option];
    const foundOption = selectedOptions.find((opt) => opt.key === currentKey);
    if (foundOption) {
      setNewIndex(foundOption.id - 1);
    }
  }, [option]);
  return (
    <Wrapper>
      <Container $option={option}>
        {option < 7 ? (
          <>
            {option !== 6 ? (
              <>
                <OptionImage
                  key={option}
                  cardData={cardData}
                  selectedIndex={selectedIndex}
                />
                <OptionInfo
                  cardData={cardData}
                  setNewIndex={(index: number) => setNewIndex(index)}
                  selectedIndex={selectedIndex}
                />
              </>
            ) : (
              <Temp>옵션 선택 페이지는 수정 중 입니다.</Temp>
            )}
          </>
        ) : (
          <TotalEstimate></TotalEstimate>
        )}
      </Container>
    </Wrapper>
  );
}

export default Content;

const Wrapper = styled.section`
  width: 100%;
  flex-grow: 1;
  padding-top: 111px;
`;

const Container = styled.div<{$option: number}>`
  display: flex;
  width: 100%;
  height: 100%;
`;

const Temp = styled.div`
  width: 100%;
  height: 100%;
  ${flexCenter}
`;
