import React, {useContext,useState} from 'react';
import styled from 'styled-components';
import OptionImage from './left/OptionImage';
import OptionInfo from './right/OptionInfo';
import {OptionContext} from '@/provider/optionProvider';
interface Data {
  optionId: number;
  label: string;
  rate: number;
  price: number;
  imageSrc: string;
}

interface Props {
  optionId: number;
  label: string;
  rate: number;
  price: number;
}
interface OptionInfoProps {
  ContentData: Data[];
}
function Content({ContentData}: OptionInfoProps) {
  const [seletedIndex, setIndex] = useState<number>(0);
  const {option, setOption} = useContext(OptionContext);
  const subOptiondData: Props[] = ContentData.map(
    ({optionId, label, rate, price}) => ({
      optionId,
      label,
      rate,
      price,
    }),
  );

  const setNewIndex = (nextIndex: number) => {
    setIndex(nextIndex);
  };
  return (
    <Wrapper>
      <Container>
        <OptionImage url={ContentData[seletedIndex].imageSrc} />
        <OptionInfo
          cardData={subOptiondData}
          setNewIndex={(index: number) => setNewIndex(index)}
        />
      </Container>
    </Wrapper>
  );
}

export default Content;

const Wrapper = styled.section`
  width: 100%;
  flex-grow: 1;
`;

const Container = styled.div`
  display: flex;
  width: 100%;
  height: 100%;
`;
