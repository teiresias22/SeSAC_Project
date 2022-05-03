//
//  ChattingHeaderTableViewCell.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/03/03.
//

import UIKit
import SnapKit

class ChattingHeaderTableViewCell: UITableViewCell, ViewRepresentable {
    
    static let identifier = "ChattingHeaderTableViewCell"
    
    private let titleStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 4
        
        return view
    }()
    
    private let alarmImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bell")
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .Title3_M14
        label.textColor = .customGray7
        
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .Title4_R14
        label.textColor = .customGray7
        label.text = "채팅을 통해 약속을 정해보세요 :)"
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView() {
        addSubview(titleStackView)
        titleStackView.addArrangedSubview(alarmImageView)
        titleStackView.addArrangedSubview(titleLabel)
        addSubview(subtitleLabel)
    }
    
    func setupConstraints() {
        titleStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.centerX.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleStackView.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(12)
        }
    }
}
