import React, {useContext, useEffect, useState} from 'react';
import styled from 'styled-components';
import OptionImage from './left/OptionImage';
import OptionInfo from './right/OptionInfo';
import TotalEstimate from './totalestimate/TotalEstimate';

import {OptionContext} from '@/provider/optionProvider';
import {TempOptionContext} from '@/provider/tempOptionProvider';
import {SelectedOptionContext} from '@/provider/selectedOptionProvider';
import {fetchData} from '@/api/fetchData';
import Spinner from '../common/Spinner';
import SelectedOptionContent from './SelectedOptionContent';
import {useGuideFlowState} from '@/provider/guideFlowProvider';
import {postFetchData} from '@/api/postFetchData';
import {TempAdditionalOptionsContext} from '@/provider/tempAdditionalOptionProvider';
import {SelectedAdditionalOptionsContext} from '@/provider/additionalOptionProvider';
type cardData = {
  id: number;
  name: string;
  imageSrc: string;
  price: number;
  saleRate?: number;
};
type OptionUrls = Record<number, string | string[]>;
interface Option {
  key: string;
  value: string;
  category: string;
  price: number;
  id: number;
  imgSrc: string;
  userSelect: boolean;
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

interface SelectionRate {
  id: number;
  selectionRatio: number;
}
let selectionRateArr: SelectionRate[][] = [];
export const preventClose = (e: BeforeUnloadEvent) => {
  e.preventDefault();
  e.returnValue = '나갈거임?';
};
function Content() {
  useEffect(() => {
    (() => {
      window.addEventListener('beforeunload', preventClose);
    })();

    return () => {
      window.removeEventListener('beforeunload', preventClose);
    };
  }, []);
  const [selectedIndex, setIndex] = useState<number>(0);
  const {option} = useContext(OptionContext);
  const {setTempOption} = useContext(TempOptionContext);
  const [cardData, setcardData] = useState<cardData[]>([]);
  const [cardDataList, setCardDataList] = useState<cardData[][]>([]);
  const [additionalOptionList, setAddOptionList] = useState<cardData[][]>([]);
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const {selectedOptions} = useContext(SelectedOptionContext);
  const {showGuide, dataObject} = useGuideFlowState();
  const {setAdditionalOptions} = useContext(TempAdditionalOptionsContext);
  const {selectedAdditionalOption} = useContext(
    SelectedAdditionalOptionsContext,
  );
  const updateTempOption = (index: number) => {
    if (cardData !== cardDataList[option]) return;
    console.log(option);
    if (option !== 6) {
      const selectedCardData = cardData[index];
      if (selectedCardData) {
        const tempOpt: Option = {
          key: keyMapping[option],
          value: selectedCardData.name,
          category: categoryMapping[option],
          price: selectedCardData.price,
          id: selectedCardData.id,
          imgSrc: selectedCardData.imageSrc,
          userSelect: false,
        };
        setTempOption(tempOpt);
      }
    }
  };
  const setNewIndex = (nextIndex: number) => {
    // if (nextIndex === selectedIndex) return;
    updateTempOption(nextIndex);
    setIndex(nextIndex);
  };
  const urlEndpoint: OptionUrls = {
    0: '/info/powertrain',
    1: '/info/driving-system',
    2: '/info/bodytype',
    3: '/info/exterior-color',
    4: '/info/interior-color?exteriorColorId=1',
    5: '/info/wheel',
    6: [
      '/info/additional-option?category=system',
      '/info/additional-option?category=temperature',
      '/info/additional-option?category=outer_device',
      '/info/additional-option?category=inner_device',
    ],
    7: '',
  };
  const sortBySelectionRate = (array: cardData[], index: number) => {
    const sortedCardDataArray: cardData[] = selectionRateArr[index]
      .map((rate: {id: number; selectionRatio: number}) => {
        const card = array.find((card) => rate.id === card.id);
        let reulstData: cardData = {
          id: 0,
          name: '',
          imageSrc: '',
          price: 0,
          saleRate: 0,
        };

        if (card) {
          reulstData = {...card, saleRate: rate.selectionRatio};
          return reulstData;
        }
      })
      .filter((card): card is cardData => card !== undefined);

    return sortedCardDataArray;
  };

  useEffect(() => {
    const fetchAllData = async () => {
      const results = await Promise.all(
        Object.values(urlEndpoint).map(async (endpoint) => {
          if (typeof endpoint === 'string' && endpoint) {
            return fetchData(endpoint);
          } else if (Array.isArray(endpoint)) {
            return Promise.all(endpoint.map(fetchData));
          }
        }),
      );

      if (showGuide && dataObject.options) {
        const requestBody = {
          age: dataObject.age,
          gender: dataObject.gender,
          tag1: dataObject.options[0],
          tag2: dataObject.options[1],
          tag3: dataObject.options[2],
        };

        const endpoints = [
          '/sale/powertrain/tag',
          '/sale/driving-system/tag',
          '/sale/bodytype/tag',
          '/sale/exterior-color/tag',
          '/sale/interior-color/tag',
          '/sale/wheel/tag',
        ];

        selectionRateArr = await Promise.all(
          endpoints.map(async (url: string) => {
            return postFetchData(url, requestBody);
          }),
        );

        const sortCardArr = results
          .slice(0, 6)
          .map((card, index) => sortBySelectionRate(card, index));
        setCardDataList(sortCardArr);

        if (option !== 7) {
          setcardData(sortCardArr[option]);
        }
      } else {
        const newCardDataList = results.slice(0, 6) as cardData[][];
        const newAdditionalOptionList = results[6] as cardData[][];

        setCardDataList(newCardDataList);
        setAddOptionList(newAdditionalOptionList);
        setcardData(newCardDataList[option]);
      }
      setIsLoading(true);
    };

    fetchAllData();
  }, []);
  useEffect(() => {
    if (option === 7) return;
    if (!cardDataList[option]) return;
    if (option !== 6) {
      const currentKey = keyMapping[option];
      const foundOption = selectedOptions.find((opt) => opt.key === currentKey);
      if (foundOption) {
        const targetIndex = cardDataList[option].findIndex(
          (card) => card.id === foundOption.id,
        );
        if (targetIndex > -1) {
          setNewIndex(targetIndex);
        }
      } else {
        setNewIndex(0);
      }
      setcardData(cardDataList[option]);
    }
    setAdditionalOptions(selectedAdditionalOption);
  }, [option, cardDataList, cardData]);

  return (
    <Wrapper>
      {!isLoading && <Spinner />}
      <Container $option={option}>
        {option < 7 ? (
          <>
            {option !== 6 ? (
              <>
                <OptionImage
                  key={option}
                  cardData={cardDataList[option]}
                  selectedIndex={selectedIndex}
                />
                <OptionInfo
                  cardData={cardData}
                  setNewIndex={(index: number) => setNewIndex(index)}
                  selectedIndex={selectedIndex}
                />
              </>
            ) : (
              <SelectedOptionContent
                selectedOptionData={additionalOptionList}
                setNewIndex={(index: number) => setNewIndex(index)}
                selectedIndex={selectedIndex}
              />
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
