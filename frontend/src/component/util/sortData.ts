const trimOrder = [
  "Exclusive",
  "Le Blanc",
  "Prestige",
  "Calligraphy"
];
type Option = {
  imageSrc: string;
  name: string;
};

type TrimData = {
  trim: string;
  sources: Option[];
};
export function sortData(data: TrimData[]): TrimData[] {
  return data.sort((a, b) => {
    const orderA = trimOrder.indexOf(a.trim);
    const orderB = trimOrder.indexOf(b.trim);

    if (orderA < orderB) return -1;
    if (orderA > orderB) return 1;
    return 0;
  });
}
