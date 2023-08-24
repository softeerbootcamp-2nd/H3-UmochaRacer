export const getTitleByPath = (path: string) => {
  switch (path) {
    case '/self':
      return 'self';
    case '/guide':
      return 'guide';
    default:
      return 'none';
  }
};
