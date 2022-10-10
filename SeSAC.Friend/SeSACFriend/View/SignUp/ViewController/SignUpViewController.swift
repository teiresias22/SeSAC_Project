//
//  SignUpViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/17.
//

//Todo
//1. 전화번호 양식 처리
//SU_VC: 전화번호 입력창에 10자리, 11자리에 양식에 맞춰서 - 표시 처리 해야함
//value가 10개인경우와 11개인경우를 나눠서 처리하면 될것 같음

//2. 로그인 미완료시 입력 데이터 앱 재시작 후에도 유지
//지금은 ViewModel을 넘겨주어서 데이터를 옮겼는데 그럼 종료하고 재시작 하는 경우 데이터가 사라짐
//유저 디폴트로 저장도 함께 병행해서 로그인에 성공하고나면 데이터를 삭제하는 식으로 해야 할것 같음

//3. CustomTextField 제작
//화면 진입시 키보드를 활성화를 하면 placeholder가 표시가 안됨
//TextFieldEffects의 HoshiTextField가 아예 안먹히는건가 싶기도함
//그럼 결국 TextField를 커스텀 해서 넣어야 하는가봄

//4. ToastMessage 가려짐
//ToastMessage를 띄워줄때, 키보드가 올라와있으면 그 뒤로 표시됨

//5. 인증번호 자동으로 가져오기
//SUCC_VC: 인증 번호 자동으로 가져오는 기능, 인증 번호 자리수 확인

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
                    //print("error",error!.localizedDescription)
                    //print("error",error.debugDescription)

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
