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
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    let customButton1: CustomButtonH32 = {
        let button = CustomButtonH32()
        button.setTitle("좋은 매너", for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.Title4_R14
        button.backgroundColor = .customGreen
        button.tintColor = .customWhite
        
        return button
    }()
    
    let customButton2: CustomButtonH32 = {
        let button = CustomButtonH32()
        button.setTitle("정확한 시간 약속", for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.Title4_R14
        button.backgroundColor = .customWhite
        button.tintColor = .customBlack
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
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.Title4_R14
        button.backgroundColor = .customWhite
        button.tintColor = .customBlack
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.customGray2?.cgColor
        
        return button
    }()
    
    let customButton4: CustomButtonH32 = {
        let button = CustomButtonH32()
        button.setTitle("친절한 성격", for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.Title4_R14
        button.backgroundColor = .customGreen
        button.tintColor = .customWhite
        
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
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.Title4_R14
        button.backgroundColor = .customGreen
        button.tintColor = .customWhite
        
        return button
    }()
    
    let customButton6: CustomButtonH32 = {
        let button = CustomButtonH32()
        button.setTitle("유익한 시간", for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.Title4_R14
        button.backgroundColor = .customGreen
        button.tintColor = .customWhite
        
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
        verticalStackView.addSubview(horizontalStackView1)
        horizontalStackView1.addSubview(customButton1)
        horizontalStackView1.addSubview(customButton2)
        verticalStackView.addSubview(horizontalStackView2)
        horizontalStackView2.addSubview(customButton3)
        horizontalStackView2.addSubview(customButton4)
        verticalStackView.addSubview(horizontalStackView3)
        horizontalStackView3.addSubview(customButton5)
        horizontalStackView3.addSubview(customButton6)
        
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(18)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
    }
}
