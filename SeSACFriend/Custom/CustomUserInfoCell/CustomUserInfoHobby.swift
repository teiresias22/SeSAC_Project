//
//  CustomUserInfoHobby.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/31.
//

import UIKit
import SnapKit

class CustomUserInfoHobby: UIView, ViewRepresentable {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "하고 싶은 취미"
        label.font = .Title6_R12
        label.textColor = .customBlack
        
        return label
    }()
    
    let customLabel1: CustomLabel = {
        let label = CustomLabel()
        label.text = "산책"
        label.font = UIFont.Title4_R14
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.customGray2?.cgColor
        label.layer.cornerRadius = 8
        
        return label
    }()
    
    let customLabel2: CustomLabel = {
        let label = CustomLabel()
        label.text = "클라이밍"
        label.font = UIFont.Title4_R14
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.customGray2?.cgColor
        label.layer.cornerRadius = 8
        
        return label
    }()
    
    let customLabel3: CustomLabel = {
        let label = CustomLabel()
        label.text = "전시회"
        label.font = UIFont.Title4_R14
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.customGray2?.cgColor
        label.layer.cornerRadius = 8
        
        return label
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
        addSubview(titleLabel)
        addSubview(customLabel1)
        addSubview(customLabel2)
        addSubview(customLabel3)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(18)
        }
        
        customLabel1.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(32)
        }
        
        customLabel2.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalTo(customLabel1.snp.trailing).offset(8)
            make.height.equalTo(32)
        }
        
        customLabel3.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalTo(customLabel2.snp.trailing).offset(8)
            make.height.equalTo(32)
        }
    }
}
