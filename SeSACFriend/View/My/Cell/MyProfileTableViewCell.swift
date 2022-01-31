//
//  MyProfileTableViewCell.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/28.
//

import UIKit
import SnapKit

class MyProfileTableViewCell: UITableViewCell {
    
    static let identifier = "MyProfileTableViewCell"
    
    let iconView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "profile_img")
        
        return view
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .Title1_M16
        label.textColor = .customBlack
        
        return label
    }()
    
    let submitButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow_right"), for: .normal)
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func setViews() {
        addSubview(iconView)
        addSubview(userNameLabel)
        addSubview(submitButton)
    }
    
    func setConstraints() {
        iconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(24)
            make.width.height.equalTo(50)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconView.snp.trailing).offset(12)
            make.top.equalTo(iconView.snp.top).inset(12)
            make.bottom.equalTo(iconView.snp.bottom).inset(12)
            make.trailing.equalTo(submitButton.snp.leading).inset(12)
        }
        
        submitButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(22)
            make.top.equalTo(iconView.snp.top).inset(12)
            make.bottom.equalTo(iconView.snp.bottom).inset(12)
            make.width.equalTo(9)
        }
    }
}
