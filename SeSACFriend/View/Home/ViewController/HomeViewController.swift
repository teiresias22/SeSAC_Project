//
//  HomeViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/25.
//

import UIKit
import FirebaseAuth
import MapKit
import CoreLocation
import CoreLocationUI

class HomeViewController: BaseViewController {
    let mainView = HomeView()
    var viewModel = HomeViewModel()
    
    var locationManager = CLLocationManager()
    
    var myState = ""
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mainView.mapView.showsUserLocation = true
        
        genderButtonActive(mainView.allButton)
        
        mainView.allButton.addTarget(self, action: #selector(allButtonClicked), for: .touchUpInside)
        mainView.manButton.addTarget(self, action: #selector(manButtonClicked), for: .touchUpInside)
        mainView.womanButton.addTarget(self, action: #selector(womanButtonClicked), for: .touchUpInside)
        mainView.myLocationButton.addTarget(self, action: #selector(myLocationClicked), for: .touchUpInside)
        mainView.stateButton.addTarget(self, action: #selector(stateButtonClicked), for: .touchUpInside)
    }
    
    func setStateButtonImage(){
        mainView.stateButton.setImage(UIImage(named: viewModel.stateButtonIconArray[0]), for: .normal)
    }
    
    @objc func stateButtonClicked() {
        if myState == "" {
            let vc = HobbyViewController()
            vc.viewModel = self.viewModel
            self.navigationController?.pushViewController(vc, animated: true)
            print("넘어가나?")
        } else {
            print("else")
        }
    }
    
    @objc func allButtonClicked(){
        genderButtonActive(mainView.allButton)
        genderButtonDeactive(mainView.manButton)
        genderButtonDeactive(mainView.womanButton)
    }
    
    @objc func manButtonClicked(){
        genderButtonActive(mainView.manButton)
        genderButtonDeactive(mainView.allButton)
        genderButtonDeactive(mainView.womanButton)
    }
    
    @objc func womanButtonClicked(){
        genderButtonActive(mainView.womanButton)
        genderButtonDeactive(mainView.allButton)
        genderButtonDeactive(mainView.manButton)
    }
    
    @objc func myLocationClicked() {
        checkUserLocationServicesAithorization()
    }
    
    func genderButtonActive(_ target: UIButton) {
        target.backgroundColor = .customGreen
        target.setTitleColor(.customWhite, for: .normal)
    }
    
    func genderButtonDeactive(_ target: UIButton) {
        target.backgroundColor = .customWhite
        target.setTitleColor(.customBlack, for: .normal)
    }
    
    //권한 비허용시 기본화면
    func defaultLocation() {
        var location = CLLocationCoordinate2D()
        let annotation = MKPointAnnotation()
        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        location = CLLocationCoordinate2D(latitude: 37.52413651649104, longitude: 126.98001340101837)
        annotation.title = "사용자의 위치를 확인할수 없습니다."
        let region = MKCoordinateRegion(center: location, span: span)
        mainView.mapView.setRegion(region, animated: true)
        annotation.coordinate = location
        mainView.mapView.addAnnotation(annotation)
    }
    
    //위치 권한 허용 확인
    func checkUserLocationServicesAithorization() {
        let authorizationStatus: CLAuthorizationStatus
        authorizationStatus = locationManager.authorizationStatus
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization(authorizationStatus) //권한 확인
        } else {
            showAlert(alertTitle: "위치 서비스", alertMessage: "iOS 위치 서비스를 켜주세요.")
        }
    }
    
    //권환 확인
    func checkLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            //현재 위치 가져오기
            let userLocation = mainView.mapView.userLocation
            //현재 위치 기준으로 영역을 설정
            let region = MKCoordinateRegion(center: userLocation.location!.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            //맵 뷰의 영역을 설정
            mainView.mapView.setRegion(region, animated: true)
        case .notDetermined:
            print("GPS 권한 설정되지 않음")
        case .denied, .restricted:
            print("GPS 권한 요청 거부됨")
            showAlert(alertTitle: "위치 서비스", alertMessage: "iOS위치 서비스 권한 요청이 거부되어 서비스를 제공할수 없습니다.")
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
    
    //비허용시 알림창 띄우기
    func showAlert(alertTitle: String, alertMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let allTheater = UIAlertAction(title: "확인", style: .cancel) { _ in
        }
        alert.addAction(allTheater)
        present(alert, animated: true)
    }
}


// MARK: - CLLocationManagerDelegate
extension HomeViewController: CLLocationManagerDelegate{
    //사용자가 위치 허용을 한 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        moveLocation(latitudeValue: (location.coordinate.latitude), longtudeValue: (location.coordinate.longitude), delta: 0.01)
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            if let pm: CLPlacemark = placemarks?.first {
                let address: String = "\(pm.locality ?? "") \(pm.name ?? "")"
                //print("locationManager", address)
            }
        })
        locationManager.stopUpdatingLocation()
    }
    
    func moveLocation(latitudeValue: CLLocationDegrees, longtudeValue: CLLocationDegrees, delta span: Double) {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longtudeValue)
        let pSpanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: pSpanValue)
        mainView.mapView.setRegion(pRegion, animated: true)
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

// MARK: - MKMapViewDelegate
extension HomeViewController: MKMapViewDelegate {
    
}
