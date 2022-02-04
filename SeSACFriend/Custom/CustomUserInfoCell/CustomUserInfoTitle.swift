//
//  CustomUserInfoTitle.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/31.
//

import UIKit
import SnapKit

class CustomUserInfoTitle: UIView, ViewRepresentable {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "새싹 타이틀"
        label.font = .Title6_R12
        label.textColor = .customBlack
        
        return label
    }()
    
    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    let horizontalStackView1: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    let customButton1: CustomButtonH32 = {
        let button = CustomButtonH32()
        button.setTitle("좋은 매너", for: .normal)
        
        return button
    }()
    
    let customButton2: CustomButtonH32 = {
        let button = CustomButtonH32()
        button.setTitle("정확한 시간 약속", for: .normal)
        button.backgroundColor = .customWhite
        button.setTitleColor(.customBlack, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.customGray2?.cgColor
        
        return button
    }()
    
    let horizontalStackView2: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    let customButton3: CustomButtonH32 = {
        let button = CustomButtonH32()
        button.setTitle("빠른 응답", for: .normal)
        button.backgroundColor = .customWhite
        button.setTitleColor(.customBlack, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.customGray2?.cgColor
        
        return button
    }()
    
    let customButton4: CustomButtonH32 = {
        let button = CustomButtonH32()
        button.setTitle("친절한 성격", for: .normal)
        
        return button
    }()
    
    let horizontalStackView3: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    let customButton5: CustomButtonH32 = {
        let button = CustomButtonH32()
        button.setTitle("능숙한 취미 실력", for: .normal)
        
        return button
    }()
    
    let customButton6: CustomButtonH32 = {
        let button = CustomButtonH32()
        button.setTitle("유익한 시간", for: .normal)
        
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
        addSubview(titleLabel)
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(horizontalStackView1)
        verticalStackView.addArrangedSubview(horizontalStackView2)
        verticalStackView.addArrangedSubview(horizontalStackView3)
        
        horizontalStackView1.addArrangedSubview(customButton1)
        horizontalStackView1.addArrangedSubview(customButton2)
        
        horizontalStackView2.addArrangedSubview(customButton3)
        horizontalStackView2.addArrangedSubview(customButton4)
        
        horizontalStackView3.addArrangedSubview(customButton5)
        horizontalStackView3.addArrangedSubview(customButton6)
        
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(26)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(112)
        }
        
        horizontalStackView1.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.leading.trailing.equalToSuperview()
        }
        
        horizontalStackView2.snp.makeConstraints { make in
            make.top.equalTo(horizontalStackView1.snp.bottom).offset(8)
            make.height.equalTo(32)
            make.leading.trailing.equalToSuperview()
        }
        
        horizontalStackView3.snp.makeConstraints { make in
            make.top.equalTo(horizontalStackView2.snp.bottom).offset(8)
            make.height.equalTo(32)
            make.leading.trailing.equalToSuperview()
        }
    }
}
