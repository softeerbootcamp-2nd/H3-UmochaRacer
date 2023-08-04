import {css, createGlobalStyle} from 'styled-components';

/* 폰트 파일 경로 */
const fontPaths = {
  headMedium: '/src/assets/fonts/HyundaiSansHeadKROTFMedium.woff2',
  headRegular: '/src/assets/fonts/HyundaiSansHeadKROTFRegular.woff2',
  textMedium: '/src/assets/fonts/HyundaiSansTextKROTFMedium.woff2',
  textRegular: '/src/assets/fonts/HyundaiSansTextKROTFRegular.woff2',
};
/* 공통 폰트 스타일 */
const commonFontStyle = css`
  font-style: normal;
  font-display: swap;
  line-height: 130%;
  letter-spacing: -3%;
`;
const GlobalStyle = createGlobalStyle`
  html,
  body,
  div,
  span,
  applet,
  object,
  iframe,
  h1,
  h2,
  h3,
  h4,
  h5,
  h6,
  p,
  blockquote,
  pre,
  a,
  abbr,
  acronym,
  address,
  big,
  cite,
  code,
  del,
  dfn,
  em,
  img,
  ins,
  kbd,
  q,
  s,
  samp,
  small,
  strike,
  strong,
  sub,
  sup,
  tt,
  var,
  b,
  u,
  i,
  center,
  dl,
  dt,
  dd,
  ol,
  ul,
  li,
  fieldset,
  form,
  label,
  legend,
  table,
  caption,
  tbody,
  tfoot,
  thead,
  tr,
  th,
  td,
  article,
  aside,
  canvas,
  details,
  embed,
  figure,
  figcaption,
  footer,
  header,
  hgroup,
  menu,
  nav,
  output,
  ruby,
  section,
  summary,
  time,
  mark,
  audio,
  video {
    margin: 0;
    padding: 0;
    border: 0;
    font-size: 100%;
    vertical-align: baseline;
  }
  article,
  aside,
  details,
  figcaption,
  figure,
  footer,
  header,
  hgroup,
  menu,
  nav,
  section {
    display: block;
  }
  body {
    line-height: 1;
  }
  ol,
  ul {
    list-style: none;
  }
  blockquote,
  q {
    quotes: none;
  }
  blockquote:before,
  blockquote:after,
  q:before,
  q:after {
    content: "";
    content: none;
  }
  table {
    border-collapse: collapse;
    border-spacing: 0;
  }
  a {
    text-decoration: none;
    color: inherit;
  }
  button {
    padding: 0;
    background: none;
    border: 0;
    cursor: pointer;
    color: inherit;
  }
  * {
    box-sizing: border-box;
  }
  @font-face {
    font-family: 'Title1_Medium';
    font-size: 22px;
    font-weight: 500;
    ${commonFontStyle}
    src: url(${fontPaths.headMedium}) format('woff2'); 
  }
  @font-face {
    font-family: 'Title2_Medium';
    font-size: 20px;
    font-weight: 500;
    ${commonFontStyle}
    src: url(${fontPaths.headMedium}) format('woff2'); 
  }
  @font-face {
    font-family: 'Title3_Medium';
    font-size: 18px;
    font-weight: 500;
    ${commonFontStyle}
    src: url(${fontPaths.headMedium}) format('woff2'); 
  }
  @font-face {
    font-family: 'Title3_Regular';
    font-size: 18px;
    font-weight: 400;
    ${commonFontStyle}
    src: url(${fontPaths.headRegular}) format('woff2'); 
  }
  @font-face {
    font-family: 'Title4_Medium';
    font-size: 16px;
    font-weight: 500;
    ${commonFontStyle}
    src: url(${fontPaths.headMedium}) format('woff2'); 
  }
  @font-face {
    font-family: 'Title4_Regular';
    font-size: 16px;
    font-weight: 400;
    ${commonFontStyle}
    src: url(${fontPaths.headRegular}) format('woff2'); 
  }
  @font-face {
    font-family: 'Title5_Medium';
    font-size: 14px;
    font-weight: 500;
    ${commonFontStyle}
    src: url(${fontPaths.headMedium}) format('woff2'); 
  }
  @font-face {
    font-family: 'Title5_Regular';
    font-size: 14px;
    font-weight: 400;
    ${commonFontStyle}
    src: url(${fontPaths.headRegular}) format('woff2'); 
  }
  @font-face {
    font-family: 'Title6_Regular';
    font-size: 12px;
    font-weight: 400;
    ${commonFontStyle}
    src: url(${fontPaths.headRegular}) format('woff2'); 
  }
  @font-face {
    font-family: 'Body1_Medium';
    font-size: 16px;
    font-weight: 500;
    ${commonFontStyle}
    src: url(${fontPaths.textMedium}) format('woff2'); 
  }
  @font-face {
    font-family: 'Body1_Regular';
    font-size: 16px;
    font-weight: 400;
    ${commonFontStyle}
    src: url(${fontPaths.textRegular}) format('woff2'); 
  }
  @font-face {
    font-family: 'Body2_Medium';
    font-size: 14px;
    font-weight: 500;
    ${commonFontStyle}
    src: url(${fontPaths.textMedium}) format('woff2'); 
  }
  @font-face {
    font-family: 'Body2_Regular';
    font-size: 14px;
    font-weight: 400;
    ${commonFontStyle}
    src: url(${fontPaths.textRegular}) format('woff2'); 
  }
  @font-face {
    font-family: 'Body3_Medium';
    font-size: 12px;
    font-weight: 500;
    ${commonFontStyle}
    src: url(${fontPaths.textMedium}) format('woff2'); 
  }
  @font-face {
    font-family: 'Body3_Regular';
    font-size: 12px;
    font-weight: 400;
    ${commonFontStyle}
    src: url(${fontPaths.textRegular}) format('woff2'); 
  }
  @font-face {
    font-family: 'Popup_Regular';
    font-size: 14px;
    font-weight: 400;
    font-style: normal;
    font-display: swap;
    line-height: 150%;
    letter-spacing: -3%;
    src: url(${fontPaths.textRegular}) format('woff2'); 
  }
`;

export default GlobalStyle;
