//
//  User.swift
//  SeSAC.Weeks14
//
//  Created by Joonhwan Jeon on 2022/01/08.
//

import Foundation

// MARK: - User
struct User: Codable {
    let jwt: String
    let user: UserClass
}

// MARK: - UserClass
struct UserClass: Codable {
    let id: Int
    let username, email: String
}
