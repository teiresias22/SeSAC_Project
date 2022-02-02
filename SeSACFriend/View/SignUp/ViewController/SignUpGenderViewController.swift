//
//  SignUpGenderViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/21.
//

//500, 501번 동시 처리
//리턴 코드도 enum으로 처리

import UIKit
import FirebaseAuth

class SignUpGenderViewController: BaseViewController {
    let mainView = SignUpGenderView()
    var viewModel: SignUpViewModel!
    let validation = Validation()
    var isReturn: Bool!
    
    var manButton = false
    var womanButton = false
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        returnCheck()
        
        mainView.genderManView.tag = 100
        mainView.genderWomanView.tag = 200
        
        mainView.genderManView.isUserInteractionEnabled = true
        mainView.genderWomanView.isUserInteractionEnabled = true
        
        mainView.genderManView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewClicked)))
        mainView.genderWomanView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewClicked)))
        mainView.submitButton.addTarget(self, action: #selector(submitButtonClicked), for: .touchUpInside)
    }
    
    @objc func viewClicked(_ sender: UITapGestureRecognizer) {
        if sender.view!.tag == 100 {
            viewModel.gender.value = 1
            manButton = !manButton
            if manButton {
                mainView.genderManView.backgroundColor = .customWhiteGreen
                mainView.genderWomanView.backgroundColor = .customWhite
                womanButton = false
            } else {
                mainView.genderManView.backgroundColor = .customWhite
            }
        } else if sender.view!.tag == 200 {
            viewModel.gender.value = 2
            womanButton = !womanButton
            if womanButton {
                mainView.genderWomanView.backgroundColor = .customWhiteGreen
                mainView.genderManView.backgroundColor = .customWhite
                manButton = false
            } else {
                mainView.genderWomanView.backgroundColor = .customWhite
            }
        }
        submitButtonActiveCheck()
    }
    
    @objc func submitButtonClicked(_ sender: Any) {
        self.viewModel.signUpUserInfo { statuscode, error in
            switch statuscode {
            case 200 :
                self.toastMessage(message: "회원가입에 성공했습니다")
                
                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                    windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: TabBarViewController())
                    windowScene.windows.first?.makeKeyAndVisible()
                }
                
            case 201:
                self.toastMessage(message: "이미 가입한 유저입니다.")
                
            case 202:
                self.toastMessage(message: "사용할 수 없는 닉네임입니다.")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.backToNicknameController()
                }
            case 401:
                Auth.auth().currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
                    
                    if let error = error {
                        self.toastMessage(message: "토큰 갱신에 실패했습니다")
                        //print(error.localizedDescription)
                        return
                    }
                    
                    if let idToken = idToken {
                        //print("idToken 갱신",idToken)
                        UserDefaults.standard.set(idToken, forKey: UserDefault.idToken.rawValue)
                        
                        //갱신후 재요청
                        self.viewModel.signUpUserInfo { statuscode, error in
                            switch statuscode {
                            case 200 :
                                self.toastMessage(message: "회원가입에 성공했습니다")
                                
                                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                                    windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: TabBarViewController())
                                    windowScene.windows.first?.makeKeyAndVisible()
                                }
                                
                            case 201:
                                self.toastMessage(message: "이미 가입한 유저입니다.")
                                
                            case 202:
                                self.toastMessage(message: "사용할 수 없는 닉네임입니다.")
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.backToNicknameController()
                                }
                            default:
                                self.toastMessage(message: "회원가입에 실패했습니다")
                            }
                        }
                        
                    }
            
                }
            default :
                self.toastMessage(message: "회원가입에 실패했습니다")
            }
        }
    }
    
    func submitButtonActiveCheck() {
        if manButton || womanButton {
            mainView.submitButton.backgroundColor = .customGreen
        } else {
            mainView.submitButton.backgroundColor = .customGray7
        }
    }
    
    func backToNicknameController(){
        let viewControllers : [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        
        self.navigationController?.popToViewController(viewControllers[viewControllers.count-4], animated: true)
        
    }
    
    func returnCheck() {
        if isReturn {
            
        }
    }
}
