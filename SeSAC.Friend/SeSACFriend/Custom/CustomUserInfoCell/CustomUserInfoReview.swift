//
//  CustomUserInfoReview.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/31.
//

import UIKit
import SnapKit

class CustomUserInfoReview: UIView, ViewRepresentable {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "새싹 리뷰"
        label.font = .Title6_R12
        label.textColor = .customBlack
        
        return label
    }()
    
    let moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow_right"), for: .normal)
        
        return button
    }()
    
    let reviewTextLabel: UILabel = {
        let label = UILabel()
        label.text = "첫 리뷰를 기다리는 중이에요!"
        label.font = .Body3_R14
        label.textColor = .customGray6
        label.numberOfLines = 3
        
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
        addSubview(moreButton)
        addSubview(reviewTextLabel)
        
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(moreButton.snp.leading).inset(10)
            make.height.equalTo(26)
        }
        
        moreButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(18)
            make.width.equalTo(6)
            make.height.equalTo(12)
        }
        
        reviewTextLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
    }
}
