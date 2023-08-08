import {Title5_Regular, Title6_Regular} from '@/style/fonts';
import React from 'react';
import styled from 'styled-components';

type DescriptionData = {
  main: string;
  sub: string;
};

interface DetailFeatureProps {
  descriptionData: DescriptionData[];
}

function DetailFeature({descriptionData}: DetailFeatureProps) {
  return (
    <>
      <Feature.Wrapper>
        <Feature.Title>핵심 옵션</Feature.Title>
        <Feature.InfoWrapper>
          {descriptionData.map((data, idx) => (
            <Feature.Option key={idx}>
              <Feature.Image src={data.sub} />
              <Feature.Text>
                {data.main}
                {idx !== descriptionData.length - 1 && <Feature.Border />}
              </Feature.Text>
            </Feature.Option>
          ))}
        </Feature.InfoWrapper>
      </Feature.Wrapper>
    </>
  );
}

export default DetailFeature;
const Feature = {
  Wrapper: styled.div`
    margin-left: 30px;
  `,
  Title: styled.p`
    margin: 16px 0;
    ${Title5_Regular}
    line-height: 15px;
    letter-spacing: -0.56px;
    text-shadow: 0px 2px 12px rgba(44, 44, 44, 0.3);
  `,
  InfoWrapper: styled.div`
    display: flex;
    margin-left: -32px;
  `,
  Image: styled.img`
    width: 60px;
    height: 60px;
    margin: 0 30px;
  `,
  Text: styled.div`
    ${Title6_Regular}
    font-weight: 400;
    white-space: pre-line;
    text-align: center;
  `,
  Border: styled.div`
    position: absolute;
    bottom: 29px;
    right: 0;
    width: 1px;
    height: 22px;
    background-color: white;
  `,
  Option: styled.div`
    position: relative;
    display: flex;
    flex-direction: column;
    align-items: center;
  `,
};
