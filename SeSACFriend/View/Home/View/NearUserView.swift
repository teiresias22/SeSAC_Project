//
//  NearUserView.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/02/05.
//

import UIKit
import SnapKit

class NearUserView: UIView, ViewRepresentable {
    
    let topStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
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
    
    let collectionView = UICollectionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        
    }
    
    func setupConstraints() {
        
    }
}
