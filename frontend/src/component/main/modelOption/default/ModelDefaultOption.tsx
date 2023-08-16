import React, {useEffect, useState} from 'react';
import ModelOptionDetail from './ModelOptionDetail';
import styled from 'styled-components';
import {fetchData} from '@/api/fetchData';
import {flexBetween, flexCenter} from '@/style/common';
import {colors} from '@/style/theme';
import {Body1_Medium, Body2_Medium, Popup_Regular} from '@/style/fonts';
import Icon from '@/component/common/icons';

type Option = {
  imageSrc: string;
  name: string;
};

type TrimData = {
  trim: string;
  sources: Option[];
};

type FetchedData = {
  [key: number]: TrimData;
};

function ModelDefaultOption() {
  const [selectedCategory, setSelectedCategory] = useState<number>(0);
  const [page, setPage] = useState<number>(0);
  const [fetchedData, setFetchedData] = useState<FetchedData>({});
  const trimIds: number[] = [2, 1, 3, 4];
  const categories = [
    {eng: 'All', kor: '전체'},
    {eng: 'performance', kor: '성능'},
    {eng: 'ai_safety', kor: '지능형 안전기술'},
    {eng: 'safety', kor: '안전'},
    {eng: 'exterior', kor: '외관'},
    {eng: 'interior', kor: '내장'},
    {eng: 'seat', kor: '시트'},
    {eng: 'convenience', kor: '편의'},
    {eng: 'multimedia', kor: '멀티미디어'},
  ];
  useEffect(() => {
    async function fetchDefaultOption() {
      const categoryQuery =
        selectedCategory === 0
          ? ''
          : `&category=${categories[selectedCategory].eng}`;

      const promises = trimIds.map(async (trimId: number) => {
        const data = await fetchData(
          `/intro/additional-option?page=${page}&size=5&trimId=${trimId}${categoryQuery}`,
        );
        return {trimId, data};
      });
      const results = await Promise.all(promises);
      setFetchedData((prevData) => {
        const updatedData: FetchedData = {...prevData};
        results.forEach((result) => {
          if (!updatedData[result.trimId]) {
            updatedData[result.trimId] = {trim: result.data.trim, sources: []};
          }
          if (result.data !== undefined)
            updatedData[result.trimId].sources = updatedData[
              result.trimId
            ].sources.concat(result.data.sources);
        });
        return updatedData;
      });
    }

    fetchDefaultOption();
  }, [page, selectedCategory]);

  const handleCategoryClick = (index: number) => {
    if (selectedCategory !== index) {
      setPage(0);
      setSelectedCategory(index);
      setFetchedData({});
    }
  };

  const handleShowMoreClick = () => {
    setPage((prevPage) => prevPage + 1);
  };

  const renderOptionDetails = (optionList: Option[]) => {
    return (
      <OptionWrapper>
        {optionList.map((item, index) => (
          <ModelOptionDetail key={index} src={item.imageSrc} name={item.name} />
        ))}
      </OptionWrapper>
    );
  };

  return (
    <>
      <Category.Wrapper>
        {categories.map((category, index) => (
          <Category.Item
            key={index}
            $isSelected={selectedCategory === index}
            onClick={() => handleCategoryClick(index)}
          >
            <Category.Name $isSelected={selectedCategory === index}>
              {category.kor}
            </Category.Name>
          </Category.Item>
        ))}
      </Category.Wrapper>
      <Wrapper>
        {trimIds.map(
          (trimId) =>
            fetchedData[trimId] && (
              <div key={trimId}>
                {renderOptionDetails(fetchedData[trimId].sources)}
              </div>
            ),
        )}
      </Wrapper>
      <Category.ShowMore onClick={handleShowMoreClick}>
        <Category.ShowMoreP>더보기</Category.ShowMoreP>
        <Icon name="ArrowBottom" size={24} />
      </Category.ShowMore>
    </>
  );
}

export default ModelDefaultOption;

const Wrapper = styled.div`
  ${flexBetween};
  align-items: flex-start;
  width: 100%;
  padding: 0 24px 0 24px;
`;

const OptionWrapper = styled.div`
  width: 200px;
  ${flexCenter}
  flex-direction: column;
  gap: 41px;
`;

const Category = {
  Wrapper: styled.div`
    ${flexBetween}
    gap:8px;
  `,
  Item: styled.div<{$isSelected: boolean}>`
    ${flexCenter}
    border-radius: 6px;
    height: 32px;
    background: ${(props) =>
      props.$isSelected ? colors.Main_Hyundai_Blue : colors.Cool_Grey_001};
    align-items: center;
    overflow: hidden;
    padding: 6px 22px;
    cursor: pointer;
  `,
  Name: styled.p<{$isSelected: boolean}>`
    color: ${(props) =>
      props.$isSelected ? colors.Hyundai_White : colors.Cool_Grey_003};
    ${(props) => (props.$isSelected ? Body2_Medium : Popup_Regular)};
  `,
  ShowMore: styled.div`
    ${flexCenter};
    width: 140px;
    height: 50px;
    border-radius: 6px;
    background: ${colors.Cool_Grey_001};
    cursor: pointer;
    margin-top: 20px;
  `,
  ShowMoreP: styled.p`
    color: ${colors.Cool_Grey_004};
    ${Body1_Medium}
  `,
};
