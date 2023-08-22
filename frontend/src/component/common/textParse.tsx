import React from 'react';
import styled, {css} from 'styled-components';
import {fetchData} from '@/api/fetchData';
import {colors} from '@/style/theme';
import {
  useCardbState,
  useCardbDispatch,
  CLICK_WORD,
  CLOSE_MODAL,
} from '@/provider/cardbProvider';

interface CardbProps {
  children: string;
  isTitle: boolean;
}

const dictionaryIcon = (fill: string) => {
  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="22"
      height="25"
      viewBox="0 0 22 25"
      fill="none"
    >
      <path
        d="M11.9154 20.691V22.2493H10.082V20.691H2.7487C2.50558 20.691 2.27242 20.6089 2.10052 20.4628C1.92861 20.3167 1.83203 20.1185 1.83203 19.9118V7.44518C1.83203 7.23854 1.92861 7.04035 2.10052 6.89423C2.27242 6.74811 2.50558 6.66602 2.7487 6.66602H8.2487C8.76899 6.66549 9.28342 6.75933 9.75764 6.94126C10.2319 7.12318 10.655 7.38902 10.9987 7.72101C11.3424 7.38902 11.7655 7.12318 12.2398 6.94126C12.714 6.75933 13.2284 6.66549 13.7487 6.66602H19.2487C19.4918 6.66602 19.725 6.74811 19.8969 6.89423C20.0688 7.04035 20.1654 7.23854 20.1654 7.44518V19.9118C20.1654 20.1185 20.0688 20.3167 19.8969 20.4628C19.725 20.6089 19.4918 20.691 19.2487 20.691H11.9154ZM18.332 19.1327V8.22435H13.7487C13.2625 8.22435 12.7962 8.38853 12.4523 8.68078C12.1085 8.97302 11.9154 9.36939 11.9154 9.78268V19.1327H18.332ZM10.082 19.1327V9.78268C10.082 9.36939 9.88888 8.97302 9.54506 8.68078C9.20124 8.38853 8.73493 8.22435 8.2487 8.22435H3.66536V19.1327H10.082Z"
        fill="black"
      />
      <rect
        x="3.66797"
        y="2.08398"
        width="1.83333"
        height="3.66667"
        rx="0.916667"
        transform="rotate(-30 3.66797 2.08398)"
        fill="black"
      />
      <rect
        width="1.83333"
        height="3.66667"
        rx="0.916667"
        transform="matrix(-0.866025 -0.5 -0.5 0.866025 18.0859 2.08398)"
        fill="black"
      />
      <rect
        x="10.082"
        y="0.25"
        width="1.83333"
        height="3.66667"
        rx="0.916667"
        fill="black"
      />
    </svg>
  );
};

function Cardb({children, isTitle}: CardbProps) {
  const cardbState = useCardbState();
  const dispatch = useCardbDispatch();

  const handleClickCardb = () => {
    if (!cardbState.cardbOn) return;
    if (cardbState.modalOpen && children === cardbState.dataObject.keyword) {
      dispatch({type: CLOSE_MODAL});
      return;
    }

    fetchData(`/cardb?keyword=${children}`).then((response) =>
      dispatch({type: CLICK_WORD, payload: {dataObject: response}}),
    );
  };

  return (
    <Wrapper
      onClick={handleClickCardb}
      $cardbOn={cardbState.cardbOn}
      $modalOn={
        cardbState.modalOpen && cardbState.dataObject.keyword === children
      }
    >
      {/* {isTitle && <IconBox>{dictionaryIcon()}</IconBox>} */}
      <TextBox>{children}</TextBox>
    </Wrapper>
  );
}

const cardbOnCss = css`
  background: ${colors.Icon_Yellow};
  cursor: pointer;
`;

const modalOnCss = css`
  background: ${colors.Cool_Grey};
  color: ${colors.Hyundai_White};
  cursor: pointer;
`;

const Wrapper = styled.div<{$cardbOn: boolean; $modalOn: boolean}>`
  display: inline-flex;
  position: relative;
  transition: 0.5s;
  border-radius: 6px;
  gap: 4px;
  ${({$cardbOn}) => $cardbOn && cardbOnCss}
  ${({$modalOn}) => $modalOn && modalOnCss}
`;

const TextBox = styled.div`
  display: inline-block;
`;

const IconBox = styled.div`
  width: 22px;
  height: 22px;
`;

export const textParse = (text: string) => {
  const parts = text.split(/(<cardb>.*?<\/cardb>)/).map((part, index) => {
    if (part.startsWith('<cardb>')) {
      const tagContent = part.replace(/<\/?cardb>/g, '');
      return (
        <Cardb key={index} isTitle={true}>
          {tagContent}
        </Cardb>
      );
    }
    return part;
  });

  return <>{parts}</>;
};
