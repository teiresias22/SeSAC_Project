//
//  SignUpViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/17.
//

import UIKit
import FirebaseAuth

class SignUpViewController: BaseViewController {
    let mainView = SignUpView()
    let viewModel = SignUpViewModel()
    let validation = Validation()
    
    var phoneNumber: String = ""
    var requestNumber: String = ""
    
    
    override func loadView() {
        self.view = mainView
        submitButtonActiveCheck()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().languageCode = "kr"
        
        viewModel.phoneNumber.bind { text in
            self.mainView.inputTextField.text = text
        }
        mainView.inputTextField.addTarget(self, action: #selector(phoneNumberTextFieldDidChange(_:)), for: .editingChanged)
        mainView.submitButton.addTarget(self, action: #selector(sendCodeButtonClicked), for: .touchUpInside)
    }
    
    @objc func phoneNumberTextFieldDidChange(_ textField: UITextField) {
        viewModel.phoneNumber.value = textField.text ?? ""
        submitButtonActiveCheck()
    }
    
    @objc func sendCodeButtonClicked(_ sender: Any) {
        phoneNumber = viewModel.phoneNumber.value
        requestNumber = phoneNumber.components(separatedBy: ["-"]).joined()
        print("requestNumber",requestNumber)
        
        PhoneAuthProvider.provider()
            .verifyPhoneNumber("+82\(requestNumber)", uiDelegate: nil) { verificationID, error in
                if let error = error {
                    print("error is ",error.localizedDescription)
                    return
                }
                
                UserDefaults.standard.set(verificationID, forKey: "verificationID")
                
                let vc = SignUpCodeCheckViewController()
                vc.phoneNumber = self.phoneNumber
                self.navigationController?.pushViewController(vc, animated: true)
            }
        self.toastMessage(message: "전화 번호 인증 시작")
    }
    
    func submitButtonActiveCheck() {
        if viewModel.phoneNumber.value.count < 9  {
            mainView.submitButton.backgroundColor = .customGray7
        } else {
            mainView.submitButton.backgroundColor = .customGreen
        }
    }
}
