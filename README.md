# SeSAC.TrandMedia
![R1280x0](https://user-images.githubusercontent.com/83900106/157791688-944e01fb-49db-4587-9193-d790e3771943.png)
영화와 드라마, 도서를 보여주는 앱 입니다. 국내 박스오피스를 조회할 수 있고, 검색기능을 제공합니다. 상세정보에서는 출연진 정보를 확인할 수 있습니다. 예고편을 확인해볼수 있습니다. 지도에 영화관을 표시해주며 필터링 하여 보여주기도 합니다.    

## 사용 기술 및 라이브러리
  * iOS, Swift, Storyboard, MVC, AutoLayout
  * MapKit, CoreLocation, CLAuthorizationStatus, WebKit, SearchBar, Alert, Font
  * Alamofire, Kingfisher, Realm, SwiftyJSON
  * Github, Insomnia

## 구현한 기능
  * OpenAPI를 Alamofire를 활용하여 데이터를 불러옴
  * SwiftyJSON을 활용하여 API의 JSON 데이터를 파싱
  * Realm을 활용하여 데이터를 저장하고 필터링해서 불러옴
  * StoryBoard를 활용하여 AutoLayout 화면 구현
  * XIB 파일을 활용한 Cell 제작
  * CoreLocation을 활용하여 MapKit에 사용자의 위치를 실시간 표시해주며, 지정된 위치의 Annotation을 필터링 하여 표시함
  * WebView를 활용한 영상재생

## 회고 및 이슈
### 동일한 유형의 서로 다른 API사용
  * 동일한 유형의 서로 다른  API는 요청하는 변수와, 응답 필드 값이 서로 다르기 때문에 호환하여 사용하기가 몹시 까다롭다.
  * 영화진흥위원회와 TMDB가 같은 영화의 정보를 다루고 있지만 각각의 하나의 영화에 서로 다른 고유 ID를 사용하기 때문에, 동일한 영화를 찾기 위한 요청값이 서로 달라 활용이 까다롭다.
  * 실제로 프로젝트에서 박스오피스를 보여주는 페이지에서는 영화진흥위원회의 API를, 그 밖의 페이지에서는 TMDB를 사용했기 때문에, 박스오피스에서 영화를 클릭한 경우 검색창으로 이동이 되도록 했지만, 리팩토링을 통해 상세정보 페이지에서 분기처리 하여 두가지 API 활용이 가능하도록 변경하였다.

### API키 관리
  * 프로젝트를 Github와 같은 오픈 소스 저장 서버를 이용한다면 API의 Key 노출에 주의해야 한다.
  * 노출된 Key가 악용된다면 나의 API가 막히는것 뿐만 아니라 정책에 따라 비용이 청구될수 있다.
  * Git에 Private 상태로 올려두었다가 Public으로 전환을 하는 상황에서 ignore 처리를 한다고 하더라도, 현재 기준의 Remote에서만 삭제될뿐 과거의 커밋에는 남아있기 때문에 과거의 커밋을 수정 후 재작성 해주어야 한다.

### API 콜 리미트
  * API의 콜 리밋을 대응하기 위해 정적 데이터는 Realm에 캐싱하여 사용

### Xib를 활용한 Cell의 재사용
  * TableView의 Cell은 최초 로드에서 모든 Cell을 제작하는게 아닌 보여지는 Cell만을 제작하여 재사용함

 ### ViewController의 Life - Cycle
  * ViewController의 생명주기 (Life-Cycle)는 화면에 보여졌다가 사라지는 주기는 다양하다.    
    init, loadView, viewDidLoad, viewWIllAppear, viewDidAppear, viewWillDisappear, viewDidDisappear, viewDidUnload
  * 이중 몇가지의 경우 사용에 주의를 해야 하는데,   
     init의 경우는 View를 초기화 할때 사용되며 코드로 View를 작성하거나, xib 파일을 제작할때 사용됩니다.    
     loadView의 경우 View가 메모리에 로드된 직후 호출되기 때문에 코드로 VIew를 작성한게 아니라면 호출하지 않는것이 좋다.    
     viewDidDisappear 같은 경우 View가 제거된 이후에 호출이 되기 때문에 필요없어지는 작업들을 여기서 종료시킨다.    

Link: [블로그](https://teiresias.tistory.com/10?category=926122){:target="_blank"}
