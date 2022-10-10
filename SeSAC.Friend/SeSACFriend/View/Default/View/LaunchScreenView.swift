//
//  LaunchScreenView.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/25.
//

import UIKit
import SnapKit

class LaunchScreenView: UIView, ViewRepresentable {
    let screenImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "splash_logo")
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "SeSAC Friends"
        label.textColor = .customGreen
        label.font = .systemFont(ofSize: 40)
        label.textAlignment = .center
        
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
        addSubview(screenImage)
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        screenImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
            make.width.equalTo(self.snp.width).multipliedBy(0.6)
            make.height.equalTo(self.snp.height).multipliedBy(0.35)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(screenImage.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
    }
}

