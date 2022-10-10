import UIKit
import CoreLocation
import CoreLocationUI
import Alamofire
import SwiftyJSON
import Kingfisher


class OpenWeatherMapViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var nowDate: UILabel!
    @IBOutlet weak var nowLocal: UILabel!
    
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var temperatureView: UIView!
    @IBOutlet weak var nowTemperature: UILabel!
    
    @IBOutlet weak var humidityView: UIView!
    @IBOutlet weak var nowHumidity: UILabel!

    @IBOutlet weak var windView: UIView!
    @IBOutlet weak var nowWind: UILabel!
    
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var weatherImage: UIImageView!
    
    @IBOutlet weak var endWordingView: UIView!
    @IBOutlet weak var endWording: UILabel!

    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        checkUserLocationServicesAithorization()
        
        self.view.backgroundColor = UIColor(red: 0.9, green: 0.5, blue: 0.5, alpha: 1)
        nowLocal.textColor = .white
        topView.backgroundColor = .clear
        mainView.backgroundColor = .clear
        
        setLabel(temperatureView)
        setLabel(humidityView)
        setLabel(windView)
        setLabel(imageView)
        setLabel(endWordingView)
        
        setDate()
        getCurrentWather()
        endWording.text = "오늘도 행복한 하루 보내세요"
        
        shareButton.tintColor = .white
        refreshButton.tintColor = .white
        
        
        // Do any additional setup after loading the view.
    }
    
    func setLabel(_ label: UIView) {
        label.backgroundColor = .white
        label.layer.cornerRadius = 8
    }
    
    func setDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일 HH시 mm분"
        formatter.locale = Locale(identifier: "ko_KR")
        let currentDateString = formatter.string(from: Date())
        nowDate.text = currentDateString
        nowDate.textColor = .white
    }
    
    func getCurrentWather() {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=f7f4b5e20e84f16de898ecd64e188ef3"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let currentTemp = json["main"]["temp"].doubleValue - 273.15
                self.nowTemperature.text = "지금은 \(Int(currentTemp))C 에요"
                print(currentTemp)
                
                let currentHumidity = json["main"]["humidity"].doubleValue
                self.nowHumidity.text = "\(Int(currentHumidity))% 만큼 습해요"
                
                let currentWind = json["wind"]["speed"].doubleValue
                self.nowWind.text = "\(Int(currentWind))m/s의 바람이 불어요"
                
                let currentImage = json["weather"][0]["icon"].stringValue
                let imageURL = URL(string: "https://openweathermap.org/img/wn/\(currentImage)@2x.png")!
                print("imageURL: \(imageURL)")
                self.weatherImage.kf.setImage(with: imageURL)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension OpenWeatherMapViewController: CLLocationManagerDelegate {
    func checkUserLocationServicesAithorization() {
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14, *) {
            authorizationStatus = locationManager.authorizationStatus // iOS 14 이상
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus() // iOS 14 미만
        }
        //iOS 위치 서비스 확인
        if CLLocationManager.locationServicesEnabled() {
            checkCirrentLocationAithorization(authorizationStatus)
        } else {
            print("iOS 위치 서비스를 켜주세요.")
        }
    }
    
    func checkCirrentLocationAithorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            print("notDetermined")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        case .restricted, .denied:
            print("restricted & denied")
        case .authorizedAlways:
            print("always")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            locationManager.startUpdatingLocation()
        @unknown default:
            print("default")
        }
        if #available(iOS 14.0, *) {
            let accurancyState = locationManager.accuracyAuthorization
            switch accurancyState {
            case .fullAccuracy:
                print("FullAccuracy")
            case .reducedAccuracy:
                print("reducedAccuracy")
            @unknown default:
                print("default")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocation")
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            getCurrentAddress(CLLocation(latitude: latitude, longitude: longitude))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
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
                self.nowLocal.text = address
            }
        }
    }
}
