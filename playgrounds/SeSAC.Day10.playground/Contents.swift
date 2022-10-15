import UIKit
import Foundation

//옵셔널 바인딩 : if - let, guard

enum UserMissionStatus : String{
    case missionFailed = "실패"
    case missionSucceed = "성공"
}

UserMissionStatus.missionFailed.rawValue

func checkNumber(number: Int?) -> (UserMissionStatus, Int?) {
    if number != nil {
        return (.missionSucceed, number!)
    }else {
        return (.missionFailed, nil)
    }
}

func checkNumber2(number: Int?) -> (UserMissionStatus, Int?) {
    if let value = number {
        return (.missionSucceed, value)
    }else {
        return (.missionFailed, nil)
    }
}

func checkNumber3(number: Int?) -> (UserMissionStatus, Int?) {
    guard let value = number else {
        return (.missionFailed, nil)
    }
    return (.missionSucceed, value)
}

//타입 캐스팅: 메모리의 인스턴스 타입은 바뀌지 않는다.
//let array: [Any] = [1, true, "안녕"]
//
//let arrayInt = array as! [Int]

class Mobile {
    let name:String
    
    init(name:String) {
        self.name = name
    }
}

class AppleMobile: Mobile {
    var company = "애플"
}

class GoogleMobile: Mobile {
    
}

let mobile = Mobile(name: "PHONE")
let apple = AppleMobile(name: "iPHONE")
let google = GoogleMobile(name: "Galaxy")


mobile is Mobile
mobile is AppleMobile
mobile is GoogleMobile

apple is Mobile
apple is AppleMobile
apple is GoogleMobile

let iPhone: Mobile = AppleMobile(name: "iPad")
iPhone.name

//as, as!, as?
if let value = iPhone as? AppleMobile {
    print("성공", value.company)
}


//클래스, 구조체
enum DrinkSize {
    case short, tall, grande, venti
}

struct DrinkStruct {
    let name: String
    var count: Int
    var size: DrinkSize
}

class DrinkClass {
    let name: String
    var count: Int
    var size: DrinkSize
    
    init(name: String, count: Int, size: DrinkSize) {
        self.name = name
        self.count = count
        self.size = size
    }
}

var drinkStruct = DrinkStruct(name: "아메리카노", count: 3, size: .tall)
drinkStruct.count = 2
drinkStruct.size = .venti

print(drinkStruct.name, drinkStruct.count, drinkStruct.size)

let drinkClass = DrinkClass(name: "블루베리 스무디", count: 2, size: .venti)
drinkClass.count = 5
drinkClass.size = .tall

print(drinkClass.name, drinkClass.count, drinkClass.size)

//지연 저장 프로퍼티: 변수 저장 프로퍼티, 초기화
struct Poster{
    var image: UIImage = UIImage(systemName: "star") ?? UIImage()
    
    init() {
        print("Poster Initialized")
    }
}

struct MediaInformation{
    var mediaTitle: String
    var mediaRuntime: Int
    lazy var mediaPoster: Poster = Poster()
}

var media = MediaInformation(mediaTitle: "오징어게임", mediaRuntime: 333)
print("1")
media.mediaPoster
print("2")


//연산 프로퍼티 & 프로퍼티 감시자 => Swift 5.1 PropertyWrapper
//타입 알리어스
class BMI {
    typealias BMIValue = Double
    
    var userName: String {
        willSet{
            print("닉네임 변경 예정: \(userName) -> \(newValue)")
        }
        didSet{
            changeNameCount += 1
            print("닉네임 변경 결과: \(oldValue) -> \(userName)")
        }
    }
    
    var changeNameCount = 0
    
    var userWeight: BMIValue
    var userHeight: BMIValue
    
    var BMIResult: String {
        get {
            let bmiValue = (userWeight * userWeight) / userHeight
            let bmiStatus = bmiValue < 18.5 ? "저체중" : "정상 이상"
            return "\(userName)님의 BMI 지수는 \(bmiValue)으로 \(bmiStatus)입니다."
        }
        set(nickname) {
            userName = nickname
        }
    }
    
    
    init(userName:String, userWeight: Double, userHeight: Double) {
        self.userName = userName
        self.userWeight = userWeight
        self.userHeight = userHeight
    }
}

let bmi = BMI(userName: "Joon", userWeight: 80, userHeight: 183)
let result = bmi.BMIResult
print(result)

bmi.BMIResult = "JACK"
bmi.BMIResult = "Minsu"
bmi.BMIResult = "Jackie"
bmi.BMIResult = "Hello"
bmi.BMIResult = "Joooon"

print(bmi.BMIResult)
print(bmi.changeNameCount)




class User {
    
    static let nickname = "고래밥"
    
    static var totalOrderCount = 0 {
        didSet{
            print("총 주문횟수: \(oldValue) > \(totalOrderCount)로 증가")
        }
    }
    static var orderProduct: Int {
        get {
            return totalOrderCount
        }
        set {
            totalOrderCount += newValue
        }
    }
}


User.nickname
User.totalOrderCount
User.orderProduct

User.orderProduct = 10

User.totalOrderCount

User.orderProduct = 20

User.totalOrderCount


//인스턴스 메서드: 구조체에서 자신의 프로퍼티값을 인스턴스 메서드 내에서 변경하게 될 경우 mutating을 사용

struct Point {
    var x = 0.0
    var y = 0.0
    
    mutating func moveBy(x: Double, y:Double) {
        self.x += x
        self.y += y
    }
}


var somePoint = Point()
print("POINT: \(somePoint.x), \(somePoint.y)")

somePoint.moveBy(x: 3.0, y: 5.0)
print("POINT: \(somePoint.x), \(somePoint.y)")


class Coffee {
    static var name = "아메리카노"
    static var shot = 2
    
    static func plusShot() {
        shot += 1
    }
    class func minuShot() {
        shot -= 1
    }
}

class Latte: Coffee {
    
    override class func minuShot() {
        print("타입 메서드를 상속받아 재정의 하고 싶을 경우, 부모 클래스에서 타입 메서드 선언할 때 static이 아니라 class를 사용하면 재정의가 가능하다.")
    }
}


Latte.minuShot()

//Prooerty Wrap
class UserDefaultsHelper {
    static let shared = UserDefaultsHelper()
    
    let userDefaults = UserDefaults.standard
    
    enum Key: String {
        case nickname, age, rate
    }
    
    var userNickname: String? {
        get {
            return userDefaults.string(forKey: Key.nickname.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    var userAge: Int? {
        get {
            return userDefaults.integer(forKey: Key.age.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.age.rawValue)
        }
    }
}



protocol Introduce {
    var name: String {get set}
    var age: Int { get }
    
    func introduce()
    
}


class Jack: Introduce {
    
    var name: String = "Jack"
    
    var age: Int = 10
    
    func introduce() {
        print("자기소개하기")
    }
    
}
