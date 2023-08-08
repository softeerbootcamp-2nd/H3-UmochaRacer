import React from 'react';

type DescriptionData = {
  main: string;
  sub: string;
};

interface DetailDescriptionProps {
  descriptionData: DescriptionData[];
}

function DetailDescription({descriptionData}: DetailDescriptionProps) {
  return <>개굿 ㅋ</>;
}

export default DetailDescription;
