import React from 'react';
import styled from 'styled-components';
import {Link} from 'react-router-dom';
import {flexCenter} from '../style/common';
function Main() {
  return (
    <Container>
      <Link to="/self">self로 이동</Link>
    </Container>
  );
}

export default Main;
const Container = styled.div`
  height: 100vh;
  ${flexCenter};
`;
