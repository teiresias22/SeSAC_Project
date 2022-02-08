//
//  HobbyView.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/02/05.
//

import UIKit
import SnapKit

class HobbyView: UIView, ViewRepresentable {
    
    let topTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "지금 주변에는"
        label.font = UIFont.Title6_R12
        label.textColor = .customBlack
        
        return label
    }()
    
    let topColectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.collectionViewLayout = CollectionViewLeftAlignFlowLayout()
        
        if let flowLayout = view.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        
        return view
    }()
    
    let bottomTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "지금 주변에는"
        label.font = UIFont.Title6_R12
        label.textColor = .customBlack
        
        return label
    }()
    
    let bottomColectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.collectionViewLayout = CollectionViewLeftAlignFlowLayout()
        
        if let flowLayout = view.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
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
        self.backgroundColor = .customWhite
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        addSubview(topTitleLabel)
        addSubview(topColectionView)
        addSubview(bottomTitleLabel)
        addSubview(bottomColectionView)
        addSubview(submitButton)
    }
    
    func setupConstraints() {
        
        topTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(122)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(22)
        }
        
        topColectionView.snp.makeConstraints { make in
            make.top.equalTo(topTitleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(114)
        }
        
        bottomTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(topColectionView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(18)
        }
        
        bottomColectionView.snp.makeConstraints { make in
            make.top.equalTo(bottomTitleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(120)
        }
        
        submitButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(112)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
}

class CollectionViewLeftAlignFlowLayout: UICollectionViewFlowLayout {
    let cellSpacing: CGFloat = 8
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.minimumLineSpacing = 8.0
        self.sectionInset = UIEdgeInsets(top: 5.0, left: 16.0, bottom: 5.0, right: 16.0)
        let attributes = super.layoutAttributesForElements(in: rect)
 
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + cellSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        return attributes
    }
}
