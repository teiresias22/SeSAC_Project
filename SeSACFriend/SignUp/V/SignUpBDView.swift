//
//  SignUpBDView.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/22.
//

import UIKit
import SnapKit
import TextFieldEffects

class SignUpBDView: UIView, ViewRepresentable {
    
    let mainTextLabel: UILabel = {
        let label = UILabel()
        label.text = "생년월일을 알려주세요"
        label.font = .Display1_R20
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .customBlack
        
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
    
    let inputYearTextField: HoshiTextField = {
        let textfield = HoshiTextField()
        textfield.placeholder = "1990"
        textfield.textAlignment = .center
        textfield.borderActiveColor = .focus
        textfield.borderInactiveColor = .customGray7
        
        return textfield
    }()
    
    let yearLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = "년"
        label.textAlignment = .center
        label.textColor = .customBlack
        
        return label
    }()
    
    let inputMonthTextField: HoshiTextField = {
        let textfield = HoshiTextField()
        textfield.placeholder = "1"
        textfield.textAlignment = .center
        textfield.borderActiveColor = .focus
        textfield.borderInactiveColor = .customGray7
        
        return textfield
    }()
    
    let monthLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = "월"
        label.textAlignment = .center
        label.textColor = .customBlack
        
        return label
    }()
    
    let inputDayTextField: HoshiTextField = {
        let textfield = HoshiTextField()
        textfield.placeholder = "21"
        textfield.textAlignment = .center
        textfield.borderActiveColor = .focus
        textfield.borderInactiveColor = .customGray7
        
        return textfield
    }()
    
    let dayLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = "일"
        label.textAlignment = .center
        label.textColor = .customBlack
        
        return label
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
        
        addSubview(stackView)
        stackView.addArrangedSubview(inputYearTextField)
        stackView.addArrangedSubview(yearLabel)
        stackView.addArrangedSubview(inputMonthTextField)
        stackView.addArrangedSubview(monthLabel)
        stackView.addArrangedSubview(inputDayTextField)
        stackView.addArrangedSubview(dayLabel)
        
        addSubview(submitButton)
    }
    
    func setupConstraints() {
        submitButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(40)
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
        
        mainTextLabel.snp.makeConstraints { make in
            make.bottom.equalTo(stackView.snp.top).offset(-72)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
        }
        
        inputYearTextField.snp.makeConstraints { make in
            make.width.equalTo(80)
        }
        
        inputMonthTextField.snp.makeConstraints { make in
            make.width.equalTo(80)
        }
        
        inputDayTextField.snp.makeConstraints { make in
            make.width.equalTo(80)
        }
    }
}

