export interface GridData {
  comment: string;
  category: string[];
}

export interface SelectData {
  age?: number;
  gender?: number;
  option: string[];
}

export const gridData: GridData[] = [
  {
    comment: '내 차는 이런 부분에서 강했으면 좋겠어요',
    category: ['주행력', '소음', '효율', '파워'],
  },
  {
    comment: '나는 차를 탈 때 이런게 중요해요',
    category: ['디자인', '차량보호', '온도 조절', '건강', '신기술', '안전'],
  },
  {comment: '나는 차를 이렇게 활용하고 싶어요', category: ['차박', '가족여행']},
];

export const selectData: SelectData = {
  age: undefined,
  gender: undefined,
  option: [],
};
