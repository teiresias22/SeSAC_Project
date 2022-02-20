//
//  SignUpViewModel.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/17.
//

//로직 > 비즈니스 로직(연산, 통신)회원가입 등등 ViewModel UIKit이 필요 없음 // UI 로직 (화면 전환) ViewController

import Firebase

class SignUpViewModel {
    var phoneNumber: Observable<String> = Observable("")
    var requestNumber: Observable<String> = Observable("")
    var varificationCodeText: Observable<String> = Observable("")
    
    var nickName: Observable<String> = Observable("")
    var birthDay: Observable<Date> = Observable(Date.now)
    var email: Observable<String> = Observable("")
    var gender: Observable<Int> = Observable(-1)
    
    var verificationID = ""
    
    var idToken = ""
    var fcmToken = UserDefaults.standard.string(forKey: UserDefault.FCMToken.rawValue)
    
    func requestCode(completion: @escaping (String?,Error?) -> Void) {
        PhoneAuthProvider.provider()
            .verifyPhoneNumber("+82\(requestNumber.value)", uiDelegate: nil) { verificationID, error in
                
                if let error = error {
                    completion(nil, error)
                    return
                }
                completion(verificationID, nil)
            }
    }
    
    func checkCode(completion: @escaping (AuthDataResult? ,Error?) -> Void) {
        let credential = PhoneAuthProvider.provider().credential(
          withVerificationID: verificationID,
          verificationCode: varificationCodeText.value
        )
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if error == nil {
                //print("login Succeed!")
                
                let currentUser = Auth.auth().currentUser
                currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
                    if let error = error {
                        completion(authResult ,error)
                        return;
                    }
                    if let idToken = idToken {
                        //print("idToken",idToken)
                        self.idToken = idToken
                        UserDefaults.standard.set(idToken, forKey: UserDefault.idToken.rawValue)
                    }
                    completion(authResult, nil)
                }
            } else {
                completion(nil, error)
                //print("error : ",error.debugDescription)
            }
        }
    }
    
    func getUserInfo(completion: @escaping (UserInfo?, Int?, Error?) -> Void) {
        APISevice.getUserInfo(idToken: idToken) { userinfo, statuscode, error in
            completion(userinfo, statuscode, error)
        }
    }
    
    func signUpUserInfo(completion: @escaping (Int?, Error?) -> Void) {
        let form = SignUpForm(phoneNumber: "+82" + requestNumber.value, FCMtoken: fcmToken!, nick: nickName.value, email: email.value, birth: birthDay.value, gender: gender.value)
        
        APISevice.signUpUserInfo(idToken: idToken, form: form) { statuscode, error in
            completion(statuscode, error)
        }
    }
    
    
    //입력한 생일 추출
    //인터넷을 찾아보니 subString으로 많이 나오는데 이제는 deprecated 되어서 활용이 안되는듯??
    //일단은 임시로? 억지로? 잘라서 나눠본다.
    func getBirthday(_ birthday:Date) -> [String] {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        let selectDate: String = dateFormatter.string(from: birthday)
        
        let firstindex = selectDate.firstIndex(of: "/")!
        let lastIndex = selectDate.lastIndex(of: "/")!
        
        let year = selectDate[..<firstindex]
        var month = selectDate[firstindex..<lastIndex]
        let monthIdx = month.index(month.startIndex, offsetBy: 1)
        month = Substring(month[monthIdx...])
        
        var day = selectDate[lastIndex...]
        let dayIdx = day.index(day.startIndex, offsetBy: 1)
        day = Substring(day[dayIdx...])
        
        return [String(year), String(month), String(day)]
    }
    
    //나이 계산
    func getAge() -> Int {
        let age = birthDay.value.age
        
        return age
    }
}
