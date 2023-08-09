import {Body3_Medium, Title4_Medium, Title6_Regular} from '@/style/fonts';
import {colors} from '@/style/theme';
import React from 'react';
import {styled} from 'styled-components';

type DescriptionData = {
  main: string;
  sub: string;
};

interface DetailDescriptionProps {
  descriptionData: DescriptionData[];
}

function DetailDescription({descriptionData}: DetailDescriptionProps) {
  return (
    <>
      <Description.Wrapper>
        {descriptionData.map((data, idx) => (
          <Description.Content key={idx}>
            <Description.Index>{idx + 1}</Description.Index>
            <Description.TextWrapper>
              <Description.Text>{data.main}</Description.Text>
              <Description.SubText>{data.sub}</Description.SubText>
            </Description.TextWrapper>
          </Description.Content>
        ))}
      </Description.Wrapper>
    </>
  );
}

export default DetailDescription;
const Description = {
  Wrapper: styled.div`
    display: flex;
    flex-direction: column;
    gap: 20px;
    align-items: flex-start;
  `,
  Content: styled.div`
    display: flex;
    gap: 12px;
  `,
  Index: styled.div`
    display: flex;
    align-items: center;
    justify-content: center;
    width: 19px;
    height: 19px;
    margin: 0 auto;

    border-radius: 50%;
    background-color: ${colors.Main_Hyundai_Blue};
    ${Body3_Medium}
    box-shadow: 0px 2px 12px rgba(44, 44, 44, 0.3);
  `,
  TextWrapper: styled.div`
    display: flex;
    flex-direction: column;
    gap: 8px;
  `,
  Text: styled.p`
    ${Title4_Medium}
    line-height: 17px;
    font-weight: 400;
    text-shadow: 0px 2px 12px rgba(44, 44, 44, 0.3);
  `,
  SubText: styled.p`
    ${Title6_Regular}
    line-height: 16px;
    text-shadow: 0px 2px 12px rgba(44, 44, 44, 0.3);
  `,
};
