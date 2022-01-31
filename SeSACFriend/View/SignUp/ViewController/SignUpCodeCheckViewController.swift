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
    var viewModel: SignUpViewModel!
    let validation = Validation()
    
    var timeLimit: Int = 60
    var defaultTime: Int = 59
    
    override func loadView() {
        self.view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.toastMessage(message: "인증번호를 발송했습니다.")
        getSetTime()
        codeCount()
        
        mainView.inputTextField.addTarget(self, action: #selector(phoneNumberTextFieldDidChange(_:)), for: .editingChanged)
        mainView.codeResendButton.addTarget(self, action: #selector(resendCodeButtonClicked), for: .touchUpInside)
        mainView.submitButton.addTarget(self, action: #selector(submitButtonClicked), for: .touchUpInside)
    }
    
    @objc func phoneNumberTextFieldDidChange(_ textField: UITextField) {
        viewModel.varificationCodeText.value = textField.text ?? ""
        codeCount()
    }
    
    //코드 재발송
    @objc func resendCodeButtonClicked() {
        //타이머 초기화
        resetTime()
        
        viewModel.requestCode { verificationID, error in
            guard let verificationID = verificationID else {
                //error
                print("error",error!.localizedDescription)
                print("error",error.debugDescription)

                switch error!.localizedDescription {
                case AuthResponse.blocked.rawValue: self.toastMessage(message: "과도한 인증 시도가 있었습니다.")
                default:
                    self.toastMessage(message: "에러가 발생했습니다.다시 시도해주세요")
                }
                return
            }
            self.viewModel.verificationID = verificationID
        }
        self.toastMessage(message: "인증번호가 재전송 되었습니다.")
    }
    
    @objc func submitButtonClicked() {
        if !validation.isValidCode(code: viewModel.varificationCodeText.value) {
            self.toastMessage(message: "인증번호를 확인해주세요.")
            return
        }
        
        viewModel.checkCode { authresult, error in
            guard authresult != nil else {
                self.toastMessage(message: "전화번호 인증 실패")
                return
            }
            
            if error != nil {
                self.toastMessage(message: "에러가 발생했습니다.다시 시도해주세요")
                return
            }
            
            print("submit Succeed!")
            
            self.viewModel.getUserInfo { UserInfo, statuscode, error in
                switch statuscode {
                //성공, 기존 유저
                case 200: self.toastMessage(message: "이미 가입된 사용자 입니다.")
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                    windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: HomeViewController())
                    windowScene.windows.first?.makeKeyAndVisible()
                }
                
                //미가입 유저
                case 201: self.toastMessage(message: "인증에 성공하였습니다.")
                let vc = SignUpNicknameViewController()
                vc.viewModel = self.viewModel
                self.navigationController?.pushViewController(vc, animated: true)
                    
                //Firebase Token 만료
                case 401: self.toastMessage(message: "사용자 정보를 갱신중입니다.")
                    Auth.auth().currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
                        if error != nil {
                            self.toastMessage(message: "Error")
                            return
                        }
                        
                        if let idToken = idToken {
                            UserDefaults.standard.set(idToken, forKey: UserDefault.idToken.rawValue)
                        }
                    }
                //Server Error
                case 500: self.toastMessage(message: "Server Error")
                //Clioemt Error
                case 501: self.toastMessage(message: "Clioemt Error")
                //그 외
                default: self.toastMessage(message: "알수없는 오류 발생 :\(String(describing: statuscode))Error")
                }
            }
        }
    }
    
    //타이머설정
    @objc func getSetTime() {
        secToTime(sec: timeLimit)
        timeLimit -= 1
    }
    
    //재발송 타이머
    func resetTime() {
        if timeLimit > 0 {
            timeLimit = defaultTime
        } else if timeLimit <= 0 {
            mainView.timerLabel.textColor = .customGreen
            timeLimit = defaultTime
            secToTime(sec: timeLimit)
        }
        view.endEditing(true)
    }
    
    //타이머 표기
    func secToTime(sec: Int) {
        let minute = (sec % 3600) / 60
        let second = (sec % 3600) % 60
        
        if second < 10 {
            mainView.timerLabel.text = String(minute) + ":" + "0" + String(second)
        } else {
            mainView.timerLabel.text = String(minute) + ":" + String(second)
        }
        
        if timeLimit > 0 {
            perform(#selector(getSetTime), with: nil, afterDelay: 1.0)
        } else if timeLimit <= 0 {
            mainView.timerLabel.textColor = .error
            self.toastMessage(message: "전화번호 인증 실패")
        }
    }
    
    //코드입력수 확인
    func codeCount() {
        if validation.isValidCode(code: viewModel.varificationCodeText.value){
            mainView.submitButton.backgroundColor = .customGreen
        } else {
            mainView.submitButton.backgroundColor = .customGray7
        }
    }
}
