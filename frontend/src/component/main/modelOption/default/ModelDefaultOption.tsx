import React, {useState} from 'react';
import ModelOptionDetail from './ModelOptionDetail';
import styled from 'styled-components';
import {flexBetween, flexCenter} from '@/style/common';
import mainOption from '@/assets/mocks/main/defaultOption.json';
import {colors} from '@/style/theme';
import {Body1_Medium, Body2_Medium, Popup_Regular} from '@/style/fonts';
import Icon from '@/component/common/icons';

type Option = {
  icon: string;
  name: string;
};

function ModelDefaultOption() {
  const [selectedCategory, setSelectedCategory] = useState<number>(0);
  const handleCategoryClick = (index: number) => {
    setSelectedCategory(index);
  };
  const renderOptionDetails = (optionList: Option[]) => {
    return (
      <OptionWrapper>
        {optionList.map((item, index) => (
          <ModelOptionDetail key={index} src={item.icon} name={item.name} />
        ))}
      </OptionWrapper>
    );
  };
  const categoryNames = [
    '전체',
    '성능',
    '지능형 안전기술',
    '안전',
    '외관',
    '내장',
    '시드',
    '편이',
    '멀티미디어',
  ];
  return (
    <>
      <Category.Wrapper>
        {categoryNames.map((name, index) => (
          <Category.Item
            key={index}
            $isSelected={selectedCategory === index} // selectedCategory가 현재 index와 같은지 확인
            onClick={() => handleCategoryClick(index)} // 클릭시 해당 index로 setSelectedCategory 업데이트
          >
            <Category.Name $isSelected={selectedCategory === index}>
              {name}
            </Category.Name>
          </Category.Item>
        ))}
      </Category.Wrapper>
      <Wrapper>
        {renderOptionDetails(mainOption[selectedCategory].exclusive)}
        {renderOptionDetails(mainOption[selectedCategory].LeBlanc)}
        {renderOptionDetails(mainOption[selectedCategory].Prestige)}
        {renderOptionDetails(mainOption[selectedCategory].Calligraphy)}
      </Wrapper>
      <Category.ShowMore>
        <Category.ShowMoreP>더보기</Category.ShowMoreP>
        <Icon name="ArrowBottom" />
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
