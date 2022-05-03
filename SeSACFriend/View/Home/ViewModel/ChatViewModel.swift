//
//  ChatViewModel.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/03/22.
//

import Foundation

class ChatViewModel {
    
    static let shared = ChatViewModel()
    var chatList: Observable<[Chat]> = Observable([])
    var tmpLastChatDate = "2022-01-16T06:55:54.784Z"
    
    final func recieveMessage(lastchatDate: String, from: String, completion: @escaping (Chats?, Int?) -> Void) {
        
        ChatAPIService.recieveMessage(idToken: UserDefaults.standard.string(forKey: UserDefault.idToken.rawValue)!, from: from, lastchatDate: lastchatDate) { chats, statuscode in
            
            guard let chats = chats else {
                completion(nil, statuscode)
                return
            }
            self.chatList.value = chats.payload
            completion(chats, statuscode)
        }
    }
    
    final func sendMessage(chat: String, to: String, completion: @escaping (Chat?, Int?) -> Void) {
        
        ChatAPIService.sendMessage(idToken: UserDefaults.standard.string(forKey: UserDefault.idToken.rawValue)!, chat: chat, to: to) { chat, statuscode in
            
            guard let chat = chat else {
                completion(nil, statuscode)
                return
            }
            completion(chat, statuscode)

            
        }
        
    }
    
    
}
