import React from 'react';

type DescriptionData = {
  main: string;
  sub: string;
};

interface DetailFeatureProps {
  descriptionData: DescriptionData[];
}

function DetailFeature({descriptionData}: DetailFeatureProps) {
  return <>ㄴ이리ㅓ런ㄹ머ㅣ머라ㅣㄴㄹ</>;
}

export default DetailFeature;
