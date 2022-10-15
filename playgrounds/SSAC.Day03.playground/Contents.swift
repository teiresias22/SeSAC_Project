import UIKit

var greeting = "Hello, playground"

//옵셔널이 아닌 타입으로 선언
var email: String? = "abc@.com"
type(of: email)
email = nil

print(email)

//옵셔널 타입은 옵셔널래핑이 되고, 사용자에게 보여줄때는 옵셔널언래핑이 되어야함
//옵셔널 언래핑방법
//1. !를 붙여준다. (강제해제) nil값이 있는경우 강제해제됨
//2. 옵셔널 바인딩 if let 구문, guard 를 사용
//3. 옵셔널 체인징

if email == nil  {
    print("이메일을 잘못 작성하셨습니다.")
}else {
    print(email!)
}

if email != nil {
    print(email)
} else {
    print("이메일을 잘못 작성하셨습니다.")
}

//삼항연산자 ? ㅇㅇ:ㄴㄴ
let result = email != nil ? email! : "이메일을 잘못 작성하셨습니다."



var gender: Bool = true //할당연산자

print("회원정보: \(email), \(gender)")

//연락처를 기입하는 텍스트 필드 일 경우, 텍스트 필드에 작성되는 모든 글자는 문자로 인식이 된다.
//숫자를 입력하더라도 String으로 인식됨

var phoneNumber = "01012345678"

//1. 숫자가 맞는지? 2.숫자 카운트 3.빈칸확인

var resultPhoneNumber = Int(phoneNumber)
type(of: resultPhoneNumber)

Int8.min
Int8.max

UInt8.min
UInt8.max

Int16.max
Int32.max
Int64.max

var number: Int32 = 1600000

var foodList: [String?] = ["치킨", "피자", "라면", "고기"]
type(of: foodList)

foodList.insert("햄버거", at: 1)
foodList

foodList.append("족발")
foodList.append(contentsOf: ["닭발", "초밥"])

var numberArray = [Int](1...100)
var numberArray2 = Array(repeating: 0, count: 100)

print(numberArray)
print(numberArray2)

numberArray.shuffle()
numberArray.shuffled()
//~ed, ~ing: 원본값은 건들지 않는다.

var sortArray = [3,4,5,1,7,8,10,9,0]
sortArray.sort()
print(sortArray)

var sampleString = "SSAC"
sampleString.append(": iOS 앱 개발자 데뷔 과정")
print(sampleString)

var sampkeString2 = "SSAC"
sampkeString2.appending(": iOS 앱 개발자 데뷔 과정")
print(sampkeString2)

//Key 고유해야 함, 순서는 랜덤
var dictiopnary: Dictionary<Int, String> = [1: "김철수", 2: "김안녕", 3: "김아무개"]
print(dictiopnary)

dictiopnary[5] = "안녕"
//Key는 고유하기만 하다면 순서가 상관 없음

dictiopnary[5]

//신조어검색기
let wordDictionary = ["jmt":"존맛탱", "별다줄":"별걸 다 줄인다", "스드메":"스튜디오 드레스 메이크업"]
let userSearchText = "JMT"

wordDictionary[userSearchText.lowercased()]


let wordArray = ["JMT", "별다줄", "스드메"]

//집합(SET)
let set: Set<Int> = [1,3,2,5,4,6,2,2,1,3]
let set2: Set<Int> = [3,4,2,1,3,2,5,6,1,2,3,8]
print(set)

set.intersection(set2)
