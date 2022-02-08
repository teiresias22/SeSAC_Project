//
//  CantFindUserView.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/02/08.
//

import UIKit
import SnapKit

class CantFindUserView: UIView, ViewRepresentable {
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "sesac_ic_gray")
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "아쉽게도 주변에 새싹이 없어요ㅠ"
        label.font = UIFont.Display1_R20
        label.textColor = .customBlack
        
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "취미를 변경하거나 조금만 더 기다려 주세요!"
        label.font = UIFont.Title4_R14
        label.textColor = .customGray7
        
        return label
    }()
    
    let submitButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("취미 변경하기", for: .normal)
        
        return button
    }()
    
    let refreshButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_refresh"), for: .normal)
        button.tintColor = .customGreen
        button.layer.borderColor = UIColor.customGreen?.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        
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
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(submitButton)
        addSubview(refreshButton)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(64)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-120)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(22)
        }
        
        submitButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(112)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(refreshButton.snp.leading).inset(-8)
            make.height.equalTo(48)
        }
        
        refreshButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(112)
            make.trailing.equalToSuperview().inset(16)
            make.width.height.equalTo(48)
        }
    }
}
