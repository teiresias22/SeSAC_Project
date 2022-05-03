//
//  CustomChattingRateView.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/03/23.
//

import UIKit
import SnapKit

class ChattingRateView: UIView, ViewRepresentable {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .Title3_M14
        label.textColor = .customBlack
        label.text = "titleLabel"
        
        return label
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close_small"), for: .normal)
        
        return button
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .Title4_R14
        label.textColor = .customGreen
        label.text = "subtitleLabel"
        
        return label
    }()
    
    let rateTagCollectionView = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let rateTextView: UITextView = {
        let view = UITextView()
        view.text = "rateTextView"
        view.textColor = UIColor.lightGray
        view.backgroundColor = .customGray1
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    let rateButton: MainButton = {
        let button = MainButtopn(type: .disable)
        button.setTitle("rateButton", for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 20
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(titleLabel)
        addSubview(cancelButton)
        addSubview(subtitleLabel)
        addSubview(rateTagCollectionView)
        addSubview(rateTextView)
        addSubview(rateButton)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(21)
            make.size.equalTo(20)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        rateTagCollectionView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(72) // 임시
        }
        
        rateTextView.snp.makeConstraints { make in
            make.top.equalTo(rateTagCollectionView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(125)
        }
        
        rateButton.snp.makeConstraints { make in
            make.top.equalTo(rateTextView.snp.bottom).offset(24)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
}
