//
//  SignUpNicknameViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/21.
//

import UIKit

class SignUpNicknameViewController: BaseViewController {
    let mainView = SignUpNicknameView()
    var viewModel: SignUpViewModel!
    let validation = Validation()
    
    let isReturn = false
    
    override func loadView() {
        self.view = mainView
        submitButtonActiveCheck()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        returnCheck()
                
        mainView.inputTextField.addTarget(self, action: #selector(nickNameTextFieldDidChange(_:)), for: .editingChanged)
        mainView.submitButton.addTarget(self, action: #selector(submitButtonClicked(_:)), for: .touchUpInside)
    }
    
    @objc func nickNameTextFieldDidChange(_ textField: UITextField) {
        viewModel.nickName.value = textField.text ?? ""
        submitButtonActiveCheck()
    }
    
    @objc func submitButtonClicked(_ sender: Any) {
        if validation.isValidNickname(name: viewModel.nickName.value){
            let vc = SignUpBDViewController()
            vc.viewModel = self.viewModel
            vc.isReturn = isReturn
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.toastMessage(message: "닉네임은 1자 이상 10자 이내로 부탁드려요.")
        }
    }
    
    func submitButtonActiveCheck() {
        if validation.isValidNickname(name: viewModel.nickName.value){
            mainView.submitButton.backgroundColor = .systemGreen
        } else {
            mainView.submitButton.backgroundColor = .customGray6
        }
    }
    
    func returnCheck() {
        if isReturn {
            self.toastMessage(message: "해당 닉네임은 사용할 수 없습니다.")
            mainView.inputTextField.text = viewModel.nickName.value
        }
    }
    
}
