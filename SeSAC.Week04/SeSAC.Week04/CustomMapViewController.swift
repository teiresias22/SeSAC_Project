
import UIKit
import MapKit
import CoreLocation
import CoreLocationUI // iOS15 LocationButton

class CustomMapViewController: UIViewController {

    @IBOutlet weak var MKMapView: MKMapView!
    //1. CLLocationManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //지역설정
        let location = CLLocationCoordinate2D(latitude: 37.52568150137762, longitude: 126.89576901844384)
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: location, span: span)
        MKMapView.setRegion(region, animated: true)
        
        //핀 설정
        let annotation = MKPointAnnotation()
        annotation.title = "Go Here"
        annotation.coordinate = location
        MKMapView.addAnnotation(annotation)
        
        //맵뷰에 어노테이션을 삭제하고자 할 때
        let annotations = MKMapView.annotations
        MKMapView.removeAnnotations(annotations)
        
        
        MKMapView.delegate = self
        
        //2.
        locationManager.delegate = self
    }
    
    @IBAction func alertButtonClicked(_ sender: UIButton) {
        showAlert(title: "레이블 글자 변경", message: "변경할께요", okTitle: "바꾸기") {
            print("대충 변경되었다는 내용")
        }
    }
    
    @IBAction func labelChangeButtonClicked(_ sender: UIButton) {
        showAlert(title: "설정", message: "설정에서 권한을 허용해주세요", okTitle: "설정으로 이동") {
            //설정 창으로 이동
            guard let url = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url) { success in
                    print("잘 열림 \(success)")
                }
            }
        }
    }
    
    
    @IBAction func didTapLocationAccessButton(_ sender: UIButton) {
        checkUserLocationServicesAithorization()
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
extension CustomMapViewController: CLLocationManagerDelegate{
    
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

extension CustomMapViewController: MKMapViewDelegate {
    //맵 어노테이션 클릭 시 이벤트 핸들링
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("가자")
    }
}
