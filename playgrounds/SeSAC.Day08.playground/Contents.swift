import UIKit

//함수 매개변수 반환값

//매개변수를 사용하지 않는 함수
func sayHello() -> String {
    
    print("안녕하세요")
    
    return "반갑습니다!"
}

print( "자기소개: \(sayHello())")
sayHello()


func bmi() -> Double {
    
    //bmi 조건 계산문
    
    return 20.1
}

func bmiResult() -> [String] {
    
    let name = "고래밥"
    let result = "정상"
    
    return [name, result]
}

let value = bmiResult()

print( value[0] + "님의 BMI 지수는 " + value[1] + " 입니다")

//컬랙션(집단 자료형): 배열, 딕셔너리, 집합 + 튜플

let userInfo: (String, String, Bool, Double) = ("고래밥", "SESAC@SESAC.com", true, 4.5)

print(userInfo.0)
print(userInfo.1)


//전체 영화 갯수, 전체 러닝 타임
@discardableResult func getMovieReport() -> (Int, Int) {
    (100, 1000000)
}

//Swift 5.1 return 키워드 생략 가능 -> 함수 안에 다른 연산자가 없이 반환값만 있는 경우
//discardableResult: 반환값을 무시하는 키워드


//열거형
enum appleDevice {
    case iPhone
    case iPad
    case Watch
    case iMac
}

enum GameJob: String {
    case rogue = "도적"
    case warrior = "전사"
    case mystic = "도사"
    case shaman = "주술사"
    case fight = "격투가"
}

let selectJob: GameJob = .mystic

print("당신은 \(selectJob.rawValue)입니다.")

if selectJob == .mystic {
    print("당신은 도사 입니다.")
} else if selectJob == .shaman{
    print("당신은 주술사 입니다.")
}

enum Gander {
    case man, woman
}

enum HTTPCode: Int {
    case OK = 200
    case SEVER_ERROR = 500
    case NO_PAGE
    
    func showStatus() -> String {
        switch self {
        case .NO_PAGE:
            return "잘못된 주소입니다."
        case .SEVER_ERROR:
            return "서버 점검중입니다. 서버에 문제가 생겨서 잠시 후 시도해주세요"
        case .OK:
            return "정상입니다"
        }
    }
}

var status: HTTPCode = .NO_PAGE

print(status.rawValue) //원시값

status.showStatus()

