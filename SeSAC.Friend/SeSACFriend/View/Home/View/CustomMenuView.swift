//
//  CustomMenuView.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/03/23.
//

import UIKit
import SnapKit

class CustomMenuView: UIView, ViewRepresentable {
    
    let mainStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillEqually
        view.spacing = 0
        view.axis = .horizontal
        
        return view
    }()
    
    let reportStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillProportionally
        view.spacing = 4
        view.axis = .vertical
        
        return view
    }()
    
    let reportButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "report_match"), for: .normal)
        
        return button
    }()
    
    let reportLabel: UILabel = {
        let label = UILabel()
        label.text = "새싹 신고"
        label.font = .Title3_M14
        label.textAlignment = .center
        
        return label
    }()
    
    
    let dodgeStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillProportionally
        view.spacing = 4
        view.axis = .vertical
        
        return view
    }()
    
    let dodgeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "dodge_match"), for: .normal)
        
        return button
    }()
    
    let dodgeLabel: UILabel = {
        let label = UILabel()
        label.text = "약속 취소"
        label.font = .Title3_M14
        label.textAlignment = .center
        
        return label
    }()
    
    let rateStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillProportionally
        view.spacing = 4
        view.axis = .vertical
        
        return view
    }()
    
    
    let rateButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "rate_match"), for: .normal)
        
        return button
    }()
    
    let rateLabel: UILabel = {
        let label = UILabel()
        label.text = "리뷰 등록"
        label.font = .Title3_M14
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(reportStackView)
        reportStackView.addArrangedSubview(reportButton)
        reportStackView.addArrangedSubview(reportLabel)
        
        mainStackView.addArrangedSubview(dodgeStackView)
        dodgeStackView.addArrangedSubview(dodgeButton)
        dodgeStackView.addArrangedSubview(dodgeLabel)
        
        mainStackView.addArrangedSubview(rateStackView)
        rateStackView.addArrangedSubview(rateButton)
        rateStackView.addArrangedSubview(rateLabel)
    }
    
    func setupConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
