//
//  MyViewModel.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/27.
//

import UIKit
import Firebase

class MyViewModel {
        
    var myInfoIconArray = [UIImage(named: "notice_ic"), UIImage(named: "faq_ic"), UIImage(named: "qna_ic"), UIImage(named: "setting_alarm_ic"), UIImage(named: "permit_ic")]
    
    var myInfoTitleArray = ["공지사항", "자주 묻는 질문", "1:1 문의", "알림 설정", "이용 약관"]
    
    var numberOfRowsInSection: Int {
        return myInfoIconArray.count+1
    }
    
    func cellForRowAt(indexPath: IndexPath) -> (UIImage?,String?) {
        return (myInfoIconArray[indexPath.row-1], myInfoTitleArray[indexPath.row-1])
    }
    
    
}
