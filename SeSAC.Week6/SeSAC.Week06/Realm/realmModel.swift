//
//  realmModel.swift
//  SeSAC.Week06
//
//  Created by Joonhwan Jeon on 2021/11/02.
//

import Foundation
import RealmSwift

//UserDiary: 테이블 이름
//@Presisted: 컬럼
class UserDiary: Object {
    @Persisted var diaryTitle: String
    @Persisted var content: String?
    @Persisted var writeDate = Date()
    @Persisted var regDate = Date()
    @Persisted var favorite: Bool
    
    //PK(필수): Int, String, UUID, ObjectId -> AutoIncrement
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(diaryTitle: String, content: String?, writeDate: Date, regDate: Date ) {
        self.init()
        self.diaryTitle = diaryTitle
        self.content = content
        self.writeDate = writeDate
        self.regDate = regDate
        self.favorite = false
    }
    
}
