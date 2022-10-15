//
//  SignViewController.swift
//  SeSAC.Week13
//
//  Created by Joonhwan Jeon on 2022/01/07.
//

import UIKit

class SignViewController: BaseViewController {
    
    var mainView = SignView()
    var viewModel = SignViewModel()
    
    //뷰컨트롤러의 루트뷰를 로드할때 호출되는 메서드
    //새로운 뷰를 반환하려고 할 때 사용
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.bind { text, color in
            self.mainView.passwordTextField.text = text
            self.mainView.passwordTextField.textColor = color
        }
        
    }
    
    override func configure() {
        title = viewModel.navigationTitle
        mainView.emailTextField.placeholder = "이메일을 입력해주세요"
        mainView.emailTextField.text = viewModel.text
        mainView.passwordTextField.placeholder = "비밀번호를 입력해주세요"
        mainView.signButton.addTarget(self, action: #selector(signButtonClicked), for: .touchUpInside)
        mainView.signButton.setTitle(viewModel.buttonTitle, for: .normal)
    }
    
    override func setupConstraints() {
        
    }
    
    @objc func signButtonClicked() {
        print(#function)
        
        guard let text = mainView.emailTextField.text else { return }
        viewModel.text = text
    }
    
}
