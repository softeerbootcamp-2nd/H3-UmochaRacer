import React, {useContext, useEffect} from 'react';
import {useState, useCallback} from 'react';
import styled, {css} from 'styled-components';
import {colors} from '@/style/theme';
import {Body2_Regular, Popup_Regular, Title2_Medium} from '@/style/fonts';
import {cardDataType} from '../../contentInterface';
import DetailBox from '@/component/common/DetilBox';
import DetailToggle from './DetailToggle';
import FeedBack from './FeedBack';
import TagBox from './Tag';
import {OptionContext} from '@/provider/optionProvider';
import {fetchData} from '@/api/fetchData';
import DetailSelectedBox from '@/component/common/DetailSelectedBox';
import {getCategory} from '@/component/util/getCategory';
import {useImageSrcDispatch} from '@/provider/tempImageProvider';
import {useGuideFlowState} from '@/provider/guideFlowProvider';
interface DetailData {
  title: string;
  description: string;
  info?: string;
}
interface CardProps {
  selected: boolean;
  isSaved: boolean;
  onClick: () => void;
  data: cardDataType;
  ratioList: SelectionRatioProps[];
}
interface SelectionRatioProps {
  id: number;
  selectionRatio: number;
}
const SelectIcon = (isGuide: boolean) => {
  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="24"
      height="24"
      viewBox="0 0 24 24"
      fill="none"
    >
      <path
        d="M12 22C6.477 22 2 17.523 2 12C2 6.477 6.477 2 12 2C17.523 2 22 6.477 22 12C22 17.523 17.523 22 12 22ZM10.643 16.243L17.713 9.172L16.299 7.758L10.643 13.415L7.814 10.586L6.4 12L10.643 16.243Z"
        fill={isGuide ? colors.Sub_Active_Blue : '#0E2B5C'}
      />
    </svg>
  );
};

const DefaultIcon = () => {
  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="24"
      height="24"
      viewBox="0 0 24 24"
      fill="none"
    >
      <path
        d="M12.4004 22.1064C6.87739 22.1064 2.40039 17.6294 2.40039 12.1064C2.40039 6.58345 6.87739 2.10645 12.4004 2.10645C17.9234 2.10645 22.4004 6.58345 22.4004 12.1064C22.4004 17.6294 17.9234 22.1064 12.4004 22.1064ZM11.0434 16.3494L18.1134 9.27845L16.6994 7.86445L11.0434 13.5214L8.21439 10.6924L6.80039 12.1064L11.0434 16.3494Z"
        fill="#AAAAAA"
      />
    </svg>
  );
};

const DetailOption = new Set([0, 1, 2, 5, 6]);

const hasDetail = (option: number) => {
  return DetailOption.has(option);
};

function OptionCard({selected, onClick, data, isSaved, ratioList}: CardProps) {
  const [toggle, setToggle] = useState(false);
  const {option} = useContext(OptionContext);
  const {showGuide} = useGuideFlowState();
  const [descriptionData, setDescriptionData] = useState<
    DetailData | DetailData[] | null
  >(null);
  const [rate, setRate] = useState<number>(0);
  const dispatch = useImageSrcDispatch();
  const clickedToggle = useCallback(
    (event: React.MouseEvent) => {
      event.stopPropagation();
      setToggle(!toggle);
    },
    [toggle],
  );
  const categoryName = getCategory(option);
  const handleToggleHover = () => {
    if (hasDetail(option) && !descriptionData) {
      const endpoint = `/detail/${categoryName}/${data.id}`;
      fetchData(endpoint)
        .then((response) => {
          setDescriptionData(response);
        })
        .catch((error) => {
          console.error('Error fetching data:', error);
        });
    }
  };
  const handleToggleHoverEnd = () => {};
  useEffect(() => {
    setToggle(false);
    dispatch({type: 'RESET_IMAGE_SRC'});
  }, [selected]);
  useEffect(() => {
    const matchIdRatio = ratioList.find(
      (item: SelectionRatioProps) => item.id === data.id,
    );
    if (matchIdRatio) setRate(matchIdRatio.selectionRatio);
  }, [ratioList]);
  return (
    <Wrapper onClick={onClick} $selected={selected} $isGiude={showGuide}>
      <Container>
        <CardSection $height={24}>
          <IconBox>{selected ? SelectIcon(showGuide) : DefaultIcon()}</IconBox>
          {showGuide && <TagBox id={data.id}></TagBox>}
          {data.partsSrc ? (
            <Parts $url={data.partsSrc} $selected={selected}></Parts>
          ) : (
            ''
          )}
        </CardSection>

        <CardSection $height={60}>
          <TextBox>
            <Text1 className="blue" $isGiude={showGuide}>
              {data.saleRate
                ? `나와 비슷한 ${data.saleRate}%가 선택한`
                : `구매자의 ${rate}%가 선택했어요!`}
            </Text1>
            <Text2 className="black">{data.name}</Text2>
          </TextBox>
          {data.iconSrc ? (
            <MiddleImg $url={data.iconSrc} $selected={selected}></MiddleImg>
          ) : (
            ''
          )}
          {data.colorCode ? (
            <ColorBox $colorcode={data.colorCode}></ColorBox>
          ) : (
            ''
          )}
        </CardSection>
        {hasDetail(option) &&
          (option !== 6
            ? !Array.isArray(descriptionData) && (
                <DetailBox
                  isOpen={toggle && selected && !isSaved}
                  id={data.id}
                  descriptionData={descriptionData}
                />
              )
            : Array.isArray(descriptionData) && (
                <DetailSelectedBox
                  isOpen={toggle && selected && !isSaved}
                  id={data.id}
                  descriptionData={descriptionData}
                />
              ))}

        <CardSection $height={26} $end={true}>
          <Price className="blue">{`+ ${data.price.toLocaleString()}원`}</Price>

          {hasDetail(option) ? (
            <DetailToggle
              onClick={clickedToggle}
              opened={toggle && selected && !isSaved}
              selected={selected}
              onHover={handleToggleHover}
              onHoverEnd={handleToggleHoverEnd}
            />
          ) : (
            ''
          )}
        </CardSection>
      </Container>
      {isSaved && option !== 6 && selected && (
        <FeedBack id={data.id}></FeedBack>
      )}
    </Wrapper>
  );
}

