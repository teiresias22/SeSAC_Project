//
//  CustomCardImageView.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/29.
//

import UIKit
import SnapKit

class CustomCardImageView: UIView, ViewRepresentable {
    
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sesac_bg_01")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let userIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "sesac_face_1")
        
        return imageView
    }()
    
    let requestButton: UIButton = {
        let button = UIButton()
        button.setTitle("요청하기", for: .normal)
        button.backgroundColor = .error
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.Title3_M14
        
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
        addSubview(backgroundImageView)
        backgroundImageView.addSubview(userIconView)
        backgroundImageView.addSubview(requestButton)
    }
    
    func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        requestButton.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.top).inset(12)
            make.trailing.equalTo(backgroundImageView.snp.trailing).inset(12)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        
        userIconView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(backgroundImageView.snp.top).inset(19)
            make.size.equalTo(184)
        }
        
    }
    
}
