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
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: SignUpViewController())
            windowScene.windows.first?.makeKeyAndVisible()
        }
    }
}