export default OptionCard;

const flexBetween = css`
  display: flex;
  justify-content: space-between;
`;

const Select = css<{$isGiude: boolean}>`
  border: 2px solid
    ${({$isGiude}) =>
      $isGiude ? colors.Sub_Active_Blue : colors.Main_Hyundai_Blue};
`;

const Default = css<{$isGiude: boolean}>`
  background: ${colors.Cool_Grey_001};
  border: 2px solid transparent;
  cursor: pointer;

  &:hover {
    border: 2px solid ${colors.Cool_Grey_003};
    .blue {
      color: ${({$isGiude}) =>
        $isGiude ? colors.Sub_Active_Blue : colors.Main_Hyundai_Blue};
    }
    .black {
      color: ${colors.Cool_Grey};
    }
  }
  div {
    color: ${colors.Cool_Grey_003};
    transition: 0.5s;
  }
`;

const Wrapper = styled.li<{$selected: boolean; $isGiude: boolean}>`
  display: flex;
  flex-shrink: 0;
  flex-direction: column;
  position: relative;
  width: 375px;
  min-height: 150px;
  padding: 20px;
  border-radius: 6px;
  ${(props) => (props.$selected ? Select : Default)};
  transition: 0.5s;
`;

const Container = styled.div``;
const CardSection = styled.div<{$height?: number; $end?: boolean}>`
  ${flexBetween}
  align-items: ${(props) => (props.$end ? 'flex-end' : 'center')};

  height: ${(props) => (props.$height ? props.$height : '')}px;
`;

const IconBox = styled.div`
  width: 24px;
  height: 24px;
  flex-shrink: 0;
  transition: 0.5s;
`;

const imageBlur = css`
  &::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: ${colors.Cool_Grey_001};
    opacity: 0.5;
  }
`;

const Parts = styled.div<{$url: string; $selected: boolean}>`
  display: flex;
  align-items: center;
  position: relative;
  width: 84px;
  height: 24px;
  background: url(${(props) => props.$url}) no-repeat;
  background-position: center;
  background-size: contain;
  ${(props) => {
    return props.$selected ? '' : imageBlur;
  }}
`;

const TextBox = styled.div`
  gap: 4px;
`;

const Text1 = styled.div<{$isGiude: boolean}>`
  ${Popup_Regular}
  font-size: 12px;
  line-height: 130%;
  height: 16px;
  margin-top: 10px;
  color: ${({$isGiude}) =>
    $isGiude ? colors.Sub_Active_Blue : colors.Main_Hyundai_Blue};
`;

const Text2 = styled.div`
  ${Title2_Medium}
  height: 26px;
  color: ${colors.Cool_Grey};
`;

const MiddleImg = styled.div<{$url: string; $selected: boolean}>`
  display: flex;
  align-items: center;
  position: relative;
  width: 150px;
  height: 60px;
  background: url(${(props) => props.$url}) no-repeat;
  background-position: center;
  ${(props) => {
    return !props.$selected && imageBlur;
  }}
`;

const ColorBox = styled.div<{$colorcode: string}>`
  width: 60px;
  height: 60px;
  border: 1px solid ${colors.Cool_Grey_002};
  border-radius: 100%;
  background-image: url(${(props) => props.$colorcode});
`;

const Price = styled.div`
  ${Body2_Regular}
  color: ${colors.Main_Hyundai_Blue};
`;
