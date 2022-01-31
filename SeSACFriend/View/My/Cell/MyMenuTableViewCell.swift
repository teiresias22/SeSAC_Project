//
//  MyMenuTableViewCell.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/28.
//

import UIKit
import SnapKit

class MyMenuTableViewCell: UITableViewCell {
    
    static let identifier = "MyMenuTableViewCell"
    
    let iconView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .customBlack
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .Title2_R16
        label.textColor = .customBlack
        
        return label
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
        addSubview(titleLabel)
    }
    
    func setConstraints() {
        iconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(24)
            make.width.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconView.snp.trailing).offset(12)
            make.top.equalTo(iconView.snp.top)
            make.bottom.equalTo(iconView.snp.bottom)
            make.trailing.equalToSuperview().offset(16)
        }
    }
}
