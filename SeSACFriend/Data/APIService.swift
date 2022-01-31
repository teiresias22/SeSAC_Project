//
//  APIService.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/20.
//

//ApiService도 사용 요소별로 

import Foundation
import Alamofire
import SwiftyJSON

class APISevice {
    
    static func getUserInfo(idToken: String, completion: @escaping (UserInfo? , Int?, Error?) -> Void) {
        let headers = ["idtoken": idToken] as HTTPHeaders
        
        AF.request(EndPoint.getUserInfo.url.absoluteString, method: .get, headers: headers).responseDecodable(of: UserInfo.self) { response in
            
            let statusCode = response.response?.statusCode
            switch response.result {
            case.success(_):
                completion(response.value, statusCode, nil)
                
            case.failure(let error):
                completion(nil, statusCode, error)
            }
        }
        .responseString { response in
            print("responseString", response)
        }
    }
    
    
    static func signUpUserInfo(idToken: String, form: SignUpForm, completion: @escaping (Int?, Error?) -> Void){
        let headers = ["idtoken": idToken,
                       "Content-Type": "application/x-www-form-urlencoded"] as HTTPHeaders
       
        let parameters : Parameters = [
            "phoneNumber" : form.phoneNumber,
            "FCMtoken" : form.FCMtoken,
            "nick" : form.nick,
            "birth" : form.birth,
            "email" : form.email,
            "gender" : form.gender
            
        ]
        
        AF.request(EndPoint.postUserInfo.url.absoluteString, method: .post, parameters: parameters, headers: headers)
            .responseString { response in
                completion(response.response?.statusCode, nil)
            }
    }
    
    static func deleteUserInfo(idToken: String, completion: @escaping (Int?, Error?) -> Void){
        let headers = ["idtoken": idToken,
                       "Content-Type": "application/x-www-form-urlencoded"] as HTTPHeaders
    
        AF.request(EndPoint.deleteUserInfo.url.absoluteString, method: .post, headers: headers).responseString { response in
            
            completion(response.response?.statusCode, nil)
        }
    }
    
    
}
