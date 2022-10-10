//
//  ChattingView.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/02/12.
//

import UIKit
import SnapKit

class ChattingView: UIView, ViewRepresentable {
    
    let mainTableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        view.isScrollEnabled = true
        
        return view
    }()
    
    let chatView: CustomChattingView = {
        let view = CustomChattingView()
        view.textView.text = "메세지를 입력하세요"
        view.textView.textColor = UIColor.lightGray
        
        return view
    }()
    
    // moreButton을 누르면 열리는 뷰
    let moreView: UIView = {
        let view = UIView()
        view.isHidden = true
        
        return view
    }()
    
    let menuView: CustomMenuView = {
        let view = CustomMenuView()
        view.backgroundColor = .white
        
        return view
    }()
    
    let darkView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        
        return view
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
        
    }
    
    func setupConstraints() {
        
    }
}
