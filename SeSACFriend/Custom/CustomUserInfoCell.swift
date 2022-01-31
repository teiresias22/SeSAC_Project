//
//  CustomUserInfoCell.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/31.
//

import UIKit
import SnapKit

class CustomUserInfoCell: UITableViewCell {
    
    static let identifier = "CustomUserInfoCell"
    
    let displayView: UIView = {
        let view = UIView()
        view.backgroundColor = .customWhite
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.customGray2?.cgColor
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    
    let customUserInfoName = CustomUserInfoName()
    let customUserInfoTitle = CustomUserInfoTitle()
    let customUserInfoHobby = CustomUserInfoHobby()
    let customUserInfoReview = CustomUserInfoReview()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func setViews() {
        addSubview(displayView)
        displayView.addSubview(stackView)
        stackView.addSubview(customUserInfoName)
        stackView.addSubview(customUserInfoTitle)
        stackView.addSubview(customUserInfoHobby)
        stackView.addSubview(customUserInfoReview)
    }
    
    func setConstraints() {
        displayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        customUserInfoName.snp.makeConstraints { make in
            make.height.equalTo(58)
        }
        
        customUserInfoTitle.snp.makeConstraints { make in
            make.height.equalTo(146)
        }
        
        customUserInfoHobby.snp.makeConstraints { make in
            make.height.equalTo(66)
        }
    }
}
