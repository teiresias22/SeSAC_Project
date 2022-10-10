//
//  SignUpEmailViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/21.
//

import UIKit

class SignUpEmailViewController: BaseViewController {
    let mainView = SignUpEmailView()
    var viewModel: SignUpViewModel!
    let validation = Validation()
    var isReturn: Bool!
        
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        returnCheck()
        
        mainView.inputTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        mainView.submitButton.addTarget(self, action: #selector(submitButtonClicked), for: .touchUpInside)
    }
    
    @objc func emailTextFieldDidChange(_ textField: UITextField) {
        viewModel.email.value = textField.text ?? ""
        submitButtonActiveCheck()
    }
    
    @objc func submitButtonClicked(_ sender: Any) {
        if validation.isValidEmail(email: viewModel.email.value) {
            let vc = SignUpGenderViewController()
            vc.viewModel = self.viewModel
            vc.isReturn = isReturn
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.toastMessage(message: "이메일 형식이 올바르지 않습니다.")
        }
    }
    
    func submitButtonActiveCheck() {
        if !validation.isValidEmail(email: viewModel.email.value) {
            mainView.submitButton.backgroundColor = .customGray6
        } else {
            mainView.submitButton.backgroundColor = .customGreen
        }
    }
    
    func returnCheck() {
        if isReturn {
            mainView.inputTextField.text = viewModel.email.value
        }
    }
}
