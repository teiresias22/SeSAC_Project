//
//  MyViewModel.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/27.
//

import UIKit
import Firebase

class MyViewModel {
    
    var userInfo: Observable<UserInfo> = Observable(UserInfo(id: "", v: 0, uid: "", phoneNumber: "", email: "", fcMtoken: "",nick:"UserNick", birth: "", gender: 0, hobby: "", comment: [], reputation: [], sesac: 0, sesacCollection: [], background: 0, backgroundCollection: [], purchaseToken: [],transactionID: [],reviewedBefore: [], reportedNum: 0, reportedUser: [], dodgepenalty: 0, dodgeNum: 0, ageMin: 0,ageMax: 0,searchable: 1, createdAt: ""))
    
    var ageMin = Observable(0)
    var ageMax = Observable(0)
    var searchable = Observable(1)
    var gender = Observable(-1)
    var hobby = Observable("")
    
    var myInfoIconArray = [UIImage(named: "ic_notice"), UIImage(named: "ic_faq"), UIImage(named: "ic_qna"), UIImage(named: "ic_setting_alarm"), UIImage(named: "ic_permit")]
    
    var myInfoTitleArray = ["공지사항", "자주 묻는 질문", "1:1 문의", "알림 설정", "이용 약관"]
    
    func updateObservable() {
        ageMin.value = userInfo.value.ageMin
        ageMax.value = userInfo.value.ageMax
        searchable.value = userInfo.value.searchable
        gender.value = userInfo.value.gender
        hobby.value = userInfo.value.hobby
    }
    
    func getUserInfo(completion: @escaping (UserInfo?, Int?, Error?) -> Void) {
        APISevice.getUserInfo(idToken: UserDefaults.standard.string(forKey: UserDefault.idToken.rawValue)!) { userInfo, statuscode, error  in
            guard let userInfo = userInfo else {
                return
            }
            self.userInfo.value = userInfo
            
            completion(userInfo,statuscode,error)
        }
    }
    
    func updateMypage(form: UpdateUserInfoForm, completion: @escaping (Int?) -> Void) {
        APISevice.updateUserInfo(idToken: UserDefaults.standard.string(forKey: UserDefault.idToken.rawValue)!, form: form) { statuscode in
            guard let statuscode = statuscode else {
                return
            }
            completion(statuscode)
        }
    }
    
    
    // MARK: - TableView Setting
    var numberOfRowsInSection: Int {
        return myInfoIconArray.count+1
    }
    
    func cellForRowAt(indexPath: IndexPath) -> (UIImage?,String?) {
        return (myInfoIconArray[indexPath.row-1], myInfoTitleArray[indexPath.row-1])
    }
}
