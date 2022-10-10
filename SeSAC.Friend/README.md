# SeSACFriend
![다운로드](https://user-images.githubusercontent.com/83900106/162383291-2447bf05-cfe6-43e3-a2a8-507b8ef93993.jpeg)
## 위치 기반 취미 공유 애플리케이션 입니다. 
    휴대전화 안증을 사용하여 회원가입 여부를 확인하고, 회원가입을 진행합니다.
    내 위치를 기반으로 주변 유저를 확인하여 취미 정보를 가져오게 됩니다.
    유저와 1:1 매칭을 요청하고 수락하여 개별 채팅을 사용할 수 있습니다.
    
## 사용 기술 및 라이브러리
  * iOS, Swift, Codebase, MVVM, AutoLayout
  * MapKit, CoreLocation, CLAuthorizationStatus, SearchBar, ToastMessage, Observable
  * Alamofire, SnapKit, SwiftyJSON, TextFieldEffects, Firebase Auth
  * Github, Figma, Swager, Confluence, Jira

## 구현한 기능
  * Firebase Auth를 활용한 휴대전화 인증
  * 최초 접속시 온보딩 페이지 표시, 온보딩 화면을 끝까지 채크하지 않은 경우 
  * MVVM 디자인 패턴을 활용하여 Codebase로 작업
  * UserDefault, APIService, Endpoint등을 모듈화 하여 사용
  * Data Binding을 위한 Observable 활용
  * DispatchQueue를 활용하여 global과 main, sync와 async를 활용
  * 모든 ViewController는 BaseViewController를 상속하게 되며, BaseViewController는 touchBegan과, endEditing, 그리고 toastMessage의 기능을 갖고 있음.

## 회고 및 이슈
### 협업
  * Confluence를 활용하여 기획서, API명세서를 백앤드와 공유
  * Figma를 활용하여 디자이너와 시안 공유
  * Jira를 활용하여 워크플로우 공유

### MVVM
  * Model, View, ViewModel을 활용한 디자인 패턴 사용
  * Data Binding을 위한 Observable 활용

### FMC Token 갱신
  * FMC Token을 갱신하는 것은 여러 페이지에서 필요하지만 지금은 필요한 페이지마다 코드 작업을 해주었는데, BaseViewController에 별도의 ViewModel을 연결하여 사용하는 방식을 사용했다면 코드가 더 단순화 되었을것

### 모듈화
  * UserDefault, APIService, Endpoint, Case들은 설정을 해두고 후에 시간이 지나서 잊는 경우가 많기 때문에 별도의 페이지에서 통합하여 관리

### 재사용
  * Button, TextField등 여러 페이지에서 동일하게 사용되는 객체는 Custom으로 제작하여 재사용

### API 응답 코드 처리
  * Enum을 활용하여 API 상태코드 처리
    * 개발 초기에는 Enum을 활용하지 않고 처리 했으나, 프로젝트를 진행하는 도중 API의 상태코드가 변경되는 일이 발생했을때, 상태코드 변경에 어려움을 겪은 후 Enum을 활용하여 상태코드를 관리
