import React from 'react';
import * as icons from '@/assets/icons';

type IconType = keyof typeof icons;
interface IconProps {
  name: IconType;
  size: number;
}

function Icon({name, size}: IconProps) {
  const Icon = icons[name];
  return <Icon width={size} height={size} />;
}
export default Icon;
