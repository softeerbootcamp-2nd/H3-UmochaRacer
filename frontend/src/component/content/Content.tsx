import React, {useContext, useEffect, useState} from 'react';
import styled from 'styled-components';
import OptionImage from './left/OptionImage';
import OptionInfo from './right/OptionInfo';
import TotalEstimate from './totalestimate/TotalEstimate';

import {OptionContext} from '@/provider/optionProvider';
import useFetch from '../hooks/useFetch';
type cardData = {
  id: number;
  name: string;
  imageSrc: string;
  price: number;
};
type OptionUrls = Record<number, string>;
function Content() {
  const [selectedIndex, setIndex] = useState<number>(0);
  const {option} = useContext(OptionContext);
  const [cardData, setcardData] = useState<cardData[]>([]);
  const setNewIndex = (nextIndex: number) => {
    setIndex(nextIndex);
  };
  const urlEndpoint: OptionUrls = {
    0: '/info/powertrain',
    1: '/info/driving-system',
    2: '/info/bodytype',
    3: '/info/exterior-color',
    4: '/info/yet-another-endpoint',
    5: '/info/wheel',
  };

  const fetchedResponse = useFetch<cardData[]>(urlEndpoint[option]);
  useEffect(() => {
    if (fetchedResponse.data) {
      setcardData(fetchedResponse.data);
    }
  }, [fetchedResponse]);
  useEffect(() => {
    setIndex(0);
  }, [option]);
  return (
    <Wrapper>
      <Container $option={option}>
        {cardData.length > 0 ? (
          <>
            <OptionImage
              key={option}
              cardData={cardData}
              selectedIndex={selectedIndex}
            />
            <OptionInfo
              cardData={cardData}
              option={option}
              setNewIndex={(index: number) => setNewIndex(index)}
            />
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
