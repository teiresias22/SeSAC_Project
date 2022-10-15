import UIKit
import RealmSwift

extension UIViewController {
    
    func searchQueryFromUserDiary(text: String) -> Results<UserDiary> {
        let localRealm = try! Realm()
        
        let search = localRealm.objects(UserDiary.self).filter("diaryTitle CONTAINS[c] '\(text)' or content CONTAINS[c] '\(text)'")
        
        return search
    }
    
    func getAllDiaryCountFromUserDiary() -> Int {
        let localRealm = try! Realm()
        
        return localRealm.objects(UserDiary.self).count
    }
    
}
