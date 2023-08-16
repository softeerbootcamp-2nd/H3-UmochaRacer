import React, {useContext, useEffect, useState} from 'react';
import styled from 'styled-components';
import OptionImage from './left/OptionImage';
import OptionInfo from './right/OptionInfo';
import TotalEstimate from './totalestimate/TotalEstimate';

import {OptionContext} from '@/provider/optionProvider';
import bodytype from '@/assets/mocks/bodytype.json';
import powertrain from '@/assets/mocks/powertrain.json';
import drivingsystem from '@/assets/mocks/drivingsystem.json';
import exterior from '@/assets/mocks/exteriror-color.json';
import interior from '@/assets/mocks/interior-color.json';
import wheel from '@/assets/mocks/wheel.json';
import {cardDataType} from './contentInterface';

function Content() {
  const [selectedIndex, setIndex] = useState<number>(0);
  const {option} = useContext(OptionContext);
  const [cardData, setcardData] = useState<cardDataType[]>([]);
  const setNewIndex = (nextIndex: number) => {
    setIndex(nextIndex);
  };

  useEffect(() => {
    setIndex(0);
    switch (option) {
      case 0:
        setcardData(powertrain.data);
        break;
      case 1:
        setcardData(drivingsystem.data);
        break;
      case 2:
        setcardData(bodytype.data);
        break;
      case 3:
        setcardData(exterior.data);
        break;
      case 4:
        setcardData(interior.data);
        break;
      case 5:
        setcardData(wheel.data);
        break;
      case 6:
        setcardData(powertrain.data);
        break;
      default:
        setcardData([]);
    }
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
`;

const Container = styled.div<{$option: number}>`
  display: flex;
  width: 100%;
  height: 100%;
`;
