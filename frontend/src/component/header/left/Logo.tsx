import React from 'react';
import styled from 'styled-components';
import Hyundai_Logo from '@/assets/logo/Hyundai_Logo.png';
import {Link} from 'react-router-dom';
function Logo() {
  return (
    <Wrapper>
      <Link to="/">
        <HLogo src={Hyundai_Logo} />
      </Link>
    </Wrapper>
  );
}

export default Logo;
const Wrapper = styled.div``;
const HLogo = styled.img`
  width: 149px;
  height: auto;
`;
