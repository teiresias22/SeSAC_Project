//
//  MyDetailBottomView.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/02/01.
//

import UIKit
import SnapKit
import TextFieldEffects

class MyDetailBottomView: UIView, ViewRepresentable {
    
    let genderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "내 성별"
        label.font = .Title4_R14
        
        return label
    }()
    
    let manButton: UIButton = {
        let button = UIButton()
        button.setTitle("남자", for: .normal)
        button.titleLabel?.font = UIFont.Title4_R14
        button.backgroundColor = .customGreen
        
        return button
    }()
    
    let womanButton: UIButton = {
        let button = UIButton()
        button.setTitle("여자", for: .normal)
        button.titleLabel?.font = UIFont.Title4_R14
        button.tintColor = .customBlack
        
        return button
    }()
    
    let hobbyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    let hobbyLabel: UILabel = {
        let label = UILabel()
        label.text = "자주 하는 취미"
        label.font = .Title4_R14
        label.textColor = .customBlack
        
        return label
    }()
    
    let hobbyInputTextfield: HoshiTextField = {
        let textfield = HoshiTextField()
        textfield.placeholder = "취미를 입력해 주세요"
        
        return textfield
    }()
    
    let allowSearchStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    let allowSearchLabel: UILabel = {
        let label = UILabel()
        label.text = "내 번호 검색 허용"
        label.font = .Title4_R14
        label.textColor = .customBlack
        
        return label
    }()
    
    let allowSearchSwitch: UISwitch = {
        let searchSwitch = UISwitch()
        searchSwitch.thumbTintColor = .customWhite
        searchSwitch.onTintColor = .customGreen
        
        return searchSwitch
    }()
    
    
    let ageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        label.text = "상대방 연령대"
        label.font = .Title4_R14
        label.textColor = .customBlack
        
        return label
    }()
    
    let ageRangeLabel: UILabel = {
        let label = UILabel()
        label.text = "18 - 35"
        label.font = .Title3_M14
        label.textColor = .customGreen
        
        return label
    }()
    
    let ageSlider: UISlider = {
        let slider = UISlider()
        slider.thumbTintColor = .customGreen
        slider.maximumValue = 60
        slider.minimumValue = 18
        
        return slider
    }()
    
    let widthDrawStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    let widthDrawLabel: UILabel = {
        let label = UILabel()
        label.text = "회원 탈퇴"
        label.font = .Title4_R14
        
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
        addSubview(genderStackView)
        genderStackView.addSubview(genderLabel)
        genderStackView.addSubview(manButton)
        genderStackView.addSubview(womanButton)
        
        addSubview(hobbyStackView)
        hobbyStackView.addSubview(hobbyLabel)
        hobbyStackView.addSubview(hobbyInputTextfield)
        
        addSubview(allowSearchStackView)
        allowSearchStackView.addSubview(allowSearchLabel)
        allowSearchStackView.addSubview(allowSearchSwitch)
        
        addSubview(ageStackView)
        ageStackView.addSubview(ageLabel)
        ageStackView.addSubview(ageRangeLabel)
        addSubview(ageSlider)
        
        addSubview(widthDrawStackView)
        widthDrawStackView.addSubview(widthDrawLabel)
    }
    
    func setupConstraints() {
        genderStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        genderLabel.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.trailing.equalTo(manButton.snp.leading).inset(8)
        }
        
        manButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalTo(womanButton.snp.leading).inset(8)
            make.width.equalTo(60)
        }
        
        womanButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(8)
            make.width.equalTo(60)
        }
        
        hobbyStackView.snp.makeConstraints { make in
            make.top.equalTo(genderStackView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        hobbyLabel.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.trailing.equalTo(hobbyInputTextfield.snp.leading).inset(8)
        }
        
        hobbyInputTextfield.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.width.equalTo(164)
        }
        
        allowSearchStackView.snp.makeConstraints { make in
            make.top.equalTo(hobbyStackView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        allowSearchLabel.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.trailing.equalTo(allowSearchSwitch.snp.leading).inset(8)
        }
        
        allowSearchSwitch.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.width.equalTo(52)
        }
        
        ageStackView.snp.makeConstraints { make in
            make.top.equalTo(allowSearchStackView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        ageLabel.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.trailing.equalTo(ageRangeLabel.snp.leading).inset(8)
        }
        
        ageRangeLabel.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.width.equalTo(44)
        }
        
        ageSlider.snp.makeConstraints { make in
            make.top.equalTo(ageStackView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(24)
        }
        
        widthDrawStackView.snp.makeConstraints { make in
            make.top.equalTo(ageSlider.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        widthDrawLabel.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.width.equalTo(60)
        }
    }
}
