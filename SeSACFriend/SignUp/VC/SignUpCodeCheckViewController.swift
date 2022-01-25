//
//  SignUpCodeCheckViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/19.
//

import UIKit
import FirebaseAuth

class SignUpCodeCheckViewController: BaseViewController {
    let mainView = SignUpCodeCheckView()
    let viewModel = SignUpViewModel()
    let validation = Validation()
    
    var phoneNumber: String = ""
    var verificationCode: String = ""
    
    var timeLimit: Int = 60
    var defaultTime: Int = 59
    
    override func loadView() {
        self.view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.toastMessage(message: "인증번호를 발송했습니다.")
        
        Auth.auth().languageCode = "kr"
        
        getSetTime()
        
        mainView.inputTextField.addTarget(self, action: #selector(phoneNumberTextFieldDidChange(_:)), for: .editingChanged)
        mainView.codeResendButton.addTarget(self, action: #selector(resendCodeButtonClicked), for: .touchUpInside)
        mainView.submitButton.addTarget(self, action: #selector(checkCodeButtonClicked), for: .touchUpInside)
    }
    
    @objc func phoneNumberTextFieldDidChange(_ textField: UITextField) {
        viewModel.varificationCode.value = textField.text ?? ""
    }
    
    @objc func resendCodeButtonClicked() {
        checkTimerEnd()
        let requestNumber = phoneNumber.components(separatedBy: ["-"]).joined()
            print("requestNumber",requestNumber)
            
            PhoneAuthProvider.provider()
                .verifyPhoneNumber("+82\(requestNumber)", uiDelegate: nil) { verificationID, error in
                    if let error = error {
                        print("error is ",error.localizedDescription)
                        return
                    }
                    
                    print("new verificationID ",verificationID)
                    UserDefaults.standard.set(verificationID, forKey: "verificationID")
                }
    }
    
    @objc func checkCodeButtonClicked() {
        //화원가입 여부 확인하여 미가입이면 닉네임 입력으로, 가입되어 있다면 메인 화면으로 보냄
        /*
        self.viewModel.checkCode { authresult, error  in
            
            guard authresult != nil else {
                self.view.makeToast("전화 번호 인증 실패")
                
                return
            }

            if error != nil {
                // 에러처리
                self.view.makeToast("에러가 발생했습니다. 잠시 후 다시 시도해주세요")
                return
            }
            
            print("쳌쳌 성공")
            
            self.viewModel.getUserInfo { myUserInfo ,statuscode ,error in
                switch statuscode {
                case 200:
                    self.view.makeToast("이미 가입된 회원입니다.\n홈 화면으로 이동합니다.")
                    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                        windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: HomeViewController())
                        windowScene.windows.first?.makeKeyAndVisible()

                    }
                    
                case 201 :
                    let vc = AuthNicknameViewController()
                    vc.viewModel = self.viewModel
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                    windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: vc)
                    windowScene.windows.first?.makeKeyAndVisible()
                    
                    
                case 401: // 토큰 만료 -> 갱신
                    Auth.auth().currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
                        
                        if let error = error {
                            self.view.makeToast("토큰 갱신에 실패했습니다\n\(error.localizedDescription)")
                            return
                        }
        
                        if let idToken = idToken {
                            print("idToken 갱신",idToken)
                            UserDefaults.standard.set(idToken, forKey: "idToken")
                        }
                
                    }
                default : // 기타 에러
                    self.view.makeToast("에러코드 : \(statuscode)")
                    
                }
                
            }
            
        }
               
        */
        
        
        
        
        
        
        
        
        
        
        
        /*
        
        verificationCode = viewModel.varificationCode.value
        let verificationID = UserDefaults.standard.string(forKey: "verificationID")!
        
        let credential = PhoneAuthProvider.provider().credential(
          withVerificationID: verificationID,
          verificationCode: verificationCode
        )
        
        Auth.auth().signIn(with: credential) { (success, error) in
            if error == nil {
                print("success : ",success)
                self.navigationController?.pushViewController(SignUpNicknameViewController(), animated: true)
            } else {
                print("error : ",error.debugDescription)
            }
        }*/
    }
    
    @objc func getSetTime() {
        secToTime(sec: timeLimit)
        timeLimit -= 1
    }
    
    func checkTimerEnd() {
        if timeLimit > 0 {
            timeLimit = defaultTime
        } else if timeLimit <= 0 {
            mainView.timerLabel.textColor = .customGreen
            timeLimit = defaultTime
            secToTime(sec: timeLimit)
        }
    }
    
    func secToTime(sec: Int) {
        let minute = (sec % 3600) / 60
        let second = (sec % 3600) % 60
        
        if second < 10 {
            mainView.timerLabel.text = String(minute) + ":" + "0" + String(second)
        } else {
            mainView.timerLabel.text = String(minute) + ":" + String(second)
        }
        
        if timeLimit != 0 {
            perform(#selector(getSetTime), with: nil, afterDelay: 1.0)
        } else if timeLimit <= 0 {
            mainView.timerLabel.textColor = .error
            self.toastMessage(message: "전화번호 인증 실패")
        }
    }
}
