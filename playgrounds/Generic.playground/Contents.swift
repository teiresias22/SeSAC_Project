import UIKit

/*
var apple = 8
var banana = 3

print(apple, banana)
// inout parameter (inout 매개변수)
swap(&apple, &banana)
print(apple, banana)
*/


func swapToInts(a: inout Int, b: inout Int) {
    let tempA = a
    a = b
    b = tempA
}

func swapToDouble(a: inout Double, b: inout Double) {
    let tempA = a
    a = b
    b = tempA
}

func swapToString(a: inout String, b: inout String) {
    let tempA = a
    a = b
    b = tempA
}

//swapToString(a: &"사과", b: &"바나나")

var fruit1 = "사과"
var fruit2 = "바나나"

swapToString(a: &fruit1, b: &fruit2)

print(fruit1, fruit2)

//Jack: 타입 파라미터 (Type Parameter) - 함수 정의시 타입 x, 함수 호출시 매개변수 타입으로 대체되는 PlaceHolder
//func swapTwoValues<Jack>(a: inout Jack, b: inout Jack) {
//    let tempA = a
//    a = b
//    b = tempA
//}

func swapTwoValues<T>(a: inout T, b: inout T) {
    print("swapTwoValues")
    let tempA = a
    a = b
    b = tempA
    
}

func swapTwoValues(a: inout Double, b: inout Double) {
    print("swapToDouble")
    let tempA = a
    a = b
    b = tempA
}

var test1 = 3.3
var test2 = 12.1

//오버로딩 같은 이름이면 타입이 지정된 함수로 사용됨
swapTwoValues(a: &test1, b: &test2)


func total(a: [Int]) -> Int {
    return a.reduce(0, +)
}

func total(a: [Double]) -> Double {
    return a.reduce(0, +)
}

func total(a: [Float]) -> Float {
    return a.reduce(0, +)
}

//Generic
//프로토콜 제약
func total<T: Numeric>(a: [T]) -> T {
    return a.reduce(.zero, +)
}

func total<T: AdditiveArithmetic>(a: [T]) -> T {
    return a.reduce(.zero, +)
}

total(a: [2.3, 4.4, 5.3])


struct Stack<T> {
    var items = [T]()
    
    mutating func push(_ item: T) {
        items.append(item)
    }
    
    mutating func pop() {
        items.removeLast()
    }
}

extension Stack {
    var topElement: T? {
        return self.items.last
    }
}


var stackOfString = Stack<String>()
stackOfString.push("안")
stackOfString.push("녕")
stackOfString.push("하")
stackOfString.push("세")
stackOfString.push("요")

stackOfString.pop()

var array: [String] = []
var array2 = Array<String>()

func equal<T: Equatable>(a: T, b: T) -> Bool {
    return a == b
}
equal(a: 3, b: 4)

class Animal: Equatable {
    
    static func == (lhs: Animal, rhs: Animal) -> Bool {
        //lhs: Left Hand Side
        //rhs: Right Hand Side
        return lhs.name == rhs.name
    }
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

let one = Animal(name: "고양이")
let two = Animal(name: "고양이")

one == two

equal(a: one, b: two)

class Dog: Animal {
    
}

class Cat {
    
}

// 화면전환
import UIKit

class ViewController: UIViewController {
    
    func transitionViewController<T: UIViewController>(sb: String, vc: T) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: vc) as! T
        self.present(vc, animated: true, completion: nil)
    }
    
}
