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
        viewModel.requestNumber.value = viewModel.phoneNumber.value.components(separatedBy: ["-"]).joined()
        submitButtonActiveCheck()
    }
    
    @objc func sendCodeButtonClicked(_ sender: Any) {
        if validation.isValidPhoneNumber(PN: viewModel.phoneNumber.value) {
            
            //인증번호 발송
            self.toastMessage(message: "전화 번호 인증 시작")
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
                
                let vc = SignUpCodeCheckViewController()
                vc.viewModel = self.viewModel
                //vc.verificationID = self.viewModel.verificationID
                //vc.requestNumber = self.viewModel.requestNumber.value
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            view.endEditing(true)
            self.toastMessage(message: "잘못된 형식입니다.")
        }
    }
    
    func submitButtonActiveCheck() {
        if validation.isValidPhoneNumber(PN: viewModel.phoneNumber.value) {
            mainView.submitButton.backgroundColor = .customGreen
        } else {
            mainView.submitButton.backgroundColor = .customGray7
        }
    }
}
