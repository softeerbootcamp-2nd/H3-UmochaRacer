import React, {useState} from 'react';
import styled from 'styled-components';
import ProgressIndicator from './ProgressIndicator';
import {useNavigate} from 'react-router-dom';

const loadingTextArr = [
  '엔진 장착 중. . .',
  '도색하는 중. . .',
  '옵션 장착 중. . .',
];

const doneTextArr = ['엔진 장착 완료!', '도색완료!', '옵션 장착 완료!'];

function Bottom() {
  const [activeLevel, setActiveLevel] = useState(0);
  const nevigate = useNavigate();

  const indicators: React.JSX.Element[] = loadingTextArr.map(
    (elem: string, index: number) => {
      let onAnimationEnd;

      if (index < loadingTextArr.length - 1) {
        onAnimationEnd = () => {
          setActiveLevel(activeLevel + 1);
        };
      } else {
        onAnimationEnd = () => {
          setTimeout(() => {
            nevigate('/');
          }, 1000);
        };
      }

      return (
        <ProgressIndicator
          key={index}
          isActive={activeLevel >= index}
          loadingText={elem}
          doneText={doneTextArr[index]}
          onAnimationEnd={onAnimationEnd}
        ></ProgressIndicator>
      );
    },
  );
  return <Wrapper>{indicators}</Wrapper>;
}

export default Bottom;

const Wrapper = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  width: 126px;
  height: 106px;
  margin: 0 auto;
`;
