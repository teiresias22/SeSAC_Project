import UIKit

//사용자, 길드, 길드장?

class Guild {
    
    var guildName: String
    
    var owner: User?
    
    init(guildName: String) {
        self.guildName = guildName
        print("Guild init")
    }
    
    deinit {
        print("Guild Deinit")
    }
}

var sesac: Guild? = Guild(guildName: "SeSAC")
sesac = nil

class User {
    
    var nickname: String
    
    var guild: Guild?
    
    init(nickname: String) {
        self.nickname = nickname
        print("Guild init")
    }
    
    deinit {
        print("Guild Deinit")
    }
}

var nickname: User? = User(nickname: "미묘한도사")
nickname = nil


