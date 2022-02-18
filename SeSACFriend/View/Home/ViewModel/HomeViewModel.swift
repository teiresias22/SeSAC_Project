//
//  HomeViewModel.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/27.
//

import UIKit

class HomeViewModel {
    var userInfo: Observable<UserInfo> = Observable(UserInfo(id: "", v: 0, uid: "", phoneNumber: "", email: "", fcMtoken: "",nick:"", birth: "", gender: 0, hobby: "", comment: [], reputation: [], sesac: 0, sesacCollection: [], background: 0, backgroundCollection: [], purchaseToken: [],transactionID: [],reviewedBefore: [], reportedNum: 0, reportedUser: [], dodgepenalty: 0, dodgeNum: 0, ageMin: 0,ageMax: 0,searchable: 1, createdAt: ""))
    
    var onQueueResult: Observable<OnQueueResult> = Observable(OnQueueResult(fromQueueDB: [], fromQueueDBRequested: [], fromRecommend: []))
        
    let stateButtonIconArray = ["ic_antenna", "ic_message", "ic_magnifying"]
    
    var centerLatitude = Observable(0.0)
    var centerLongitude = Observable(0.0)
    var centerRegion = Observable(0)
    
    var searchGender = Observable(-1)
    
    var isLocationEnable = Observable(false)
    
    var myStatus: Observable<Int> = Observable(0)
    
    var fromRecommendHobby: Observable<[String]> = Observable([])
    var fromNearFriendsHobby: Observable<[String]> = Observable([])
    var fromMyHobby: Observable<[String]> = Observable([])

    func searchNearFriends(form: OnQueueForm, completion: @escaping (OnQueueResult?, Int?, Error?) -> Void) {
            QueueAPIService.onQueue(idToken: UserDefaults.standard.string(forKey: UserDefault.idToken.rawValue)!, form: form) { onqueueResult, statuscode, error in
                
                guard let onqueueResult = onqueueResult else {
                    return
                }
                
                self.onQueueResult.value = onqueueResult
                completion(onqueueResult, statuscode, error)
            }
        }
        
    func calculateRegion(myLatitude: Double, myLongitude: Double) {
        
        centerLatitude.value = myLatitude
        centerLongitude.value = myLongitude
        
        var strLatitude = String(myLatitude+90)
        var strLongitude = String(myLongitude+180)
        
        strLatitude = strLatitude.components(separatedBy: ["."]).joined()
        strLongitude = strLongitude.components(separatedBy: ["."]).joined()
        
        //let strRegion = strLatitude.substring(from: 0, to: 4) + strLongitude.substring(from: 0, to: 4)
        //centerRegion.value = Int(strRegion) ?? 0
        
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

    func postQueue(form: PostQueueForm ,completion: @escaping (Int?, Error?) -> Void) {
        QueueAPIService.postQueue(idToken: UserDefaults.standard.string(forKey: UserDefault.idToken.rawValue)!, form: form) { statuscode, error in
            guard let statuscode = statuscode else {
                return
            }
            completion(statuscode, error)
        }
    }
}
