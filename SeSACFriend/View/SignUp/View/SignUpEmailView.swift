//
//  SignUpEmailView.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/23.
//

import UIKit
import SnapKit
import TextFieldEffects

class SignUpEmailView: UIView, ViewRepresentable {
    
    let mainTextLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일을 입려해 주세요"
        label.font = .Display1_R20
        label.textAlignment = .center
        label.textColor = .customBlack
        
        return label
    }()
    
    let subTextLabel: UILabel = {
        let label = UILabel()
        label.text = "휴대폰 번호 변경 시 인증을 위해 사용해요"
        label.font = .Title2_R16
        label.textAlignment = .center
        label.textColor = .customGray7
        
        return label
    }()
    
    let inputTextField: HoshiTextField = {
        let textfield = HoshiTextField()
        textfield.placeholder = "SeSAC@email.com"
        textfield.borderActiveColor = .focus
        textfield.borderInactiveColor = .customGray7
        //textfield.becomeFirstResponder()
        
        return textfield
    }()
    
    let submitButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("다음", for: .normal)
        button.backgroundColor = .customGray6
        
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
        addSubview(subTextLabel)
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
        
        subTextLabel.snp.makeConstraints { make in
            make.bottom.equalTo(inputTextField.snp.top).offset(-72)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
        }
        mainTextLabel.snp.makeConstraints { make in
            make.bottom.equalTo(subTextLabel.snp.top).offset(-8)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
        }
    }
}
