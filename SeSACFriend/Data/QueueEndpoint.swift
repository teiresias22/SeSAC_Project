//
//  QueueEndpoint.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/02/12.
//

import Foundation

enum QueueEndPoint {
    case onQueue
    case postQueue
    
}

extension QueueEndPoint {
    var url: URL {
        switch self {
        case .onQueue:
            return .makeQueueEndPoint("onqueue")
        case .postQueue:
            return .makeQueueEndPoint("")
        }
    }
}
