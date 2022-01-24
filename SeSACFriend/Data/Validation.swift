//
//  Validation.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/18.
//

import Foundation

class Validation {
    
    // 전화번호 형식 검사
    func isValidPhoneNumber(PN: String) -> Bool {
        let phoneRegEx = "[0-9]{10,11}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: PN)
    }
    
    // 이메일 형식 검사
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    // 닉네임 형식 검사
    func isValidNickname(name: String) -> Bool {
        let nicknameRegEx = "[A-Z0-9a-z._%+-]{4,12}$"
        let nicknameTest = NSPredicate(format: "SELF MATCHES %@", nicknameRegEx)
        return nicknameTest.evaluate(with: name)
    }
    
    // 비밀번호 형식 검사
    func isValidPassword(pwd: String) -> Bool {
        let passwordRegEx = "^[a-zA-Z0-9._%+-]{6,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: pwd)
    }
}
