//
//  SignUpNicknameViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/21.
//

//Todo
//지금 ViewModel을 넘겨주어서 데이터를 옮겼는데 그럼 종료하고 재시작 하는 경우 데이터가 사라짐
//유저 디폴트로 저장해서 로그인에 성공하고나면 데이터를 삭제하는 식으로 해야 할까?

//화면 진입시 키보드를 활성화를 하면 placeholder가 표시가 안됨
//TextFieldEffects의 HoshiTextField가 아예 안먹히는건가 싶기도함
//그럼 결국 TextField를 커스텀 해서 넣어야 하는가봄

//ToastMessage를 띄워줄때, 키보드가 올라와있으면 그 뒤로 표시됨


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
