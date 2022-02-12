//
//  Endpoint.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/21.
//

//반복되는. "User" 도 묶어서 표기하는게 좋다.

import Foundation

enum Method: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum EndPoint {
    case getUserInfo
    case postUserInfo
    case widthdrawUserInfo
    case updateUserInfo
    case updateFCMToken
}

extension EndPoint {
    var url: URL {
        switch self {
        case .getUserInfo:
            return .makeEndPoint("user")
        case .postUserInfo:
            return .makeEndPoint("user")
        case .widthdrawUserInfo:
            return .makeEndPoint("user/withdraw")
        case .updateUserInfo:
            return .makeEndPoint("update/mypage")
        case .updateFCMToken:
            return .makeEndPoint("update_fcm_token")
        }
    }
}

extension URL {
    static let baseURL = "http://test.monocoding.com:35484/"
    
    static func makeEndPoint(_ endpoint: String) -> URL {
        URL(string: baseURL + endpoint)!
    }
    
    static func makeQueueEndPoint(_ endpoint: String) -> URL {
        URL(string: baseURL + "queue/" + endpoint)!
    }
}
