//
//  FriendView.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/27.
//

import UIKit
import SnapKit

class FriendView: UIView, ViewRepresentable {
    
    let mainTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome Friend Page"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .customBlack
        
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
        addSubview(mainTextLabel)
    }
    
    func setupConstraints() {
        mainTextLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(48)
        }
    }
}
