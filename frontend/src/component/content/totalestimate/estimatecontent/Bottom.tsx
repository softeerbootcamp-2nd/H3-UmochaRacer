import React from 'react';
import styled from 'styled-components';
import EstimateHeader from './EstimateHeader';
import DetailEstimate from './bottom/DetailEstimate';

// interface Props {
//     optionName: string;
//     optionTitle: string;
//     imgSrc: string;
//     price: number;
//   }

const options = [
  {
    imgSrc: 'src/assets/images/white.png',
    optionName: '트림',
    optionTitle: 'Le Blanc (르블랑)',
    price: 43460000,
  },
  {
    imgSrc: 'src/assets/images/powertrain.png',
    optionName: '파워트레인',
    optionTitle: '디젤 2.2',
    price: 1480000,
  },
  {
    imgSrc: 'src/assets/images/2wd.png',
    optionName: '구동방식',
    optionTitle: '2WD',
    price: 0,
  },
  {
    imgSrc: 'src/assets/images/7seats.png',
    optionName: '바디타입',
    optionTitle: '7인승',
    price: 0,
  },
  {
    imgSrc: 'src/assets/images/white.png',
    optionName: '외장 컬러',
    optionTitle: '크리미 화이트 펄',
    price: 100000,
  },
  {
    imgSrc: 'src/assets/images/innerblack.png',
    optionName: '내장 컬러',
    optionTitle: '퀄팅천연 (블랙)',
    price: 0,
  },
];

function Bottom() {
  const Details: React.JSX.Element[] = options.map((elem, index) => {
    return (
      <DetailEstimate
        key={index}
        optionName={elem.optionName}
        optionTitle={elem.optionTitle}
        price={elem.price}
        imgSrc={elem.imgSrc}
      ></DetailEstimate>
    );
  });

  return (
    <Wrapper>
      <EstimateHeader
        text={'견적 자세히 보기'}
        price={43460000 + 1480000 + 100000}
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
