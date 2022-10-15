import UIKit


class User {
    var name: String = ""
    var age: Int = 0
}

struct UserStruct {
    var name: String = ""
    var age: Int = 0
}

extension UserStruct {
    init(age: Int){
        self.name = "손님"
        self.age = age
    }
}


//인스턴스 - 저장 프로퍼티 초기화
let a = User() //초기화 구문, 초기화 메서드 -> Default Initializer
let b = UserStruct(name:"", age: 9) //MemberWise Initializer
let c = UserStruct()
let d = UserStruct(age: 22)



let color = UIColor(red: 0.5, green: 0.5, blue: 1.0, alpha: 1)
let color2 = UIColor.init(red: 0.5, green: 0.5, blue: 1.0, alpha: 1)

//편의 생성자 convenience initializer
class Coffee{
    let shot: Int
    let size: String
    let menu: String
    let mind: String
    
    init(shot: Int, size: String, menu: String, mind: String) {
        self.shot = shot
        self.size = size
        self.menu = menu
        self.mind = mind
    }
    
    //기본 형태
    convenience init(value: String) {
        self.init(shot: 2, size: "보통", menu: value, mind: "대략정성")
    }
}

let coffee = Coffee(shot: 2, size: "크게", menu: "아메리카노", mind: "정성듬뿍")
let coffee2 = Coffee(value: "뜨아")


extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

let customColor = UIColor(red: 28, green: 12, blue: 205)


//프로토콜 초기화 구문
protocol Jack {
    //getter, setter 확인
    init()
}

/*
class Hello {
    init() {
        
    }
}

class Hello: Jack {
    required init() {
        
    }
}

class HelloBrother: Hello {
    
    required init() {
        
    }
}
 */

class Hello {
    
    init() {
        print("Hello")
    }
    
}

class HelloBrother: Hello, Jack {
    
    required override init() {
        super.init()
        print("HelloBrother")
    }
    
}

let hello = HelloBrother()


//초기화 구문 델리게이션
class A {
    var value: Int
    
    init() {
        self.value = 10
    }
}

class B:A {
    override init() {
        super.init()
        print("B")
    }
}

class C:B {
    override init() {
        super.init()
    }
    
    deinit {
        print("deinit")
    }
}

var test: C? = C()
test = nil


//영진원 API: 20211021

func checkDateFormat(text: String) -> Bool {
    let format = DateFormatter()
    format.dateFormat = "yyyyMMdd"
    return format.date(from: text) == nil ? false : true
}

func validataUserInput(text: String) -> Bool {
    guard !(text.isEmpty) else {
        print("빈 값입니다.")
        return false
    }
    //유효성 검사
    //사용자가 입력한 값이 숫자인지 아닌지
    guard Int(text) != nil else{
        print("숫자가 아닙니다.")
        return false
    }
    
    //사용자가 입력한 값이 날짜 형태로 변환되는 숫자인지 아닌지
    guard checkDateFormat(text: text) else {
        print("날짜 형태가 아닙니다.")
        return false
    }
    return true
}

if validataUserInput(text: "20220000") {
    print("검색을 할 수 있음")
} else {
    print("검색을 할 수 없음")
}


//----------------------------------------------
//오류 처리 패턴
enum ValidationError : Int, Error {
    case emptyString = 401
    case invalidInt = 402
    case invalidDate = 403
}

func validateUserInputError(text:String) throws -> Bool {
    guard !(text.isEmpty) else {
        throw ValidationError.emptyString
    }
    
    guard Int(text) != nil else{
        throw ValidationError.invalidInt
    }
    
    guard checkDateFormat(text: text) else {
        throw ValidationError.invalidDate
    }
    return true
}

do {
    let result = try validateUserInputError(text: "20211101")
} catch ValidationError.emptyString{
    print("값이 비어 있습니다.")
} catch ValidationError.invalidInt {
    print("숫자 값이 아닙니다.")
} catch ValidationError.invalidDate {
    print("날짜 값이 아닙니다.")
}

do {
    let result = try validateUserInputError(text: "20211101")
    print(result, "성공")
}catch {
    switch error {
    case ValidationError.invalidInt: print("숫자 값이 아닙니다.")
    case ValidationError.emptyString: print("값이 비어 있습니다.")
    case ValidationError.invalidDate: print("날짜 값이 아닙니다.")
    default:
        <#code#>
    }
}

let result = try! validateUserInputError(text: "20211101")
let result = try? validateUserInputError(text: "20211101")
