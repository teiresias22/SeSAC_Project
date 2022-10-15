//: [Previous](@previous)

import Foundation

struct User: Encodable {
    var name: String
    var signUpDate: Date
    var age: Int
}

let users: [User] = [
    User(name: "jack", signUpDate: Date(), age: 33),
    User(name: "Elsa", signUpDate: Date(timeInterval: -86400, since: Date()), age: 18),
    User(name: "Emily", signUpDate: Date(timeIntervalSinceNow: 86400*2), age: 11)
]

dump(users)

let encode = JSONEncoder()
encode.outputFormatting = .prettyPrinted
encode.dateEncodingStrategy = .iso8601 //(ios 국제표준화기구 날짜 표기 형식)
//encode.outputFormatting = .sortedKeys

let format = DateFormatter()
format.locale = Locale(identifier: "ko-KR")
format.dateFormat = "yyyy년 MM월 dd일 EEEE"
encode.dateEncodingStrategy = .formatted(format)

do {
    let jsonData = try encode.encode(users)
    
    guard let jsonString = String(data: jsonData, encoding: .utf8) else { fatalError("Failed") }
    
    print(jsonString)
} catch {
    print(error)
}







//: [Next](@next)
