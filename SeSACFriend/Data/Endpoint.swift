//
//  Endpoint.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/21.
//

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
    case deleteUserInfo
}

extension EndPoint {
    var url: URL {
        switch self {
        case .getUserInfo:
            return .makeEndPoint("user")
        case .postUserInfo:
            return .makeEndPoint("user")
        case .deleteUserInfo:
            return .makeEndPoint("user/withdraw")
        }
    }
}

extension URL {
    static let baseURL = "http://test.monocoding.com:35484/"
    
    static func makeEndPoint(_ endpoint: String) -> URL {
        URL(string: baseURL + endpoint)!
    }
}
