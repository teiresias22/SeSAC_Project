//
//  MyDetailView.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/29.
//

import UIKit
import SnapKit

class MyDetailView: UIView, ViewRepresentable {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let customCardImageView = CustomCardImageView()
    
    let customUserInfoTabelView = UITableView()
    
    let myDetailBottomView = MyDetailBottomView()
    
    let withdrawButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원 탈퇴", for: .normal)
        button.titleLabel?.font = UIFont.Title4_R14
        button.setTitleColor(.customBlack, for: .normal)
        
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
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(customCardImageView)
        contentView.addSubview(customUserInfoTabelView)
        contentView.addSubview(myDetailBottomView)
        addSubview(withdrawButton)
        
        customCardImageView.requestButton.layer.isHidden = true
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(0)
            make.width.equalTo(self.snp.width)
            make.height.equalTo(self.snp.height)
        }
        
        customCardImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        customUserInfoTabelView.snp.makeConstraints { make in
            make.top.equalTo(customCardImageView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(58)
        }
        
        myDetailBottomView.snp.makeConstraints { make in
            make.top.equalTo(customUserInfoTabelView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(282)
        }
        
        withdrawButton.snp.makeConstraints { make in
            make.top.equalTo(myDetailBottomView.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
    }
}
