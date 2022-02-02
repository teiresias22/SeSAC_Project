//
//  MyView.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/27.
//

import UIKit
import SnapKit

class MyView: UIView, ViewRepresentable {
    
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
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
