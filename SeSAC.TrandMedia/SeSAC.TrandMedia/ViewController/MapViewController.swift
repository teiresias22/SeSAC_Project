import UIKit
import MapKit
import CoreLocation
import CoreLocationUI

class MapViewController: UIViewController {

    @IBOutlet weak var movieTheatherLocationTitle: UILabel!
    @IBOutlet weak var movieTheatherFilter: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var previousLocation: CLLocation?
    
    var mapAnnotations: TheaterLocation?
    let theather = theatherInformation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        
        checkUserLocationServicesAithorization()
        
        movieTheatherLocationTitle.text = "영화관 정보"
        movieTheatherLocationTitle.textAlignment = .center
        movieTheatherFilter.setTitle("Filter", for: .normal)
    }
    
    //필터 버튼 클릭시 alert 띄우기
    @IBAction func movieTheatherFilterButton(_ sender: UIButton) {
        showAlert(alertTitle: "원하는 영화관 찾기", alertMessage: "찾는 브랜드의 영화관이 있나요?")
    }
    
    func showAlert(alertTitle: String, alertMessage: String) {
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let cgv = UIAlertAction(title: "CGV", style: .default) { _ in
            self.theatherAnnotations("CGV")
            self.movieTheatherLocationTitle.text = "CGV"
        }
        let megaBox = UIAlertAction(title: "메가박스", style: .default) { _ in
            self.theatherAnnotations("메가박스")
            self.movieTheatherLocationTitle.text = "메가박스"
        }
        let lotte = UIAlertAction(title: "롯데시네마", style: .default) { _ in
            self.theatherAnnotations("롯데시네마")
            self.movieTheatherLocationTitle.text = "롯데시네마"
        }
        let allTheater = UIAlertAction(title: "모든 극장", style: .cancel) { _ in
            self.allAnnotations()
            self.movieTheatherLocationTitle.text = "모든 극장"
        }
        
        alert.addAction(cgv)
        alert.addAction(megaBox)
        alert.addAction(lotte)
        alert.addAction(allTheater)
        
        present(alert, animated: true)
    }
    
    //MapSetting
    //1. 위치 서비스 확인, 14이전 버전 확인
    func checkUserLocationServicesAithorization() {
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14, *) {
            authorizationStatus = locationManager.authorizationStatus // iOS 14 이상
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus() // iOS 14 미만
        }
        //iOS 위치 서비스 확인
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            //권한 상태 확인 및 권한 요청 가능 (8번 메서드 실행)
            checkLocationAuthorization(authorizationStatus)
        } else {
            print("iOS 위치 서비스를 켜주세요.")
        }
    }
    
    //2. 위치 확인
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    //3. 권환 확인, 사용자가 위치를 허용했는지, 안했는지, 거부한건지 권한 확인! (단, iOS 위치 서비스가 가능한지 확인)
    func checkLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            print("GPS 권한 설정됨")
            startTrakingUserLocation() //사용자 위치

        case .notDetermined:
            print("GPS 권한 설정되지 않음")
            setupLocationManager()
            
        case .denied, .restricted:
            print("GPS 권한 요청 거부됨")
            
            //권한 요청 알람 띄우기
                    
        default:
            print("GPS Default")
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
    
    //권한 비허용시 기본화면
    func defaultLocation() {
        let location = CLLocationCoordinate2D(latitude: 37.51235719303268, longitude: 127.05875237509075)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = "메가박스 코엑스"
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
    }
    
    //권한 허용시 사용자 위치 업데이트
    func startTrakingUserLocation() {
        mapView.showsUserLocation = true //현위치
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation() //움직일때마다 현위치 업데이트
        previousLocation = getCenterLocation(for: mapView)
    }
    
    //현재 위치 반영
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 100, longitudinalMeters: 100)
            mapView.setRegion(region, animated: true)
        }
    }
    
    //사용자 위치 가져오기
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        getCurrentAddress(CLLocation(latitude: latitude, longitude: longitude))
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    //현재 위치 주소
    func getCurrentAddress(_ location: CLLocation) {
        let geoCoder: CLGeocoder = CLGeocoder()
        let location: CLLocation = location
        //한국어 주소 설정
        let locale = Locale(identifier: "KO-kr")
        
        //위경도를 통해 주소 변환
        geoCoder.reverseGeocodeLocation(location, preferredLocale: locale) { placemarks, error in
            guard error == nil, let placemark = placemarks?.first else {
                print("주소 설정 불가능")
                return
            }
            DispatchQueue.main.async {
                let address = "\(placemark.administrativeArea ?? "") \(placemark.locality ?? "") \(placemark.subThoroughfare ?? "") \(placemark.thoroughfare ?? "")"
                self.title = address
            }
        }
    }
    
    //핀정보 모든핀
    func allAnnotations() {
        let annotiations = mapView.annotations
        mapView.removeAnnotations(annotiations)
        
        for location in theather.mapAnnotations {
            let theatherCoordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitudr)
            let theatherAnnotaion = MKPointAnnotation()
            
            theatherAnnotaion.title = location.location
            theatherAnnotaion.coordinate = theatherCoordinate
            mapView.addAnnotation(theatherAnnotaion)
        }
    }
    
    //핀정보 극장별핀
    func theatherAnnotations(_ type: String) {
        let annotiations = mapView.annotations
        mapView.removeAnnotations(annotiations)
        
        for location in theather.mapAnnotations {
            if location.type == type {
                let theatherCoordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitudr)
                let theatherAnnotaion = MKPointAnnotation()
                
                theatherAnnotaion.title = location.location
                theatherAnnotaion.coordinate = theatherCoordinate
                mapView.addAnnotation(theatherAnnotaion)
            }
        }
    }


}
extension MapViewController: CLLocationManagerDelegate{
    //사용자가 위치 허용을 한 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        mapView.setRegion(region, animated: true)
        allAnnotations()
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
        print("Go")
    }
}
