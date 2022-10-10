//
//  Date+Extention.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/27.
//

import Foundation

//나이 계산식
extension Date {
    var age: Int { Calendar.current.dateComponents([.year], from: self, to: Date()).year! }
}
