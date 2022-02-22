//
//  Enums.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/02/11.
//

import Foundation

enum GenderCode: Int {
    case man = 1
    case woman = 0
    case unSelected = -1
}

enum UserStatusCodeCase: Int {
    case success = 200
    case invalidNickname = 202
    case firebaseTokenError = 401
    case unAuthorized = 406
    case serverError = 500
    case clientError = 501
}

enum QueueStataCodeCase: Int {
    case success = 200
    case blockedUser = 201
    case cancelPanlty1 = 203
    case cancelPanlty2 = 204
    case cancelPanlty3 = 205
    case invalidGender = 206
    case firebaseTokenError = 401
    case unAuthorized = 406
    case serverError = 500
    case clientError = 501
}

enum OnQueueStatusCodeCase: Int {
    case success = 200
    case firebaseTokenError = 401
    case unAuthorized = 406
    case serverError = 500
    case clientError = 501
}

enum MyQueueStatusCodeCase: Int {
    case success = 200
    case matchingCanceled = 201
    case firebaseTokenError = 401
    case unAuthorized = 406
    case serverError = 500
    case clientError = 501
}

enum ReportOtherStatusCodeCase: Int {
    case success = 200
    case reported = 201
    case firebaseTokenError = 401
    case unAuthorized = 406
    case serverError = 500
    case clientError = 501
}

enum DodgeStatusCodeCase: Int {
    case success = 200
    case wrongOtherUid = 201
    case firebaseTokenError = 401
    case unAuthorized = 406
    case serverError = 500
    case clientError = 501
}

enum RateStatusCodeCase: Int {
    case success = 200
    case firebaseTokenError = 401
    case unAuthorized = 406
    case serverError = 500
    case clientError = 501
}

enum HobbyRequestStatusCodeCase: Int {
    case success = 200
    case alreadyRecievedRequest = 201
    case canceledMatcting = 202
    case firebaseTokenError = 401
    case unAuthorized = 406
    case serverError = 500
    case clientError = 501
}

enum HobbyAcceptStatusCodeCase: Int {
    case success = 200
    case alreadyMatched = 201
    case canceledMatcting = 202
    case alreadyMatcting = 203
    case firebaseTokenError = 401
    case unAuthorized = 406
    case serverError = 500
    case clientError = 501
}

enum MyStatusCase: Int {
    case normal = 0
    case matching = 1
    case matched = 2
}
