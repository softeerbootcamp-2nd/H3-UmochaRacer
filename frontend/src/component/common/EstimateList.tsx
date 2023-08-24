import React, {useContext, useEffect, useState} from 'react';
import styled from 'styled-components';
import {HeaderLayout, SelectionLayout} from './estimateInterface';
import {Option, SelectedOptionContext} from '@/provider/selectedOptionProvider';
import {TempOptionContext} from '@/provider/tempOptionProvider';
import Estimate from './estimate/Estimate';
import {OptionContext} from '@/provider/optionProvider';
import {SelectedAdditionalOptionsContext} from '@/provider/additionalOptionProvider';
import {TempAdditionalOptionsContext} from '@/provider/tempAdditionalOptionProvider';
interface HeaderTitle {
  [key: string]: string;
}
interface TotalEstimateData {
  [key: string]: Option[];
  car: Option[];
  color: Option[];
  selectOption: Option[];
}

interface Props {
  gap: number;
  sidePadding: number;
  headerLayout: HeaderLayout;
  selectionLayout: SelectionLayout;
}

const headerTitles: HeaderTitle = {
  car: '팰리세이드 Le Blanc (르블랑)',
  color: '색상',
  selectOption: '옵션',
};

const DEFAULT_PRICE = 43460000;

function EstimateList({
  gap,
  sidePadding,
  headerLayout,
  selectionLayout,
}: Props) {
  const {option} = useContext(OptionContext);
  const {selectedOptions} = useContext(SelectedOptionContext);
  const {tempOption} = useContext(TempOptionContext);
  const {selectedAdditionalOption} = useContext(
    SelectedAdditionalOptionsContext,
  );
  const {additionOptions} = useContext(TempAdditionalOptionsContext);
  const [estimateDatas, setEstimateDatas] = useState<TotalEstimateData>({
    car: [],
    color: [],
    selectOption: [],
  });

  useEffect(() => {
    const nextEstimateDatas: TotalEstimateData = {
      car: [],
      color: [],
      selectOption: [],
    };
    let copyOption = selectedOptions.slice();

    copyOption = copyOption.map((elem) => {
      if (elem.key === tempOption.key) {
        return tempOption;
      } else {
        return elem;
      }
    });

    copyOption.forEach((elem) => {
      nextEstimateDatas[elem.category].push(elem);
    });
    const totAdditionalOptions = [
      ...additionOptions,
      ...selectedAdditionalOption,
    ];
    const additionalOptions = totAdditionalOptions.filter(
      (value, index, self) =>
        self.findIndex((item) => item.id === value.id) === index,
    );

    additionalOptions.sort((a, b) => a.id - b.id);
    additionOptions.forEach((elem, index) => {
      nextEstimateDatas['selectOption'].push({
        key: index === 0 ? '선택 옵션' : '',
        value: elem.name,
        name: elem.name,
        category: '선택 옵션',
        price: elem.price,
        id: elem.id,
        imgSrc: elem.imageSrc,
        userSelect: true,
      });
    });

    if (nextEstimateDatas.selectOption.length === 0) {
      additionalOptions.forEach((elem, index) => {
        nextEstimateDatas['selectOption'].push({
          key: index === 0 ? '선택 옵션' : '',
          value: elem.name,
          name: elem.name,
          category: '선택 옵션',
          price: elem.price,
          id: elem.id,
          imgSrc: elem.imageSrc,
          userSelect: true,
        });
      });
    }
    setEstimateDatas(nextEstimateDatas);
  }, [tempOption, additionOptions]);

  const getTotalPirce = (key: string) => {
    let totalPrice = key === 'car' ? DEFAULT_PRICE : 0;

    estimateDatas[key].forEach((elem) => {
      totalPrice += elem.price;
    });

    return totalPrice;
  };

  const estimates: React.JSX.Element[] = Object.keys(headerTitles).map(
    (key, index) => {
      const haederProps = {
        height: headerLayout.height,
        fontSize: headerLayout.fontSize,
        title: headerTitles[key],
        price: getTotalPirce(key),
      };

      return (
        <Estimate
          key={index}
          sidePadding={sidePadding}
          header={haederProps}
          selectionLayout={selectionLayout}
          options={estimateDatas[key]}
        ></Estimate>
      );
    },
  );
  return <Wrapper $gap={gap}>{estimates}</Wrapper>;
}

export default EstimateList;

const Wrapper = styled.ul<{$gap: number}>`
  display: inline-flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
  gap: ${({$gap}) => $gap}px;
  flex-shrink: 0;
`;
