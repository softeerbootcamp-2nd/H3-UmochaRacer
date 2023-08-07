import React from 'react';
import styled from 'styled-components';
import {colors} from '@/style/theme';
import progress_selected from '@/assets/icons/progress_selected.svg';
import {Title5_Regular} from '@/style/fonts';
interface OptionItemProps {
  idx: number;
  menuName: string;
  selected: boolean;
  onClick: () => void;
}

function OptionItem({idx, menuName, selected, onClick}: OptionItemProps) {
  const handleClick = () => {
    onClick();
  };

  return (
    <Wrapper onClick={handleClick}>
      <Option selected={selected}>
        0{idx + 1} {menuName}
      </Option>
      {selected && <SelectedIcon src={progress_selected} />}
    </Wrapper>
  );
}

export default OptionItem;

const Wrapper = styled.div`
  position: relative;
  height: 100%;
`;
const Option = styled.p<{selected: boolean}>`
  color: ${(props) =>
    props.selected ? colors.Main_Hyundai_Blue : colors.Cool_Grey_002};
  ${Title5_Regular};
  cursor: pointer;
`;
const SelectedIcon = styled.img`
  position: absolute;
  bottom: -2px;
  left: 50%;
  transform: translateX(-50%);
`;
