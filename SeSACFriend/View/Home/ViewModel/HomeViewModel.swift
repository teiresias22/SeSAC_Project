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
    
    var filteredQueueDB: Observable<[OnQueueResult.OtherUserInfo]> = Observable([])
    var filteredQueueDBRequested:
    Observable<[OnQueueResult.OtherUserInfo]> = Observable([])
    
    let stateButtonIconArray = ["ic_antenna", "ic_message", "ic_magnifying"]
    
    var centerLatitude = Observable(0.0)
    var centerLongitude = Observable(0.0)
    var centerRegion = Observable(0)
    var searchGender = Observable(-1)
    var isLocationEnable = Observable(false)
    
    var myStatus: Observable<Int> = Observable(0)
    
    var fromRecommendHobby: Observable<[String]> = Observable([])
    var fromNearFriendsHobby: Observable<[String]> = Observable([])
    var fromMyHobby: Observable<[String]> = Observable(["코딩", "클라이밍", "고양이", "??"])

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
        //위도에서 90을 더하고 소수점을 제거한 뒤 앞에서 5개의 숫자를 가져옵니다.
        var strLat = String(myLatitude+90)
        strLat = strLat.components(separatedBy: ["."]).joined()
        
        let startLatIndex = strLat.index(strLat.startIndex, offsetBy: 0)
        let endLatIndex = strLat.index(strLat.startIndex, offsetBy: 4)
        let latRange = startLatIndex...endLatIndex
        
        let strLatIndex = strLat[latRange]
        
        //경도에서 180을 더하고 소수점을 제거한 뒤 앞에서 5개의 숫자를 가져옵니다.
        var strLong = String(myLongitude+180)
        strLong = strLong.components(separatedBy: ["."]).joined()
        
        let startLongIndex = strLong.index(strLong.startIndex, offsetBy: 0)
        let endLongIndex = strLong.index(strLong.startIndex, offsetBy: 4)
        let longRange = startLongIndex...endLongIndex
        
        let strLongIndex = strLong[longRange]
        
        //위도와 경도 값을 더해서 전송
        let strRegion = strLatIndex + strLongIndex
        centerRegion.value = Int(strRegion) ?? 0
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
    
    func deleteQueue(completion: @escaping (Int?, Error?) -> Void) {
        QueueAPIService.deleteQueue(idToken: UserDefaults.standard.string(forKey: UserDefault.idToken.rawValue)!) { statuscode, error in
            
            guard let statuscode = statuscode else {
                return
            }
            completion(statuscode, error)
        }
        
    }
    
    func hobbyRequest(otheruid: String, completion: @escaping (Int?, Error?) -> Void) {
        QueueAPIService.hobbyRequest(idToken: UserDefaults.standard.string(forKey: UserDefault.idToken.rawValue)!, otheruid: otheruid) { statuscode, error in
            
            guard let statuscode = statuscode else {
                return
            }
            completion(statuscode, error)
        }
    }
    
    func hobbyAccept(otheruid: String, completion: @escaping (Int?, Error?) -> Void) {
        QueueAPIService.hobbyAccept(idToken: UserDefaults.standard.string(forKey: UserDefault.idToken.rawValue)!, otheruid: otheruid) { statuscode, error in
            
            guard let statuscode = statuscode else {
                return
            }
            completion(statuscode, error)
        }
    }
    
    func checkMyQueueStatus(completion: @escaping (QueueStateResult?, Int?, Error?) -> Void) {
        QueueAPIService.checkMyQueueStatus(idToken: UserDefaults.standard.string(forKey: UserDefault.idToken.rawValue)!) { myQueueState, statuscode, error in
            
            guard let myQueueState = myQueueState else {
                return
            }
            completion(myQueueState, statuscode, error)
        }
    }
    
    func writeReview(form: WriteReviewFrom, completion: @escaping (Int?, Error?) -> Void) {
        QueueAPIService.writeReview(idToken: UserDefaults.standard.string(forKey: UserDefault.idToken.rawValue)!, form: form) { statuscode, error in
            
            guard let statuscode = statuscode else {
                return
            }
            completion(statuscode, error)
        }
    }
    
    func dodgeMatching(otheruid: String, completion: @escaping (Int?, Error?) -> Void) {
        QueueAPIService.dodgeMatching(idToken: UserDefaults.standard.string(forKey: UserDefault.idToken.rawValue)!, otheruid: otheruid) { statuscode, error in
            
            guard let statuscode = statuscode else {
                return
            }
            completion(statuscode, error)
        }
    }
}
