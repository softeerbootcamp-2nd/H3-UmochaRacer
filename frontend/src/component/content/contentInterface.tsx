export interface CardData {
  // Card
  colorCode?: string | undefined;
  iconSrc?: string | undefined;
  partsSrc?: string | undefined;
  optionId: number;
  name: string;
  price: number;
}

export interface cardDataType {
  // Fetch
  colorCode?: string | undefined;
  iconSrc?: string | undefined;
  partsSrc?: string | undefined;
  optionId: number;
  name: string;
  price: number;
  imageSrc: string;
}
