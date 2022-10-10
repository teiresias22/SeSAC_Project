//
//  NearUserView.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/02/05.
//

import UIKit
import SnapKit

class NearUserView: UIView, ViewRepresentable {
    let navigationStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 8
        view.alignment = .fill
        view.distribution = .fill
        
        return view
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_arrow"), for: .normal)
        
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "새싹 찾기"
        label.font = UIFont.Title3_M14
        label.textAlignment = .center
        
        return label
    }()
    
    let stopButton: UIButton = {
        let button = UIButton()
        button.setTitle("찾기 중단", for: .normal)
        button.setTitleColor(.customBlack, for: .normal)
        button.titleLabel?.font = .Title3_M14
        return button
    }()
    
    let topStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 0
        view.alignment = .fill
        view.distribution = .fillEqually
        
        return view
    }()
    
    let nearUserView = UIView()
    
    let nearUserButton: UIButton = {
        let button = UIButton()
        button.setTitle("주변 새싹", for: .normal)
        button.setTitleColor(.customGreen, for: .normal)
        button.titleLabel?.font = UIFont.Title3_M14
        button.backgroundColor = .customWhite
        
        return button
    }()
    
    let nearUserBottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .customGreen
        
        return view
    }()
    
    let requestReceivedView = UIView()
    
    let requestRecivedButton: UIButton = {
        let button = UIButton()
        button.setTitle("받은 요청", for: .normal)
        button.setTitleColor(.customGray6, for: .normal)
        button.titleLabel?.font = UIFont.Title3_M14
        button.backgroundColor = .customWhite
        
        return button
    }()
    
    let requestRecivedBottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .customGray2
        
        return view
    }()
    
    let defaultView = CantFindUserView()
    
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        addSubview(navigationStackView)
        navigationStackView.addArrangedSubview(backButton)
        navigationStackView.addArrangedSubview(titleLabel)
        navigationStackView.addArrangedSubview(stopButton)
        
        addSubview(topStackView)
        topStackView.addArrangedSubview(nearUserView)
        nearUserView.addSubview(nearUserButton)
        nearUserView.addSubview(nearUserBottomLine)
        
        topStackView.addArrangedSubview(requestReceivedView)
        requestReceivedView.addSubview(requestRecivedButton)
        requestReceivedView.addSubview(requestRecivedBottomLine)
        
        addSubview(defaultView)
        addSubview(tableView)
    }
    
    func setupConstraints() {
        navigationStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(46)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        backButton.snp.makeConstraints { make in
            make.width.equalTo(56)
        }
        
        stopButton.snp.makeConstraints { make in
            make.width.equalTo(78)
        }
        
        topStackView.snp.makeConstraints { make in
            make.top.equalTo(navigationStackView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        nearUserButton.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(43)
        }
        
        nearUserBottomLine.snp.makeConstraints { make in
            make.top.equalTo(nearUserButton.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        requestRecivedButton.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(43)
        }
        
        requestRecivedBottomLine.snp.makeConstraints { make in
            make.top.equalTo(requestRecivedButton.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        defaultView.snp.makeConstraints { make in
            make.top.equalTo(topStackView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topStackView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
