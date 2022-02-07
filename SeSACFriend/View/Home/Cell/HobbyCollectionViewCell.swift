//
//  HobbyCollectionViewCell.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/02/05.
//

import UIKit

class HobbyCollectionViewCell: UICollectionViewCell {
    
    let textLabel: CustomLabel = {
        let label = CustomLabel()
        label.textColor = .error
        label.font = .Title4_R14
        label.layer.cornerRadius = 8
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.error?.cgColor
        label.backgroundColor = .customWhite
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func setViews() {
        addSubview(textLabel)
    }
    
    func setConstraints() {
        textLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
