### 🔧 업데이트 필요

- 앱 이름 표시 한글로
- 모바일 앱 이름 표시 통일
- 일요일도 알림이 오는 현상 체크
- 온보딩이 좌상단에서 점점 커지면서 등장하는 이슈 
- 시작 시작을 움직여 종료시간을 민 후완료버튼을 누르면 폭파

</br>

### 🚦 업데이트 검토

- 알림 주기 조정(자주 받고 싶다는 의견)
- 알림 설정 버튼 영역 설정(현: 상태창 전체)
- 하루만 알림 끄기 버튼 활성화시 상태창 가릴지 여부
(알림끄기와 알림주기 설정은 서로 관계가 없는데 비활성화를 시켜버리면 그 상태에서는 알림주기도 확인할 수 없고, 알림주기를 변경시키려면 다시 알림을 켜야한다)
- 영어 버전
- 워치페이스 설정(NotificationSettingCell?)

</br>

### 🪄 리팩토링 아이디어
- 요일과 관련된 데이터 (settings.selectedDays, settings.selectedDaysInt) property wrapper로 만들기 [참고](https://zeddios.tistory.com/1221)
- 리팩토링의 필요성: 
  - 현재 요일을 건드리는 로직에서 두 가지 Int 값이 섞여 있다: settings.selectedDays 배열의 인덱스, 알림이 인식하는 weekday 값 (일:1,월:2,화:2...)
  - Int 값이 헷갈리고 로직이 직관적이지 못함 -> 디버깅이 어려워짐
  - property wrapper를 사용함으로써 이와 같은 현상을 개선하고 요일을 표현/조작하는 방법을 통일하면 좋을 것 같다.
  - 로직 예시: 요일 할당과 재할당 부분
<img width="400" alt="Screenshot 2023-08-27 at 5 51 00 PM" src="https://github.com/lianne-b/filmFilter/assets/89244357/604219e9-cc86-428e-a26e-9f7b7e8613f6">
