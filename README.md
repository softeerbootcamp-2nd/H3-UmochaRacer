# 📖 현대 소프티어 부트캠프 3조 UmochaRacer
<table>
 <tr>
    <td>프로젝트 기간</td>
    <td>2023년 7월 31일 ~ 2023년 8월 30일</td>
  </tr>
</table>
<br/>

## 👦 팀원 소개
<table style="border: 0.5px solid gray">
 <tr>
    <td align="center"><a href="https://github.com/westofsky"><img src="https://avatars.githubusercontent.com/westofsky" width="130px;" alt=""></td>
    <td align="center" style="border-right : 0.5px solid gray"><a href="https://github.com/JungHun98"><img src="https://avatars.githubusercontent.com/JungHun98" width="130px;" alt=""></td>
    <td align="center"><a href="https://github.com/eigen98"><img src="https://avatars.githubusercontent.com/eigen98" width="130px;" alt=""></td>
    <td align="center" style="border-right : 0.5px solid gray"><a href="https://github.com/sangyeon3"><img src="https://avatars.githubusercontent.com/sangyeon3" width="130px;" alt=""></td>
    <td align="center"><a href="https://github.com/SEONMl"><img src="https://avatars.githubusercontent.com/SEONMl" width="130px;" alt=""></td>
    <td align="center"><a href="https://github.com/jjy0709"><img src="https://avatars.githubusercontent.com/jjy0709" width="130px;" alt=""></td>
  </tr>
  <tr>
    <td align="center"><a href="https://github.com/westofsky"><b>배성준</b></td>
    <td align="center"style="border-right : 0.5px solid gray"><a href="https://github.com/JungHun98" ><b>김정훈</b></td>
    <td align="center"><a href="https://github.com/eigen98"><b>고정민</b></td>
    <td align="center" style="border-right : 0.5px solid gray"><a href="https://github.com/sangyeon3"><b>변상연</b></td>
    <td align="center"><a href="https://github.com/SEONMl"><b>박선미</b></td>
    <td align="center" style="border-right : 0.5px solid gray"><a href="https://github.com/jjy0709" ><b>정지영</b></td>
  </tr>

  <tr>
    <td align = "center" colspan = "2" style="border-right : 0.5px solid gray">FE</td>
    <td align = "center" colspan = "2" style="border-right : 0.5px solid gray">IOS</td>
    <td align = "center" colspan = "2">BE</td>
  </tr>
</table>
<br/>


## 🔍 협업 전략

### **Git Flow**

1. 새로운 기능 추가 시 `develop` 브랜치에서 `feature` 브랜치 생성 (`main` 아님)
2. 작업 완료 시, `feature` 에서 `develop` 브랜치로 PR
3. Version을 출시할 때는 `main` 브랜치에 버전 태그를 추가

### Branch Convention

**Branch Category**

- main: 제품으로 출시될 수 있는 브랜치
- develop : 다음 출시 버전을 개발하는 브랜치
- feature : 기능을 개발하는 브랜치
    - 네이밍 : feature/파트/{feature name}
    - ex. feature/ios/login
    - ex. feature/frontend/login
    - 해당 기능 구현 시 PR 후 브랜치 제거
    - 중간 중간 PR 보내기

<details>
<summary><h2>🐷 그라운드룰</h2></summary>

- 욕하지 않기
- 지각하지 않기.
- 스프린트로 진행하기(1주일 단위)
- 회의 내용은 노션에 기록
- 칭찬과 격려하기
- 질문할때 한번쯤은 구글링 해보고 질문하기
- 에러 있을 때 최대한 예쁘게 말하기

- 스크럼은 오전 10시에 시작한다.
    - 팀의 진행 상태를 공유한다.
        - 파트별 전날 한거, 오늘 할거.
    - 컨디션을 공유한다.

- 회고 방식
    - 5F 회고
        - Facts : 사실. 무슨 일이 있었는가?
        - Feeling : 느낀 점, 감정. 어떤 느낌이 들었는가?
        - Finding : 배운 점, 인사이트. 어떤 것을 기억하고 싶은가?
        - Future Action : 향후 액션 아이템. 앞으로 무엇을 할 것인지?
        - Feedback : 피드백. Future Action에서 정한 액션 아이템을 실행하고 어던 피드백을 받았는가?

</details>

## 📖 Wiki

[Wiki 링크](https://github.com/softeerbootcamp-2nd/H3-UmochaRacer/wiki)

## 👩‍🎨 기획 및 디자인

[기획 및 디자인 링크](https://www.figma.com/file/aTK27d8JGjSAp8qttQSwgy/Oh%2C-my-car-set_Handoff?type=design&node-id=0-1&mode=design&t=dQfXEfryUoqLUiNQ-0)

## 👨‍💻 회의록

[노션 회의록](https://coral-mice-402.notion.site/a723fd11e9a04cc6ae582012c8381e70?v=0dbfc16570224d7e8f0cf5d77c053e4d&pvs=4)

## 📕 Template

### commit 컨벤션


| 태그     | 설명                                                             |
|----------|------------------------------------------------------------------|
| feat     | 새로운 기능을 추가                                               |
| fix      | 버그 수정 및 기능 수정                                           |
| design   | CSS, 스타일 등 사용자 UI 디자인                                  |
| rename   | 변수명, 함수명 수정                                              |
| remove   | 파일을 삭제하는 작업만 수행한 경우                                 |
| comment  | 필요한 주석 추가 및 변경                                          |
| hotfix   | 급하게 치명적인 버그를 고쳐야 하는 경우                           |
| docs     | 문서 수정                                                        |
| chore    | 빌드 업무 수정, 패키지 매니저 수정, 패키지 관리자 구성 등 업데이트, Production Code 변경 없음 |

- commit 형식 : `Tag: Commit Message (#Issue Number)` 
- ex) `feat: 로그인 기능 구현 (#1)`

<br/>

### PR 작성법

```
## PR 작성 전 체크 리스트
- PR 제목: `[파트이름] 구현사항 어쩌구 저쩌구` (예: `[FE] Login page UI 구현` )
- PR 작성 후 충돌이 안 나는지 확인, merge후 branch 삭제
- 고민사항은 공유하기
- 위 사항 확인 후 내용 지우기~~

## 🔖 관련 이슈
- `#1` ( #이슈번호 )

## 📝 구현 사항
- 한 것들 적기

## 📌 하고싶은 말
- 같은 파트원에게 하고싶은 말
```

### Issue 작성법

```
## 🤖 title

## 💭 detail  
- [ ]
- [ ]

## reference (optional)

## ⏰ 예상 소요 기간  
8시간
```

