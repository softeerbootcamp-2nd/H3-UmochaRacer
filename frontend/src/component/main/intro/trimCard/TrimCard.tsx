import Icon from '@/component/common/icons';
import {flexBetween} from '@/style/common';
import {Body2_Regular, Title2_Medium} from '@/style/fonts';
import {colors} from '@/style/theme';
import React, {useState} from 'react';
import {styled} from 'styled-components';
import {useNavigate} from 'react-router-dom';

import trim from '@/assets/mocks/trim.json';
import TrimDescription from './trimDescription/TrimDescription';

type TrimData = {
  id: number;
  name: string;
  tag: string;
  price: number;
  route: string;
  description?: {
    title: string;
    hasDescription: boolean;
    descriptionData: Array<{
      main: string;
      sub: string;
    }>;
  } | null;
};

interface TrimCardProps {
  trimData: TrimData;
}
function TrimCard({trimData}: TrimCardProps) {
  const navigate = useNavigate();
  const [isHover, setIsHover] = useState<boolean>(false);

  const handleTrimCardClick = (route: string) => {
    navigate(route);
  };
  return (
    <>
      <Card.Wrapper
        onMouseEnter={() => setIsHover(true)}
        onMouseLeave={() => setIsHover(false)}
        onClick={() => handleTrimCardClick(trimData.route)}
      >
        <Card.Tag>{`#${trimData.tag}`}</Card.Tag>
        <Card.Name>{`${trimData.name}`}</Card.Name>
        <Card.PriceWrapper>
          <Card.Price>{`${trimData.price.toLocaleString()}원 부터`}</Card.Price>
          <Icon name="ArrowRight" size={20} />
        </Card.PriceWrapper>
        {isHover && (
          <Card.DescriptionWrapper id={trimData.id}>
            {trimData.description && (
              <TrimDescription
                trimDescription={trimData.description}
                name={trimData.name}
              />
            )}
          </Card.DescriptionWrapper>
        )}
      </Card.Wrapper>
    </>
  );
}
function TrimCardList() {
  return (
    <TrimCardWrapper>
      {trim.map((trimItem) => (
        <TrimCard key={trimItem.id} trimData={trimItem} />
      ))}
    </TrimCardWrapper>
  );
}

export default TrimCardList;

const TrimCardWrapper = styled.div`
  margin-top: auto;
  margin-bottom: 40px;
  display: flex;
  gap: 16px;
`;
const Card = {
  Wrapper: styled.div`
    position: relative;
    width: 192px;
    height: 123px;
    border-radius: 6px;
    background: ${colors.Hyundai_White};
    color: ${colors.Cool_Grey};
    flex-shrink: 0;
    padding: 20px 14px 20px 20px;
    cursor: pointer;

    transition: all 0.1s;

    &:hover {
      color: white;
      background-color: ${colors.Main_Hyundai_Blue};

      & svg {
        fill: white;
      }
    }
  `,
  Tag: styled.p`
    ${Body2_Regular}
    margin-bottom : 8px;
  `,
  Name: styled.p`
    ${Title2_Medium}
    margin-bottom : 17px;
  `,
  PriceWrapper: styled.div`
    ${flexBetween}
  `,
  Price: styled.p`
    ${Body2_Regular}
  `,
  DescriptionWrapper: styled.div<{id: number}>`
    position: absolute;
    top: -253px;
    left: ${({id}) => (id <= 1 ? '0' : id <= 4 ? '-210px' : '-420px')};
  `,
};
