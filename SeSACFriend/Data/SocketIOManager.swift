//
//  SocketIOManager.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/03/22.
//

import Foundation
import SocketIO

class SocketIOManager: NSObject {
    
    static let shared = SocketIOManager()
    var manager: SocketManager!
    var socket: SocketIOClient!
    let url = URL(string: URL.baseURL)!
    var chatList: [Chat] = []
    
    override init() {
        super.init()
        manager = SocketManager(socketURL: URL(string: "http://test.monocoding.com:35484")! , config: [
            .log(true),
            .compress
        ])
        
        socket = manager.defaultSocket
        socket.on(clientEvent: .connect) { data, ack in
            print("socket is connected", data, ack)
            self.socket.emit("changesocketid", UserDefaults.standard.string(forKey: UserDefaultKeys.myUid.rawValue)!)
        }
        
        socket.on(clientEvent: .disconnect) { data, ack in
            print("socket is disconnected", data, ack)
        }
        
        socket.on("chat") { dataArr, ack in
            print("sesac received", dataArr, ack)
            let data = dataArr[0] as! NSDictionary
            let from = data["from"] as! String
            let to = data["to"] as! String
            let chat = data["chat"] as! String
            let createdAt = data["createdAt"] as! String
            let id = data["_id"] as! String
            let v = data["__v"] as! I
            print("check data",from, to, chat, createdAt, id, v)
            
            NotificationCenter.default.post(name: NSNotification.Name("getMessage"), object: self, userInfo: [
                "from" : from,
                "to" : to,
                "chat" : chat,
                "createdAt" : createdAt,
                "_id" : id,
                "__v" : v
            ])
        }
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
}
