//
//  Chat.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/03/22.
//

import Foundation

struct Chat: Codable {
    let from: String
    let to: String
    let chat: String
    let id: String
    let createdAt: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case from, to
        case chat
        case id = "_id"
        case createdAt
        case v = "__v"

    }
}

struct Chats: Codable {
    let payload: [Chat]
}
