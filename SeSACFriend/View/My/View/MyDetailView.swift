//
//  MyDetailView.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/29.
//

//Todo
//스크롤뷰를 기본으로 올리고,
//상단의 이미지와 이름, 토글버튼은 별도의 View로 제작해서 Main에서 재사용
//그 밑에 부분을 깔쌈하게 각각의 줄마다 StackView로 담아서 구성한다?

//탈퇴 확인창 커스텀하기

import UIKit
import SnapKit

class MyDetailView: UIView, ViewRepresentable {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let customCardImageView = CustomCardImageView()
    
    let customUserInfoTabelView: UITableView = {
        let view = UITableView()
        
        return view
    }()
    
    var isOpen = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.addSubview(customCardImageView)
        scrollView.addSubview(customUserInfoTabelView)
        
        customCardImageView.requestButton.layer.isHidden = true
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(0)
            make.width.equalTo(self.snp.width)
            make.height.equalTo(self.snp.height)
        }
        
        customCardImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
    }
}
