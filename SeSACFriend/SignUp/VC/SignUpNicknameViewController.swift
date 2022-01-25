//
//  SignUpNicknameViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/21.
//

//Todo
//금지된 단어로 돌아왔을때 기존에 입력한 정보가 유지되어 있어야 함
//화면 진입시 키보드를 활성화 하는데 placeholder가 표시가 안됨
//TextFieldEffects의 HoshiTextField가 아예 안먹히는건가 싶기도


import UIKit

class SignUpNicknameViewController: BaseViewController {
    let mainView = SignUpNicknameView()
    let viewModel = SignUpViewModel()
    
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.mainView.inputTextField.resignFirstResponder()
    }
    
    
    
}
