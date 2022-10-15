import UIKit

let json = """
{
"quote_content": "Being entirely honest with oneself is a good exercise.",
"author_name": "Sigmund Freud"
}
"""

//class struct enum
struct Quote: Decodable {
    var quote: String
    var author: String
    
    enum Codingkeys: String, CodingKey { //항상 내부적으로 생성이 되어 있음.
        case quote = "quote_content"
        case author = "author_name"
    }
}

//String -> Data
guard let data = json.data(using: .utf8) else { fatalError("Failed") }

//Json과 Struct의 글자 표시 형식이 다른경우 [snape / camel]
let decoder = JSONDecoder()
//decoder.keyDecodingStrategy = .convertFromSnakeCase

//Data -> Quote
do {
    let value = try decoder.decode(Quote.self, from: data)
    print(value)
} catch {
    print(error)
}


/*
 Optional
 keyDecodingStrategy = .convertFromSnakeCase
 Custom Key - Codingkey
 */

//Swift - Meta Data
//Quote의 타입은?
//String의 타입은 String.type. 메타 타입은 클래스 구조체 열거형 등의 유형 자체를 가리킴
let name: String = "Jack"
type(of: name)

//Quote: 인스턴스에 대한 타입, Quote 구조체 자체의 타입은 뭐야? Quote.type
let quote = Quote(quote: "명언 명언", author: "Jack")
type(of: quote)


struct User {
    var name = "고래밥"
    static let identifier = 1234567 //타입 프로퍼티
}

let user = User()
user.name

//세가지 모두 동일한 형식
User.identifier
User.self.identifier
type(of: user).identifier

//타입 메소드나 타입프로퍼티에서 '타입'이라는 이름이 붙은 이유가 이것 때문이다. SomeClass.self는 SomeClass와 같다.
//이를 이용하면 컴파일때가 아니라 런타임때의 타입을 알 수 있다.


