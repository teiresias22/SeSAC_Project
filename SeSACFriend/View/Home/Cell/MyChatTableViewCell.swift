//
//  MyChatTableViewCell.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/03/23.
//

import UIKit
import SnapKit

class MyChatTableViewCell: UITableViewCell, ViewRepresentable {
    var viewModel = HomeViewModel()
    static let identifier = "MyChatTableViewCell"
    
    let borderView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = .customWhiteGreen
        
        return view
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customBlack
        label.font = .Body3_R14
        label.numberOfLines = 0
        
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customGreen
        label.font = .Title6_R12
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(borderView)
        addSubview(messageLabel)
        addSubview(timeLabel)
    }
    
    func setupConstraints() {
        borderView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(16)
            make.width.lessThanOrEqualTo(264)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(borderView).inset(10)
            make.leading.trailing.equalTo(borderView).inset(16)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(borderView)
            make.trailing.equalTo(borderView.snp.leading).offset(-8)
        }
    }
}
