//
//  NearUserViewCell.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/02/08.
//

import UIKit
import SnapKit

class NearUserViewCell: UITableViewCell {
    static let identifier = "NearUserViewCell"
    
    let cardImageView = CustomCardImageView()
    
    let nameView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.customGray2?.cgColor
        
        return view
    }()
    
    let nameText: UILabel = {
        let label = UILabel()
        label.text = "userNick"
        label.font = UIFont.Title1_M16
        
        return label
    }()
    
    let seeMoreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow_down"), for: .normal)
        button.tintColor = .customGray7
        
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
        addSubview(cardImageView)
        addSubview(nameView)
        nameView.addSubview(nameText)
        nameView.addSubview(seeMoreButton)
    }
    
    func setConstraints() {
        cardImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        nameView.snp.makeConstraints { make in
            make.top.equalTo(cardImageView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(58)
        }
        
        nameText.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(seeMoreButton.snp.leading).inset(8)
        }
        
        seeMoreButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(21)
            make.trailing.equalToSuperview().inset(16)
        }
    }
}
