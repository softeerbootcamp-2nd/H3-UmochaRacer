import React from 'react';
import styled from 'styled-components';
import Hyundai_Logo from '@/assets/logo/Hyundai_Logo.png';
import {useModalContext} from '@/provider/modalProvider';
function Logo() {
  const {openModal} = useModalContext();
  const handleClickLogo = () => {
    if (window.location.pathname !== '/') {
      openModal('exit');
    }
  };
  return (
    <Wrapper onClick={() => handleClickLogo()}>
      <HLogo src={Hyundai_Logo} />
    </Wrapper>
  );
}

export default Logo;
const Wrapper = styled.div`
  cursor: pointer;
`;
const HLogo = styled.img`
  width: 149px;
  height: auto;
`;
