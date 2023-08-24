import React, {useContext, useState} from 'react';
import styled from 'styled-components';
import EstimateHeader from './EstimateHeader';
import DetailEstimate from './bottom/DetailEstimate';
import {Option, SelectedOptionContext} from '@/provider/selectedOptionProvider';

interface Props {
  totalPrice: number;
}

const getOptionArr = (array: Option[]) => {
  const optionArr: Option[] = [
    {
      key: '트림',
      value: 'Le Blanc (르블랑)',
      category: 'trim',
      price: 43460000,
      id: 1,
      imgSrc: '/image/white.png',
      userSelect: false,
    },
    ...array,
  ];

  return optionArr;
};

function Bottom({totalPrice}: Props) {
  const [detailOpen, setDetailOpen] = useState<boolean>(false);
  const {selectedOptions} = useContext(SelectedOptionContext);
  const options = getOptionArr(selectedOptions);

  const Details: React.JSX.Element[] = options.map(
    (elem: Option, index: number) => {
      return (
        <DetailEstimate
          key={index}
          detailOpen={detailOpen}
          optionIndex={index - 1}
          option={elem}
        ></DetailEstimate>
      );
    },
  );

  const handleButtonClick = () => {
    setDetailOpen(!detailOpen);
  };

  return (
    <Wrapper>
      <EstimateHeader
        text={'견적 자세히 보기'}
        price={totalPrice}
        onClick={handleButtonClick}
      ></EstimateHeader>
      <DetailList>{Details}</DetailList>
    </Wrapper>
  );
}

export default Bottom;

const Wrapper = styled.div`
  width: 100%;
`;

const DetailList = styled.ul`
  display: flex;
  flex-direction: column;
  width: 100%;
  gap: 60px;
`;
