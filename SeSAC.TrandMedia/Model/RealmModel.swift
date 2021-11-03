import Foundation
import RealmSwift

class BoxofficeLank: Object {
    @Persisted var rankData: String
    @Persisted var movieNmData: String
    @Persisted var openDtData: String
    @Persisted var rankOldAndNewData: String
    @Persisted var audiAccData: String
    @Persisted var nowDate = Date()
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(rankData: String, movieNmData: String, openDtData: String, rankOldAndNewData: String, audiAccData: String, nowDate: Date ) {
        self.init()
        self.rankData = rankData
        self.movieNmData = movieNmData
        self.openDtData = openDtData
        self.rankOldAndNewData = rankOldAndNewData
        self.audiAccData = audiAccData
        self.nowDate = nowDate
    }
}
