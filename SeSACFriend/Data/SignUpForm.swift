//
//  SignUpForm.swift
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
