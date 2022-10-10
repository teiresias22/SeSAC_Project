//
//  Form.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/25.
//

import Foundation

struct SignUpForm: Encodable {
    let phoneNumber, FCMtoken, nick, email: String
    let birth: Date
    let gender: Int
}

struct UpdateUserInfoForm: Encodable {
    let searchable: Int
    let ageMin: Int
    let ageMax: Int
    let gender: Int
    let hobby: String
}

struct OnQueueForm: Encodable {
    let region: Int
    let lat: Double
    let long: Double
}

struct PostQueueForm: Encodable {
    let type: Int
    let region: Int
    let lat: Double
    let long: Double
    let hf: [String]
}

struct WriteReviewFrom: Encodable {
    let otheruid: String
    let reputation: [Int]
    let comment: String
}

struct UpdateMypageForm: Encodable {
    let searchable: Int
    let ageMin: Int
    let ageMax: Int
    let gender: Int
    let hobby: String
}

struct ReportOtherFrom: Encodable {
    let otheruid: String
    let reportedReputation: [Int]
    let comment: String
}
