import {Option} from '@/provider/selectedOptionProvider';
import {cardDataType} from '../content/contentInterface';
const DEFAULT_PRICE = 43460000;
export const getTotalPrice = (
  selectedOptions: Option[],
  tempOption: Option,
  additionOptions: cardDataType[],
  selectedAdditionalOption: cardDataType[],
) => {
  let totalPrice = DEFAULT_PRICE;
  let copyOption = selectedOptions.slice();

  if (tempOption !== null) {
    copyOption = copyOption.map((elem) => {
      if (elem.key === tempOption.key) {
        return tempOption;
      } else {
        return elem;
      }
    });
  }
  copyOption.map((elem) => {
    totalPrice += elem.price;
  });
  const totAdditionalOptions = [
    ...additionOptions,
    ...selectedAdditionalOption,
  ];
  const additionalOptions = totAdditionalOptions.filter(
    (value, index, self) =>
      self.findIndex((item) => item.id === value.id) === index,
  );
  additionalOptions.sort((a, b) => a.id - b.id);
  additionOptions.forEach((elem) => {
    totalPrice += elem.price;
  });
  return totalPrice;
};
