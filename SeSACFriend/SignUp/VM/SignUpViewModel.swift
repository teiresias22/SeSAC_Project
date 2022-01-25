//
//  SignUpViewModel.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/17.
//

import UIKit

class SignUpViewModel {
    var phoneNumber: Observable<String> = Observable("")
    var varificationCode: Observable<String> = Observable("")
    var nickName: Observable<String> = Observable("")
    var email: Observable<String> = Observable("")
    /*
    func checkCode(completion: @escaping (AuthDataResult? ,Error?) -> Void) {
            
            let credential = PhoneAuthProvider.provider().credential(
              withVerificationID: verificationID,
              verificationCode: verificationCode
            )
           
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if error == nil {
                    print("로그인 성공!")

                    let currentUser = Auth.auth().currentUser
                    currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
                        
                        if let error = error {
                            // Handle error
                            completion(authResult ,error)
                            return;
                        }
                        if let idToken = idToken {
                            print("idToken",idToken)
                            self.idToken = idToken
                            UserDefaults.standard.set(idToken, forKey: "idToken")
                        }
                        completion(authResult, nil)
                        
                    }
                    
                } else {
                    completion(nil, error)
                    print("error : ",error.debugDescription)
                    
                }
                
            }
            
        }
     */
}
