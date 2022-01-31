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
        if name.count > 0 && name.count <= 10 {
            return true
        } else {
            return false
        }
    }
    
    // 비밀번호 형식 검사
    func isValidCode(code: String) -> Bool {
        let codeRegEx = "[0-9]{6}"
        let codeTest = NSPredicate(format: "SELF MATCHES %@", codeRegEx)
        return codeTest.evaluate(with: code)
    }
}
