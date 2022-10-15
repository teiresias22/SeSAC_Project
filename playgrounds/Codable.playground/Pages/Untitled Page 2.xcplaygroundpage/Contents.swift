//: [Previous](@previous)

import Foundation

let json = """
{
"quote_content": "Being entirely honest with oneself is a good exercise.",
"author": null,
"like_count": 12345
}
"""

struct Quote: Decodable {
    let quote: String
    let author: String?
    let like: Int
    let influencer : Bool
    
    enum CodingKeys: String, CodingKey {
        case quote = "quote_content"
        case author
        case like = "like_count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        quote = try container.decode(String.self, forKey: .quote)
        author = try? container.decode(String.self, forKey: .author) ?? "unknown"
        like = try container.decode(Int.self, forKey: .like)
        influencer = (10000...).contains(like) ? true : false
    }
}

guard let jsonData = json.data(using: .utf8) else { fatalError("Error") }

do {
    let value = try JSONDecoder().decode(Quote.self, from: jsonData)
    dump(value)
} catch {
    print(error)
}



//: [Next](@next)
