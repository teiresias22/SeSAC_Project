//
//  SignUpGenderView.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/24.
//

import UIKit
import SnapKit

class SignUpGenderView: UIView, ViewRepresentable {
    
    let mainTextLabel: UILabel = {
        let label = UILabel()
        label.text = "성별을 선택해 주세요"
        label.font = .Display1_R20
        label.textAlignment = .center
        label.textColor = .customBlack
        
        return label
    }()
    
    let subTextLabel: UILabel = {
        let label = UILabel()
        label.text = "새싹 찾기 기능을 이용하기 위헤서 필요해요!"
        label.font = .Title2_R16
        label.textAlignment = .center
        label.textColor = .customGray7
        
        return label
    }()
    
    let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    let genderManView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.customGray3?.cgColor
        view.layer.cornerRadius = 8
        view.backgroundColor = .customWhite
        return view
    }()
    
    let genderWomanView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.customGray3?.cgColor
        view.layer.cornerRadius = 8
        view.backgroundColor = .customWhite
        
        return view
    }()
    
    let manStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    let womanStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    let manImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ic.man")
        
        return image
    }()
    
    let womanImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ic.woman")
        
        return image
    }()
    
    let manTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "남자"
        label.font = .Title2_R16
        label.textAlignment = .center
        
        return label
    }()
    
    let womanTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "여자"
        label.font = .Title2_R16
        label.textAlignment = .center
        
        return label
    }()
    
    let submitButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("다음", for: .normal)
        button.backgroundColor = .customGray6
        
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
        addSubview(mainTextLabel)
        addSubview(subTextLabel)
        addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(genderManView)
        genderManView.addSubview(manStackView)
        manStackView.addArrangedSubview(manImageView)
        manStackView.addArrangedSubview(manTitleLabel)
        horizontalStackView.addArrangedSubview(genderWomanView)
        genderWomanView.addSubview(womanStackView)
        womanStackView.addArrangedSubview(womanImageView)
        womanStackView.addArrangedSubview(womanTitleLabel)
        addSubview(submitButton)
    }
    
    func setupConstraints() {
        submitButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(48)
        }
        
        horizontalStackView.snp.makeConstraints { make in
            make.bottom.equalTo(submitButton.snp.top).offset(-32)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(120)
        }
        
        subTextLabel.snp.makeConstraints { make in
            make.bottom.equalTo(horizontalStackView.snp.top).offset(-32)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
        }
        
        mainTextLabel.snp.makeConstraints { make in
            make.bottom.equalTo(subTextLabel.snp.top).offset(-8)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
        }
        
        manStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(64)
        }
        
        manImageView.snp.makeConstraints { make in
            make.width.equalTo(64)
            make.height.equalTo(64)
        }
        
        manTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(26)
        }
        
        womanStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(64)
        }
        
        womanImageView.snp.makeConstraints { make in
            make.width.equalTo(64)
            make.height.equalTo(64)
        }
        
        womanTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(26)
        }
        
    }
}
