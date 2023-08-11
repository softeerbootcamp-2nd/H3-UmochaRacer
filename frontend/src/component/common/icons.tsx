import React from 'react';
import * as icons from '@/assets/icons';

export type IconType = keyof typeof icons;
interface IconProps {
  name: IconType;
  size?: number | 'auto'; // size 프로퍼티는 number 또는 'auto' 값을 가질 수 있도록 변경
}

function Icon({name, size = 'auto'}: IconProps) {
  const Icon = icons[name];

  if (size === 'auto') {
    return <Icon />;
  }

  return <Icon width={size} height={size} />;
}
export default Icon;
