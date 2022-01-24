//
//  SignUpGenderView.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/24.
//

import UIKit
import SnapKit

class SignUpGenderView: UIView, ViewRepresentable {
    
    let mainTextLabel: UILabel = {
        let label = UILabel()
        label.text = "성별을 선택해 주세요"
        label.textAlignment = .center
        label.textColor = .customBlack
        
        return label
    }()
    
    let subTextLabel: UILabel = {
        let label = UILabel()
        label.text = "새싹 찾기 기능을 이용하기 위헤서 필요해요!"
        label.textAlignment = .center
        label.textColor = .customGray4
        
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    let genderManView: CustomGenderView = {
        let view = CustomGenderView()
        
        return view
    }()
    
    let genderFemaleView: CustomGenderView = {
        let view = CustomGenderView()
        
        return view
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
        addSubview(submitButton)
    }
    
    func setupConstraints() {
        submitButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(48)
        }
        
        subTextLabel.snp.makeConstraints { make in
            make.bottom.equalTo(submitButton.snp.top).offset(-72)
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
