//
//  CustomAlertView.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/02/03.
//

import UIKit
import SnapKit

class CustomAlertView: UIView, ViewRepresentable {
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .customWhite
        view.layer.cornerRadius = 16
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.Body1_M16
        label.textAlignment = .center
        
        return label
    }()
    
    let subLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.Title4_R14
        label.textAlignment = .center
        
        return label
    }()
    
    let buttonStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .fill
        view.spacing = 8
        view.distribution = .fillEqually
        
        return view
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.customBlack, for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .customGray2
        
        return button
    }()
    
    let submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.customWhite, for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .customGreen
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        backgroundColor = UIColor(displayP3Red: 51/255, green: 51/255, blue: 51/255, alpha: 0.5)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subLabel)
        contentView.addSubview(buttonStackView)
        
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(submitButton)
    }
    
    func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(156)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(30)
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(22)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
}


