import React from 'react';
import styled from 'styled-components';
import {flexCenter} from '../../../style/common';
import dictionary from '../../../assets/icons/dictionary.svg';
import {colors} from '../../../style/theme';
function Dictionary() {
  return (
    <Wrapper>
      <DLogo src={dictionary}></DLogo>
      <DictionaryP>백카사전 Off</DictionaryP>
    </Wrapper>
  );
}

export default Dictionary;
const Wrapper = styled.div`
  ${flexCenter}
  gap : 4px;
`;

const DLogo = styled.img``;
const DictionaryP = styled.p`
  font-family: 'Title5_Regular';
  color: ${colors.Cool_Grey};
`;
