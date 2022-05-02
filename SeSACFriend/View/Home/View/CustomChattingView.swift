//
//  CustomChattingView.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/03/22.
//


import UIKit
import SnapKit

class CustomChattingView: UIView, ViewRepresentable {
    
    let textView: UITextView = {
        let view = UITextView()
        view.tintColor = .black
        view.backgroundColor = .customGray1
        view.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return view
    }()
    
    let sendMessageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "sendButton"), for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 8
        backgroundColor = .customGray1
        setupView()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(textView)
        addSubview(sendMessageButton)
    }
    
    func setupConstraints() {
        textView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.top.bottom.equalToSuperview().inset(14)
            make.trailing.equalTo(sendMessageButton.snp.leading).offset(-10)
            make.height.equalTo(16)
        }
        
        sendMessageButton.snp.makeConstraints { make in
            make.centerY.equalTo(textView)
            make.trailing.equalToSuperview().inset(14)
            make.size.equalTo(20)
        }
    }
}
