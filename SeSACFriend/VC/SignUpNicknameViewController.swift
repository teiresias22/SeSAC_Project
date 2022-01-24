//
//  SignUpNicknameViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/21.
//

import UIKit

class SignUpNicknameViewController: BaseViewController {
    let mainView = SignUpNicknameView()
    let viewModel = SignUpNickNameViewModel()
    
    override func loadView() {
        self.view = mainView
        submitButtonActiveCheck()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        mainView.inputTextField.addTarget(self, action: #selector(nickNameTextFieldDidChange(_:)), for: .editingChanged)
        mainView.submitButton.addTarget(self, action: #selector(submitButtonClicked(_:)), for: .touchUpInside)
    }
    
    @objc func nickNameTextFieldDidChange(_ textField: UITextField) {
        viewModel.nickName.value = textField.text ?? ""
        submitButtonActiveCheck()
    }
    
    @objc func submitButtonClicked(_ sender: Any) {
        
        self.navigationController?.pushViewController(SignUpBDViewController(), animated: true)
    }
    
    func submitButtonActiveCheck() {
        if viewModel.nickName.value.count == 0  {
            mainView.submitButton.backgroundColor = .customGray6
        } else if viewModel.nickName.value.count > 10 {
            mainView.submitButton.backgroundColor = .customGray6
        } else {
            mainView.submitButton.backgroundColor = .systemGreen
        }
    }
    
    //self.toastMessage(message: "토스트 메세지 입니다.")
    
    
    
}
