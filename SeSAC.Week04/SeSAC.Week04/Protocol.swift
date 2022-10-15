import Foundation
import UIKit

//Protocol: 클래스, 구조체 청사진...

//옵셔널 (선택적 사용)
//만약 프로토콜을 클래스에서만 사용하게 제한하고자 한다면 :AnyObject를 사용

@objc
protocol OrderSystem: AnyObject {
    func recomendEventMenu()
    //선택적으로 사용할 함수 앞에 @objc optional 사용
    @objc optional func askStampCard(count: Int) -> String
    
    //초기화 구문: 구조체가 멤버와이즈 구문이 있더라도 프로토콜에 구현되어 있다면 무조건 구현!
    //클래스 같은 경우, 부모 클래스에 초기화 구문과 프로토콜의 초기화 구문이 구별, 명시
    //init()
}

class StarBucksMenu {
    
}
class Smoothie: StarBucksMenu, OrderSystem {
    func recomendEventMenu() {
        print("스무디 안내")
    }
    
    //required init(<#parameters#>) {
    //    <#statements#>
    //}
}

class Coffee: StarBucksMenu, OrderSystem {
    
    let smoothie = Smoothie() // is
    
    func test() {
        smoothie is Coffee //fale
        smoothie is StarBucksMenu //true
        smoothie is OrderSystem //true
        //상속 받은 프로토콜로 형변환 가능
    }
    
    func recomendEventMenu() {
        print("커피 베이컨 이벤트 안내")
    }
    
    func askStampCard(count: Int) -> String {
        return "\(count * 2)잔 적립 완료"
    }
    
}

//프로토콜 프로퍼티: 타입과 get, set만 명시, 연산 프로퍼티/ 저장 프로퍼티 상관 없음
protocol NavigationUIProtocol {
    var titleString: String { get set }
    var mainTintColor: UIColor { get } //get만 사용한 경우, get 필수, set 선택.
}

class Jack2ViewController: UIViewController, NavigationUIProtocol {
    var titleString: String {
        get {
            return "나의 일기"
        }
        set {
            title = newValue
        }
    }
    
    var mainTintColor: UIColor {
        get {
            return .black
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleString = "새로운 일기"
    }
    
}


class JackViewController: UIViewController, NavigationUIProtocol {
    var titleString: String = "나의 일기"
    
    var mainTintColor: UIColor = .black
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = titleString
        view.backgroundColor = mainTintColor
    }
    
}


//연산프로퍼티
struct SeSACStudent {
    var totoalCount = 50
    
    var currentStudent = 0
    
    var studentUpdate: String {
        get {
            return "정원 마감까지 \(totoalCount - currentStudent)명 남았습니다."
        }
        set {
            currentStudent += Int(newValue)!
        }
    }
}

var sesac = SeSACStudent()

//값 추가 newValue = 10
//sesac.studentUpdate = "10"
//값 출력 "정원 마감까지 \(40)명 남았습니다.
//sesac.studentUpdate


