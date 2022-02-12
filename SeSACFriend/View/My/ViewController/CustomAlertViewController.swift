//
//  CustomAlertViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/02/03.
//

//Todo
//회원탈퇴 API 아직 못함

import UIKit

class CustomAlertViewController: BaseViewController {
    let mainView = CustomAlertView()
    var viewModel: MyViewModel!
        
    override func loadView() {
        self.view = mainView
        mainView.titleLabel.text = "정말 탈퇴하시겠습니까?"
        mainView.subLabel.text = "탈퇴하시면 새싹 프랜즈를 이용할 수 없어요ㅠ"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(displayP3Red: 51/255, green: 51/255, blue: 51/255, alpha: 0.5)
        
        mainView.cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        mainView.submitButton.addTarget(self, action: #selector(submitButtonClicked), for: .touchUpInside)
    }
    
    @objc func cancelButtonClicked() {
        dismiss(animated: false, completion: nil)
    }
    
    @objc func submitButtonClicked() {
        APISevice.widthdrawUserInfo(idToken: UserDefaults.standard.string(forKey: UserDefault.idToken.rawValue)!) { statuscode, error in
            switch statuscode {
            case UserStatusCodeCase.success.rawValue, UserStatusCodeCase.unAuthorized.rawValue:
                if statuscode == UserStatusCodeCase.success.rawValue {
                    self.toastMessage(message: "회원탈퇴에 성공했습니다.")
                } else {
                    self.toastMessage(message: "이미 탈퇴 처리된 회원입니다.")
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                    windowScene.windows.first?.rootViewController = OnboardingViewController()
                    windowScene.windows.first?.makeKeyAndVisible()
                    UIView.transition(with: windowScene.windows.first!, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
                }
                
            case UserStatusCodeCase.firebaseTokenError.rawValue:
                self.refreshFirebaseIdToken { idToken, error in
                    if let idToken = idToken {
                        self.submitButtonClicked()
                    }
                }
                
            case UserStatusCodeCase.serverError.rawValue:
                self.toastMessage(message: "잠시 후 다시 시도해주세요.")
                
            default:
                self.toastMessage(message: "잠시 후 다시 시도해주세요.")
            }
        }
    }
}
