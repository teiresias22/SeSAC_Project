//
//  SignUpNicknameView.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/19.
//

import UIKit
import SnapKit
import TextFieldEffects

class SignUpNicknameView: UIView, ViewRepresentable {
    
    let mainTextLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임을 입력해 주세요"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .customBlack
        
        return label
    }()
    
    let inputTextField: HoshiTextField = {
        let textfield = HoshiTextField()
        textfield.placeholder = "10자 이내로 입력"
        textfield.borderActiveColor = .focus
        textfield.borderInactiveColor = .customGray7
        
        return textfield
    }()
    
    let submitButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("다음", for: .normal)
        
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
