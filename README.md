# 악취 분석 서비스 - N.C.SENSOR 

<img src="https://github.com/user-attachments/assets/705363ba-ff2c-4f47-b612-0fd4d26c1ff8" width=50%>
<img src="https://github.com/user-attachments/assets/a28a8e37-cc02-465a-a264-c60f556901e2" width=10%>
<br><br>

태성환경연구소에서 기획한 악취 분석 서비스 앱 클라이언트 부분입니다.

## 개발환경
- **IDE**: <img src="https://img.shields.io/badge/Android Studio-3DDC84?style=flat-square&logo=Androidstudio&logoColor=white" height="20px"/>
- **언어**: <img src="https://img.shields.io/badge/Dart-02569B?style=flat-square&logo=Dart&logoColor=skyblue" height="20px"/>
- **플랫폼**: <img src="https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=Flutter&logoColor=skyblue" height="20px"/>
- **지원 버전**: Android 5.0 ~ Android 15 (sdk: 21~35)

## 개발 기간
- 총 개발기간: 2024 12/26 ~ 2025 2/28
- 기획 및 UI/UX 개발: 2024 12/26 ~ 2025 1/14
- 기능 개발: 2025 1/14 ~ 2025 2/13

## 주요 기능
- 항목
  - 악취 농도 측정
    - 입, 발, 겨드랑이 등의 체취 부위를 선택하여 측정
    - 측정하고나면 간단한 comment와 함께 악취 농도와 악취 수준을 알려줌
  - 음주 측정
    - 센서에 바람을 불어 혈중 알코올 농도를 측정
    - 마찬가지로 comment와 혈중 알코올 농도와 면허정지,취소 수준을 알 수 있음
  -  확장성 고려
      - 항목을 언제든 추가/삭제할 수 있도록 드롭다운 형식으로 구성
- 기록
  - 그 날 측정한 결과내용을 기록탭에서 날짜별로 확인
  - 1개월, 6개월, 1년단위로 확인 가능
- 통계
  - 확장성 고려
    - 마찬가지로 확장성을 고려하여 항목을 드롭다운형식으로 구성
  - 카드 형식
    - 상단에는 평균 악취농도/알코올농도를 알려줌
    - 중단에는 평균 농도를 그림으로 표현
    - 하단에는 지난 달과 이번 달의 바차트를 보여주고 지난 달 대비 증가/감소 퍼센트를 알려줌
