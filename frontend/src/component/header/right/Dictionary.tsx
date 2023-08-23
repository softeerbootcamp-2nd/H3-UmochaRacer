import React from 'react';
import styled from 'styled-components';
import {flexCenter} from '@/style/common';
import dictionary from '@/assets/icons/dictionary.svg';
import openDictionary from '@/assets/icons/open_dictionary.svg';
import {colors} from '@/style/theme';
import {Title5_Regular} from '@/style/fonts';
import {
  useCardbState,
  useCardbDispatch,
  TOGGLE_CARDB,
} from '@/provider/cardbProvider';

function Dictionary() {
  const cardbState = useCardbState();
  const cardbDispatch = useCardbDispatch();

  const handleClickDictionary = () => {
    cardbDispatch({type: TOGGLE_CARDB});
  };

  return (
    <Wrapper onClick={handleClickDictionary}>
      <DLogo src={cardbState.cardbOn ? openDictionary : dictionary}></DLogo>
      <DictionaryP $cardbOn={cardbState.cardbOn}>
        백카사전 {cardbState.cardbOn ? 'On' : 'Off'}
      </DictionaryP>
    </Wrapper>
  );
}

export default Dictionary;
const Wrapper = styled.div`
  ${flexCenter}
  gap : 4px;
  cursor: pointer;
`;

const DLogo = styled.img``;
const DictionaryP = styled.p<{$cardbOn: boolean}>`
  ${Title5_Regular};
  color: ${({$cardbOn}) => ($cardbOn ? colors.Icon_Yellow : colors.Cool_Grey)};
`;
