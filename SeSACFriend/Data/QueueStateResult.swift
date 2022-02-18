//
//  QueueStateResult.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/02/18.
//

import Foundation

struct QueueStateResult: Codable {
    var dodged: Int
    var matched: Int
    var reviewed: Int
    var matchedNick: String?
    var matchedUid: String?
}
