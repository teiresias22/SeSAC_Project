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
    var runTimeInterval: TimeInterval?
    let mTimer: Selector = #selector(Tick_TimeConsole)
    
    var manAnnotations: [CustomAnnotation] = []
    var womanAnnotations: [CustomAnnotation] = []
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkMyStatus()
        searchFriends()
        
        self.viewModel.getUserInfo { userInfo, statuscode, error in
            guard let userInfo = userInfo else {
                return
            }
            DispatchQueue.main.async {
                if userInfo.fcMtoken != UserDefaults.standard.string(forKey: UserDefault.FCMToken.rawValue) {
                    self.updateFCMToken(newFCMToken: UserDefaults.standard.string(forKey: UserDefault.FCMToken.rawValue)!)
                }
            }
        }
        
        viewModel.myStatus.bind {
            switch $0 {
            case MyStatusCase.matching.rawValue:
                self.mainView.stateButton.setImage(UIImage(named: self.viewModel.stateButtonIconArray[0]), for: .normal)
            case MyStatusCase.matching.rawValue:
                self.mainView.stateButton.setImage(UIImage(named: self.viewModel.stateButtonIconArray[1]), for: .normal)
            default:
                self.mainView.stateButton.setImage(UIImage(named: self.viewModel.stateButtonIconArray[2]), for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLocation()
        genderButtonActive(mainView.allButton)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: mTimer, userInfo: nil, repeats: true)
        
        mainView.allButton.addTarget(self, action: #selector(allButtonClicked), for: .touchUpInside)
        mainView.manButton.addTarget(self, action: #selector(manButtonClicked), for: .touchUpInside)
        mainView.womanButton.addTarget(self, action: #selector(womanButtonClicked), for: .touchUpInside)
        mainView.myLocationButton.addTarget(self, action: #selector(myLocationClicked), for: .touchUpInside)
        mainView.stateButton.addTarget(self, action: #selector(stateButtonClicked), for: .touchUpInside)
    }
    
    @objc func stateButtonClicked() {
        //권환 확인
        checkUserLocationServicesAithorization()
        if viewModel.isLocationEnable.value == false {
            return
        }
        
        if viewModel.userInfo.value.gender == GenderCode.unSelected.rawValue {
            toastMessage(message: "새싹 찾기 기능을 이용하기 위해서는 성별이 필요해요!")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.present(MyDetailViewController(), animated: true, completion: nil)
            }
        } else {
            switch viewModel.myStatus.value {
            case MyStatusCase.matching.rawValue :
                let vc = NearUserViewController()
                vc.modalPresentationStyle = .fullScreen
                vc.viewModel = viewModel
                self.present(vc, animated: true, completion: nil)
                
            case MyStatusCase.matched.rawValue :
                let vc = ChattingViewController()
                vc.modalPresentationStyle = .fullScreen
                vc.viewModel = viewModel
                self.present(vc, animated: true, completion: nil)
                
            default:
                let vc = HobbyViewController()
                vc.modalPresentationStyle = .fullScreen
                vc.viewModel = viewModel
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    @objc func allButtonClicked(){
        genderButtonActive(mainView.allButton)
        genderButtonDeactive(mainView.manButton)
        genderButtonDeactive(mainView.womanButton)
        searchFriends()
    }
    
    @objc func manButtonClicked(){
        genderButtonActive(mainView.manButton)
        genderButtonDeactive(mainView.allButton)
        genderButtonDeactive(mainView.womanButton)
        searchFriends()
    }
    
    @objc func womanButtonClicked(){
        genderButtonActive(mainView.womanButton)
        genderButtonDeactive(mainView.allButton)
        genderButtonDeactive(mainView.manButton)
        searchFriends()
    }
    
    @objc func myLocationClicked() {
        checkUserLocationServicesAithorization()
        searchFriends()
    }
    
    func genderButtonActive(_ target: UIButton) {
        target.backgroundColor = .customGreen
        target.setTitleColor(.customWhite, for: .normal)
    }
    
    func genderButtonDeactive(_ target: UIButton) {
        target.backgroundColor = .customWhite
        target.setTitleColor(.customBlack, for: .normal)
    }
    
    //토큰 갱신은 여러 페이지에서 해야하는 작업이니까 BaseViewController에서 처리할수는 없을까?
    //그런데 BaseViewController에서 업데이트하는 ViewModel.getUserInfo는 각각의 ViewController마다 다른데 어떻게 처리해줘야 딱 깔쌈하게 적용이 되려나??
    //MARK: BaseVC에 별도의 VM을 연결해서 사용하면 된다. 추후에 업데이트 할것!!
    
    func updateFCMToken(newFCMToken: String) {
        APISevice.updateFCMToken(idToken: UserDefaults.standard.string(forKey: UserDefault.idToken.rawValue)!, fcmToken: newFCMToken) { statuscode in
            switch statuscode {
            case UserStatusCodeCase.success.rawValue:
                self.viewModel.getUserInfo { userInfo, statuscode, error in
                }
            case UserStatusCodeCase.firebaseTokenError.rawValue:
                self.refreshFirebaseIdToken { idtoken, error in
                    APISevice.updateFCMToken(idToken: idtoken!, fcmToken: UserDefaults.standard.string(forKey: UserDefault.FCMToken.rawValue)!) { statuscode in
                    }
                }
            default:
                print("updateFCMToken error ", statuscode as Any)
            }
        }
    }
    
    func checkMyStatus(){
        let myStatus = UserDefaults.standard.integer(forKey: UserDefault.myStatus.rawValue)
        viewModel.myStatus.value = myStatus
    }
    
    // MARK: MapKit 관련 설정
    func setLocation(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        mainView.mapView.delegate = self
        mainView.mapView.showsUserLocation = true
    }
    
    func searchFriends() {        
        let form = OnQueueForm(region: viewModel.centerRegion.value, lat: viewModel.centerLatitude.value, long: viewModel.centerLongitude.value)
        viewModel.searchNearFriends(form: form) { onqueueResult, statuscode, error in
            switch statuscode {
            case OnQueueStatusCodeCase.success.rawValue:
                guard let onqueueResult = onqueueResult else {
                    return
                }
                
                self.manAnnotations = []
                self.womanAnnotations = []
                
                //print(onqueueResult)
                
                for friendUserInfo in onqueueResult.fromQueueDB {
                    self.viewModel.fromNearFriendsHobby.value.append(contentsOf: friendUserInfo.hf)
                    self.viewModel.fromNearFriendsHobby.value = Array(Set(self.viewModel.fromNearFriendsHobby.value))
                    
                    if friendUserInfo.gender == GenderCode.man.rawValue {
                        self.manAnnotations.append(CustomAnnotation(sesac_sesac: friendUserInfo.sesac, cordinate: CLLocationCoordinate2D(latitude: friendUserInfo.lat, longitude: friendUserInfo.long)))
                    } else {
                        self.womanAnnotations.append(CustomAnnotation(sesac_sesac: friendUserInfo.sesac, cordinate: CLLocationCoordinate2D(latitude: friendUserInfo.lat, longitude: friendUserInfo.long)))
                    }
                }
                
                for friendUserInfo in onqueueResult.fromQueueDBRequested {
                    self.viewModel.fromNearFriendsHobby.value.append(contentsOf: friendUserInfo.hf)
                    self.viewModel.fromNearFriendsHobby.value = Array(Set(self.viewModel.fromNearFriendsHobby.value))
                    
                    if friendUserInfo.gender == GenderCode.man.rawValue {
                        self.manAnnotations.append(CustomAnnotation(sesac_sesac: friendUserInfo.sesac, cordinate: CLLocationCoordinate2D(latitude: friendUserInfo.lat, longitude: friendUserInfo.long)))
                    } else {
                        self.womanAnnotations.append(CustomAnnotation(sesac_sesac: friendUserInfo.sesac, cordinate: CLLocationCoordinate2D(latitude: friendUserInfo.lat, longitude: friendUserInfo.long)))
                    }
                }
                
                self.viewModel.fromRecommendHobby.value = onqueueResult.fromRecommend
                self.addFilteredPin(gender: self.viewModel.searchGender.value)
                
            case OnQueueStatusCodeCase.firebaseTokenError.rawValue:
                self.refreshFirebaseIdToken { idToken, error in
                    if let idToken = idToken {
                        self.searchFriends()
                    }
                }
                
            default:
                self.toastMessage(message: "잠시후 다시 시도해주세요.")
            }
        }
    }
    
    func addFilteredPin(gender: Int){
        mainView.mapView.removeAnnotations(self.mainView.mapView.annotations)
        
        switch gender {
        case GenderCode.man.rawValue:
            mainView.mapView.addAnnotations(manAnnotations)
        case GenderCode.woman.rawValue:
            mainView.mapView.addAnnotations(womanAnnotations)
        default:
            mainView.mapView.addAnnotations(manAnnotations)
            mainView.mapView.addAnnotations(womanAnnotations)
        }
    }
    
    //위치 권한 허용 확인
    func checkUserLocationServicesAithorization() {
        let authorizationStatus: CLAuthorizationStatus
        authorizationStatus = locationManager.authorizationStatus
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization(authorizationStatus) //권한 확인
        } else {
            toastMessage(message: "위치 서비스 사용 불가")
        }
    }
    
    //권환 확인
    func checkLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            let userLocation = mainView.mapView.userLocation
            let region = MKCoordinateRegion(center: userLocation.location!.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mainView.mapView.setRegion(region, animated: true)
            viewModel.isLocationEnable.value = true
        case .notDetermined:
            viewModel.isLocationEnable.value = false
            toastMessage(message: "GPS 권한 설정되지 않음")
        case .denied, .restricted:
            viewModel.isLocationEnable.value = false
            toastMessage(message: "위치 서비스 권한 요청이 거부되어 서비스를 제공할수 없습니다.")
            print("value4", viewModel.isLocationEnable.value)
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
}

// MARK: - CLLocationManagerDelegate
extension HomeViewController: CLLocationManagerDelegate {
    //사용자가 위치 허용을 한 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        moveLocation(latitudeValue: (location.coordinate.latitude), longtudeValue: (location.coordinate.longitude), delta: 0.01)
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
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        runTimeInterval = Date().timeIntervalSinceReferenceDate
    }
    
    @objc func Tick_TimeConsole() {
        guard let timeInterval = runTimeInterval else { return }
        let interval = Date().timeIntervalSinceReferenceDate - timeInterval
        if interval < 0.5 { return }
        let coordinate = mainView.mapView.centerCoordinate
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

        // 지정된 위치의 지오 코드 요청
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if let pm: CLPlacemark = placemarks?.first {
                let address: String = "\(pm.country ?? "") \(pm.administrativeArea ?? "") \(pm.locality ?? "") \(pm.subLocality ?? "") \(pm.name ?? "")"
                //print("address", address)
            }
        }
        runTimeInterval = nil
        
        //지도 중앙 좌표
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        viewModel.calculateRegion(myLatitude: latitude, myLongitude: longitude)
        mainView.mapView.setRegion(region, animated: true)
        
        searchFriends()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? CustomAnnotation else { return nil }
        
        var annotationView = self.mainView.mapView.dequeueReusableAnnotationView(withIdentifier: CustomAnnotationView.identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: CustomAnnotationView.identifier)
            annotationView?.canShowCallout = false
            annotationView?.contentMode = .scaleAspectFit
            
        } else {
            annotationView?.annotation = annotation
        }
        
        let sesacImage: UIImage!
        let size = CGSize(width: 85, height: 85)
        UIGraphicsBeginImageContext(size)
        
        switch annotation.sesac_sesac {
        case 0:
            sesacImage = UIImage(named: "sesac_face_1")
        case 1:
            sesacImage = UIImage(named: "sesac_face_2")
        case 2:
            sesacImage = UIImage(named: "sesac_face_3")
        case 3:
            sesacImage = UIImage(named: "sesac_face_4")
        case 4:
            sesacImage = UIImage(named: "sesac_face_5")
        default:
            sesacImage = UIImage(named: "sesac_face_1")
        }
        
        sesacImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        annotationView?.image = resizedImage
        
        return annotationView
    }
}

// MARK: - CustomAnnotaion
class CustomAnnotation: NSObject, MKAnnotation {
    let sesac_sesac: Int?
    let coordinate: CLLocationCoordinate2D
    
    init(
        sesac_sesac: Int?,
        cordinate: CLLocationCoordinate2D
    ) {
        self.sesac_sesac = sesac_sesac
        self.coordinate = cordinate
    }
}
