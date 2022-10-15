import UIKit
import Foundation
import Darwin

/*
    1. 1급 객체
    - 변수나 상수에 함수를 대입할 수 있다.
 

 */

//변수나 상수에 함수를 대입할 수 있다.

func checkBankIformation(bank: String) -> Bool {
    let bankArray = ["우리", "신한", "KB"]
    return bankArray.contains(bank) ? true:false
}

//변수나 상수에 함수를 실행하고 나온 반환값을 jack에 대입
let jack = checkBankIformation(bank: "우리") //Bool


let jackAccount = checkBankIformation // 단지 함수만 대입 -> 실행되지 않음
jackAccount("KB") //함수를 호출해야 함수가 실행된다.

//(String) -> Bool 이게 뭘까? Function Type

let tupleExample = (1, true, "Dkd", 3.3)
tupleExample.1

//Function Type1 (String) -> String
func hello(nickName: String) -> String{
    return "저는 \(nickName)입니다."
}

func hello(userName: String) -> String{
    return "저는 \(userName)입니다."
}

//Function Type2 (String, Int) -> String
func hello(nickname: String, Age: Int) -> String{
    return "저는 \(nickname), \(Age)입니다."
}

//Function Type3 () -> Void, () -> ()
//typealias Void = ()
func hello() {
    print("안녕하세요 반갑습니다.")
}

//함수를 구분하기 힘뜰때 타입 어노테이션을 통해 함수를 구별할 수 있다.
//또는 함수의 식별자로 구분할 수 있다. 함수의 식별자를 사용한다면, 타입 어노테이션을 생략하더라도 함수를 구별할 수 있다.
let a: (String) -> String = hello(nickName:)
let c = hello(userName:)
let b: (String, Int) -> String = hello(nickname:Age:)

//b 상수를 hello처럼 사용할 수 있다!
b("짱구", 15)

/*
 2. 함수의 반환 타입으로 함수를 사용할수 있다. 구조체 클래스 등 반환값으로 사용할 수 있음
 */

 func currentAccount() -> String {
    return "계좌 있음"
}
func noCurrentAccount() -> String {
    return "계좌 없음"
}

//가장 왼쪽에 위치한 -> 를 기준으로 오른쪽에 놓인 모든 타입은 반환값을 의미한다.
func checkBank(bank: String) -> () -> String {
    let bankArray = ["우리", "신한", "KB"]
    return bankArray.contains(bank) ? currentAccount : noCurrentAccount
}

let minsu = checkBank(bank: "농협")
minsu()

//2-1. Calculate (Int, Int) -> Int
func plus(a: Int, b: Int) -> Int {
    return a + b
}

func minus(a: Int, b: Int) -> Int {
    return a - b
}

func multiply(a: Int, b: Int) -> Int {
    return a * b
}

func divide(a: Int, b: Int) -> Int {
    return a / b
}

func calculate(operand: String) -> (Int, Int) -> Int {
    switch operand {
    case "+": return plus
    case "-": return minus
    case "*": return multiply
    case "/": return divide
    default : return plus
    }
}

let result = calculate(operand: "-")
result(5, 3)

//가독성을 위해서 가급적 단계를 나눠 작성하는 편
let result2 = calculate(operand: "-")(4,3)


/*
 3. 함수의 인자값으로 함수를 사용할 수 있다.
 콜백 함수로 자주 사용이 됨. 콜백 함수: 특정 구문의 실행이 끝나면 시스템이 호출하도록 처리된 함수
 */

func oddNumber() {
    print("홀수")
}

func evenNumber() {
    print("짝수")
}

func resultNumber(base: Int, odd: () -> (), even: () -> ()) {
    return base.isMultiple(of: 2) ? even() : odd()
}

resultNumber(base: 9, odd: oddNumber, even: evenNumber)

func plusNumber() {
    print("더하기")
}
func minusNumber() {
    print("빼기")
}

//어떤 함수가 들어가는 것과 상관 없이, 단지 타입만 잘 맞으면 된다.
//실질적인 연산은 인자값으로 받는 함수에 달려있어서, 중개 역할만 담당한다고 하여 브로커라고 부른다고 합니다.
resultNumber(base: 9, odd: plusNumber, even: minusNumber)

resultNumber(base: 8) {
    print("Success")
} even: {
    print("Deismiss")
}


//클로저의 유래를 봅시다...닫혀있다. 외부 함수 <-> 내부 함수(클로저)

func drawingGame(item: Int) -> String {
    
    func luckyNumber(number: Int) -> String {
        return "\(number * Int.random(in: 1...5))"
    }
    
    let result = luckyNumber(number: item * 2)
    
    return result
}

drawingGame(item: 10) //외부 함수 생명 주기 -> 내부 함수의 생명 주기 (은닉성)

//내부 함수를 반환하는 외부 함수로 만들 수 있다.
func drawingGame2(item: Int) -> (Int) -> String {
    
    func luckyNumber(number: Int) -> String {
        return "\(item * number * Int.random(in: 1...5))"
    }

    return luckyNumber
}

drawingGame2(item: 10)
let luckNumber2 = drawingGame2(item: 10) //외부 함수는 생명 주기가 끝남

luckNumber2(2) //외부함수가 생명주기가 끝나더라도 내부 함수는 계속 사용할 수 있다.

//은닉성이 있는 내부 함수를 외부 함수의 실행 결과로 반환하면서 내부 함수를 외부에서도 접근 가능하게 되었음. 이제 얼마든지 호출 가능.
//이건 ㅐㅇ명주기에도 영향을 미침. 외부 함수가 종료되더라도 내부 함수는 살아있음.

//드디어 클로저를 봅시다.

//같은 정의를 갖는 함수가 서로 다른 환경을 저장하는 결과가 생기게 됨.
//클로저에 의해 내부 함수 주변의 지역 변수나 상수도 함께 저장됨. -> 값이 캡쳐 되었다. 라고 표현한다.
//주변환셩에 포함된 상수의 타입이 기본 자료형이나 구조체 자료형일 때 발생함. 클로저 캡쳐 기본 기능임.

// => 스위프트는 특히 이름이 없는 함수로 클로저를 사용하고 있고, 주변환경(내부 함수 주변의 변수나 상수)로 부터 값을 캡쳐할 수 있는 "경량 문법"으로 많이 사용하고 있다.

// () -> ()
func studyiOS() {
    print("iOS 개발자를 위해 열공중")
}

let studyiOSHarde = {
    print("iOS 개발자를 위해 열공중")
}

let studyiOSHarde2 = { () -> () in
    print("iOS 개발자를 위해 열공중")
}

studyiOSHarde2()

func getStudyWithMe(study: () -> () ) {
    study()
}
//인라인 클로저
getStudyWithMe(study: { () -> () in
    print("iOS 개발자를 위해 열공중")
})

getStudyWithMe(study: studyiOSHarde2)

//트레일링 클로저
getStudyWithMe() { () -> () in
    print("iOS 개발자를 위해 열공중")
}


func todayNumber(result: (Int) -> String) {
    result(Int.random(in: 1...100))
}

todayNumber(result: { (number: Int) -> String in
    return "행운의 숫자\(number)"
})

todayNumber(result: { (number) in
    return "행운의 숫자\(number)"
})

todayNumber(result: {
    return "행운의 숫자\($0)"
})

todayNumber(result: {
    "행운의 숫자\($0)"
})

todayNumber() { "\($0)"}

todayNumber { value in
    print("gkgkgk")
    return "\(value) 입니다."
}
