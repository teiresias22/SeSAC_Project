//
//  Memo.swift
//  SeSAC.Day.09
//
//  Created by Joonhwan Jeon on 2021/10/14.
//

import Foundation

enum Category: Int {
    case business = 0, personal, others
    
    var description: String {
        switch self {
        case .business:
            return "업무"
        case .personal:
            return "개인"
        case .others:
            return "기타"
        }
    }
}

struct Memo {
    var content: String
    var category: Category
}
