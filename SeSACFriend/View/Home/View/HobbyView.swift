//
//  HobbyView.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/02/05.
//

import UIKit
import SnapKit

class HobbyView: UIView, ViewRepresentable {
    
    let topView = UIView()

    let topTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "지금 주변에는"
        label.font = UIFont.Title6_R12
        label.textColor = .customBlack
        
        return label
    }()
    
    let topColectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
       
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return view
    }()
    
    let bottomView = UIView()
    
    let bottomTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "지금 주변에는"
        label.font = UIFont.Title6_R12
        label.textColor = .customBlack
        
        return label
    }()
    
    let bottomColectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
       
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return view
    }()
    
    let submitButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("새싹찾기", for: .normal)
        
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
        addSubview(topView)
        topView.addSubview(topTitleLabel)
        topView.addSubview(bottomColectionView)
        
        addSubview(bottomView)
        bottomView.addSubview(bottomTitleLabel)
        bottomView.addSubview(bottomColectionView)
        
    }
    
    func setupConstraints() {
        topView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(146)
        }
        
        topTitleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(18)
        }
        
        topColectionView.snp.makeConstraints { make in
            make.top.equalTo(topTitleLabel.snp.bottom).inset(16)
            make.leading.equalTo(topView.snp.leading)
            make.trailing.equalTo(topView.snp.trailing)
            make.bottom.equalTo(topView.snp.bottom)
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(146)
        }
        
        bottomTitleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(18)
        }
        
        bottomColectionView.snp.makeConstraints { make in
            make.top.equalTo(bottomTitleLabel.snp.bottom).inset(16)
            make.leading.equalTo(bottomView.snp.leading)
            make.trailing.equalTo(bottomView.snp.trailing)
            make.bottom.equalTo(bottomView.snp.bottom)
        }
    }
}
