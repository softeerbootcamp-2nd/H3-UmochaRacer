import React from 'react';
import styled from 'styled-components';
import Hyundai_Logo from '../../../assets/logo/Hyundai_Logo.png';
function Logo() {
  return (
    <Wrapper>
      <HLogo src={Hyundai_Logo} />
    </Wrapper>
  );
}

export default Logo;
const Wrapper = styled.div``;
const HLogo = styled.img`
  width: 149px;
  height: auto;
`;
