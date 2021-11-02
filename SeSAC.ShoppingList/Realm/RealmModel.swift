import Foundation
import RealmSwift

class shoppingList: Object {
    @Persisted var title: String
    @Persisted var favorite: Bool
    @Persisted var complete: Bool
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(title: String) {
        self.init()
        self.title = title
        self.favorite = favorite
        self.complete = complete
    }
}
