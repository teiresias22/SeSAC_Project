import UIKit
import RealmSwift
import Alamofire

class BoxofficeRank: Object {
    @Persisted var rankData: List<String>
    @Persisted var movieNmData: List<String>
    @Persisted var openDtData: List<String>
    @Persisted var rankOldAndNewData: List<String>
    @Persisted var audiAccData: List<String>
    @Persisted var movieCdData: List<String>
    @Persisted var nowDate: String
    
    var rankArray: [String] {
        get {
            return rankData.map{$0}
        }
        set {
            rankData.removeAll()
            rankData.append(objectsIn: newValue)
        }
    }
    
    var movieNmArray: [String] {
        get {
            return movieNmData.map{$0}
        }
        set {
            movieNmData.removeAll()
            movieNmData.append(objectsIn: newValue)
        }
    }
    
    var openDtArray: [String] {
        get {
            return openDtData.map{$0}
        }
        set {
            openDtData.removeAll()
            openDtData.append(objectsIn: newValue)
        }
    }
    
    var rankOldAmdNewArray: [String] {
        get {
            return rankOldAndNewData.map{$0}
        }
        set {
            rankOldAndNewData.removeAll()
            rankOldAndNewData.append(objectsIn: newValue)
        }
    }
    
    var audiAccArray: [String] {
        get {
            return audiAccData.map{$0}
        }
        set {
            audiAccData.removeAll()
            audiAccData.append(objectsIn: newValue)
        }
    }
    
    var movieCdArray: [String] {
        get {
            return movieCdData.map{$0}
        }
        set {
            movieCdData.removeAll()
            movieCdData.append(objectsIn: newValue)
        }
    }
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(rankArray: [String], movieNmArray: [String], openDtArray: [String], rankOldAndNewArray: [String], audiAccArray: [String], movieCdArray: [String], nowDate: String) {
        
        self.init()
        
        self.rankData = rankData
        self.movieNmData = movieNmData
        self.openDtData = openDtData
        self.rankOldAndNewData = rankOldAndNewData
        self.audiAccData = audiAccData
        self.movieCdData = movieCdData
        self.nowDate = nowDate
        
        self.rankArray = rankArray
        self.movieNmArray = movieNmArray
        self.openDtArray = openDtArray
        self.rankOldAmdNewArray = rankOldAndNewArray
        self.audiAccArray = audiAccArray
        self.movieCdArray = movieCdArray
        
    }
}
