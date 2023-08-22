import React from 'react';
import DetailDescription from './DetailDescription';
import DetailFeature from './DetailFeature';
type TrimDescriptionData = {
  title: string;
  hasDescription: boolean;
  descriptionData: Array<{
    main: string;
    sub: string;
  }>;
};
interface TrimDescriptionProps {
  descriptionDetail: TrimDescriptionData;
}
function TrimDescriptionDetail({descriptionDetail}: TrimDescriptionProps) {
  return (
    <>
      {descriptionDetail.hasDescription ? (
        <DetailDescription
          descriptionData={descriptionDetail.descriptionData}
        />
      ) : (
        <DetailFeature descriptionData={descriptionDetail.descriptionData} />
      )}
    </>
  );
}

export default TrimDescriptionDetail;
