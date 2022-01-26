//
//  SignUpCodeCheckView.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/18.
//

import UIKit
import SnapKit
import TextFieldEffects

class SignUpCodeCheckView: UIView, ViewRepresentable {
    
    let mainTextLabel: UILabel = {
       let label = UILabel()
        label.text = "인증번호가 문자로 전송되었어요."
        label.font = .Display1_R20
        label.textAlignment = .center
        label.textColor = .customBlack
        
        return label
    }()
    
    let subTextLabel: UILabel = {
        let label = UILabel()
        label.text = "(최대 소모 20초)"
        label.font = .Title2_R16
        label.textAlignment = .center
        label.textColor = .customGray4
        
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.font = .Title3_M14
        label.textAlignment = .center
        label.textColor = .customGreen
        
        return label
    }()
    
    let inputTextField: HoshiTextField = {
        let textfield = HoshiTextField()
        textfield.placeholder = "인증번호 입력"
        textfield.font = .Title4_R14
        textfield.borderActiveColor = .focus
        textfield.borderInactiveColor = .customGray7
        textfield.keyboardType = .numberPad
        
        return textfield
    }()
    
    let codeResendButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("재전송", for: .normal)
        
        return button
    }()
    
    let submitButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("인증하고 시작하기", for: .normal)
        
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
        addSubview(stackView)
        stackView.addArrangedSubview(inputTextField)
        stackView.addArrangedSubview(timerLabel)
        stackView.addArrangedSubview(codeResendButton)
        addSubview(submitButton)
    }
    
    func setupConstraints() {
        submitButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(48)
        }
        
        stackView.snp.makeConstraints { make in
            make.bottom.equalTo(submitButton.snp.top).offset(-72)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(48)
        }
        
        subTextLabel.snp.makeConstraints { make in
            make.bottom.equalTo(stackView.snp.top).offset(-72)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
        }
        
        mainTextLabel.snp.makeConstraints { make in
            make.bottom.equalTo(subTextLabel.snp.top).offset(-8)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
        }
        
        codeResendButton.snp.makeConstraints { make in
            make.width.equalTo(72)
        }
        
        timerLabel.snp.makeConstraints { make in
            make.width.equalTo(72)
        }
    }
    
}
