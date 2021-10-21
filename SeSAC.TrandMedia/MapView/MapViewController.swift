import UIKit
import MapKit
import CoreLocation
import CoreLocationUI

class MapViewController: UIViewController {

    @IBOutlet weak var movieTheatherLocationTitle: UILabel!
    @IBOutlet weak var movieTheatherFilter: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var mapAnnotations: TheaterLocation?
    let movieInformation = theatherInformation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultMapViewSetting()
        
        //맵뷰에 어노테이션을 삭제하고자 할 때
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        
        mapView.delegate = self
        locationManager.delegate = self
        
        checkUserLocationServicesAithorization()
        
        movieTheatherLocationTitle.text = "영화관 정보"
        movieTheatherFilter.setTitle("필터", for: .normal)
    }
    
    //필터 버튼 클릭시 alert 띄우기
    @IBAction func movieTheatherFilterButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "원하는 영화관이 있나요?", message: "원하는 극장 브랜드로 찾아보세요", preferredStyle: UIAlertController.Style.alert)
        
        let cgv = UIAlertAction(title: "CGV", style: .default)
        let megabox = UIAlertAction(title: "메가박스", style: .default)
        let lotte = UIAlertAction(title: "롯데시네마", style: .default)
        let all = UIAlertAction(title: "전체보기", style: .destructive)
        
        alert.addAction(cgv)
        alert.addAction(megabox)
        alert.addAction(lotte)
        alert.addAction(all)
        present(alert, animated: false, completion: nil)
    }
    
    func defaultMapViewSetting() {
        let location = CLLocationCoordinate2D(latitude: 37.51235719303268, longitude: 127.05875237509075)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = "메가박스 코엑스"
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
    }
    
    //9. iOS버전에 따른 분기 처리와 iOS 위치 서비스 여부 확인
    func checkUserLocationServicesAithorization() {
        let authorizationStatus: CLAuthorizationStatus
        if #available(iOS 14, *) {
            authorizationStatus = locationManager.authorizationStatus // iOS 14 이상
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus() // iOS 14 미만
        }
        //iOS 위치 서비스 확인
        if CLLocationManager.locationServicesEnabled() {
            //권한 상태 확인 및 권한 요청 가능 (8번 메서드 실행)
            checkCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("iOS 위치 서비스를 켜주세요.")
        }
    }
    
    //8. 사용자의 권한 상태 확인(UDF: 사용자 정의 함수로 프로토콜 내 메서드가 아님!!)
    //사용자가 위치를 허용했는지, 안했는지, 거부한건지 권한 확인! (단, iOS 위치 서비스가 가능한지 확인)
    func checkCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization() //앱을 사용하는 동안에 대한 위치 권한 요청
            locationManager.startUpdatingLocation() //위치 접근 시작
        case .restricted, .denied:
            print("DENIED, 설정으로 유도")
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation() //위치 접근 시작
        case .authorizedAlways:
            print("Always")
        @unknown default:
            print("Default")
        }
        if #available(iOS 14.0, *) {
            let accurancyState = locationManager.accuracyAuthorization
            
            switch accurancyState {
            case .fullAccuracy:
                print("FULL")
            case .reducedAccuracy:
                print("REDUCE")
            @unknown default:
                print("DEFAULT")
            }
        }
    }
    
    func getCurrentAddress(_ location: CLLocation) {
        let geoCoder: CLGeocoder = CLGeocoder()
        let location: CLLocation = location
        //한국어 주소 설정
        let locale = Locale(identifier: "KO-kr")
        //위경도를 통해 주소 변환
        geoCoder.reverseGeocodeLocation(location, preferredLocale: locale, completionHandler: {
            (placemark, error) -> Void in
            guard error == nil, let place = placemark?.first else{
                print("주소 설정 불가능")
                return
            }
            if let administrativeArea = place.administrativeArea {
                print(administrativeArea)
            }
            if let locality = place.locality {
                print(locality)
            }
            if let subLocality = place.subLocality {
                print(subLocality)
            }
            if let subThoroughfare = place.subThoroughfare {
                print(subThoroughfare)
            }
        })
    }

}
//3
extension MapViewController: CLLocationManagerDelegate{
    
    //4. 사용자가 위치 허용을 한 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        if let coordinate = locations.last?.coordinate {
            print(coordinate.latitude)
            print(coordinate.longitude)
            getCurrentAddress(CLLocation(latitude: coordinate.longitude, longitude: coordinate.longitude))
            locationManager.stopUpdatingLocation()
        }
    }
    
    //5. 위치 접근이 실패했을 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    //6. iOS14 미만: 앱이 위치 관리자를 생성하고,  승인 상태가 변경이 될 때 대리자에게 승인 상채를 알려줌
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
    }
    
    //7. iOS14 이상: 앱이 위치 관리자를 생성하고,  승인 상태가 변경이 될 때 대리자에게 승인 상채를 알려줌
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
    }
}

extension MapViewController: MKMapViewDelegate {
    //맵 어노테이션 클릭 시 이벤트 핸들링
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("가자")
    }
}

