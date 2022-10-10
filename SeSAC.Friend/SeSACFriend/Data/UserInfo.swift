//
//  UserInfo.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/25.
//

import Foundation

// MARK: - UserInfo
struct UserInfo: Codable {
    var id: String
    var v: Int
    var uid, phoneNumber, email: String
    var fcMtoken, nick, birth: String
    var gender: Int
    var hobby: String
    var comment: [String]
    var reputation: [Int]
    var sesac: Int
    var sesacCollection: [Int]
    var background: Int
    var backgroundCollection: [Int]
    var purchaseToken, transactionID, reviewedBefore: [String]
    var reportedNum: Int
    var reportedUser: [String]
    var dodgepenalty: Int
    var dodgeNum: Int
    var ageMin, ageMax, searchable: Int
    var createdAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case v = "__v"
        case uid, phoneNumber, email
        case fcMtoken = "FCMtoken"
        case nick, birth, gender, hobby, comment, reputation, sesac, sesacCollection, background, backgroundCollection, purchaseToken
        case transactionID = "transactionId"
        case reviewedBefore, reportedNum, reportedUser, dodgepenalty
        case dodgeNum
        case ageMin, ageMax, searchable, createdAt
    }
}
