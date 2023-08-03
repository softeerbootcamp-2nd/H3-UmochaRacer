module.exports = {
  root: true,
  env: {browser: true, es2016: true},
  extends: [
    'eslint:recommended',
    'plugin:@typescript-eslint/recommended',
    'plugin:react-hooks/recommended',
  ],
  ignorePatterns: ['dist', '.eslintrc.cjs'],
  parser: '@typescript-eslint/parser',
  plugins: ['react-refresh'],
  rules: {
    'react-refresh/only-export-components': [
      'warn',
      {allowConstantExport: true},
    ],
    eqeqeq: 'error',
    'no-var': 'error',
    'no-unused-vars': 'warn',
    'no-extra-semi': 'error',
  },
};
