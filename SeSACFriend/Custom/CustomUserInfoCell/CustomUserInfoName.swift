//
//  CustomUserInfoName.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/29.
//

import UIKit
import SnapKit

class CustomUserInfoName: UIView, ViewRepresentable {
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "get.user.nick"
        label.font = .Title1_M16
        label.textColor = .customBlack
        
        return label
    }()
    
    let toggleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow_down"), for: .normal)
        
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
        addSubview(nameLabel)
        addSubview(toggleButton)
    }
    
    func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(toggleButton.snp.leading).inset(10)
            make.height.equalTo(26)
        }
        
        toggleButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(26)
            make.trailing.equalToSuperview().inset(18)
            make.width.equalTo(12)
            make.height.equalTo(6)
        }
    }
}
