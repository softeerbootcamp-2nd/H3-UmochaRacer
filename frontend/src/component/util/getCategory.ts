type category = Record<number, string>;
export const getCategory = (optionNum: number) => {
  const categoryName: category = {
    0: 'powertrain',
    1: 'driving-system',
    2: 'bodytype',
    3: 'exterior-color',
    4: 'interior-color',
    5: 'wheel',
    6: 'additional-option',
  };
  return categoryName[optionNum];
};
