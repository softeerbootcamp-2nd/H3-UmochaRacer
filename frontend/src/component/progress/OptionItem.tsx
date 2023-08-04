import React from 'react';
import styled from 'styled-components';
import {colors} from '../../style/theme';
import progress_selected from '../../assets/icons/progress_selected.svg';
interface OptionItemProps {
  idx: number;
  menuName: string;
  selected: boolean;
}

function OptionItem({idx, menuName, selected}: OptionItemProps) {
  return (
    <Wrapper>
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
`;
const Option = styled.p<{selected: boolean}>`
  color: ${(props) =>
    props.selected ? colors.Main_Hyundai_Blue : colors.Cool_Grey_002};
  font-family: 'Title5_Medium';
  font-style: normal;
  font-display: swap;
  line-height: 130%;
  letter-spacing: -3%;
  font-size: 14px;
  font-weight: 500;
`;
const SelectedIcon = styled.img`
  position: absolute;
  bottom: -18px;
  left: 50%;
  transform: translateX(-50%);
`;
