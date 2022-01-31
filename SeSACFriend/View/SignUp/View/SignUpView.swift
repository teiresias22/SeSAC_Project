//
//  SignUpView.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/17.
//

import UIKit
import SnapKit
import TextFieldEffects

class SignUpView: UIView, ViewRepresentable {
    
    let mainTextLabel: UILabel = {
        let label = UILabel()
        label.text = "새싹 서비스 이용을 위해 \n휴대폰 번호를 입력해 주세요"
        label.numberOfLines = 0
        label.font = .Display1_R20
        label.textAlignment = .center
        label.textColor = .customBlack
        
        return label
    }()
    
    let inputTextField: HoshiTextField = {
        let textfield = HoshiTextField()
        textfield.placeholder = "휴대폰 번호(-없이 숫자만 입력)"
        textfield.font = .Title4_R14
        textfield.borderActiveColor = .focus
        textfield.borderInactiveColor = .customGray7
        textfield.keyboardType = .numberPad
        //textfield.becomeFirstResponder()
        
        return textfield
    }()
    
    let submitButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("인증 문자 받기", for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        addSubview(mainTextLabel)
        addSubview(inputTextField)
        addSubview(submitButton)
    }
    
    func setupConstraints() {
        submitButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(48)
        }
        
        inputTextField.snp.makeConstraints { make in
            make.bottom.equalTo(submitButton.snp.top).offset(-72)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(48)
        }
        
        mainTextLabel.snp.makeConstraints { make in
            make.bottom.equalTo(inputTextField.snp.top).offset(-72)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
        }
    }
}

