//
//  BannerView.swift
//  SeSAC.Week14
//
//  Created by Joonhwan Jeon on 2022/01/02.
//

import Foundation
import UIKit

class BannerView: UIView {
    
    let mainLabel = UILabel()
    let descriptionLabel = UILabel()
    let imageVIew = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("override init")
        loadLayout()
        
    }
    //실패 가능한 이니셜라이져
    required init?(coder: NSCoder) {
        print("required init")
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadLayout() {
        mainLabel.font = .boldSystemFont(ofSize: 15)
        mainLabel.textColor = .black
        mainLabel.text = "내일 오를 주식을 맞췆주세요!"
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.text = "맞히면 500원을 드려요"
        
        mainLabel.frame = CGRect(x: 30, y: 30, width: UIScreen.main.bounds.width - 130, height: 40)
        descriptionLabel.frame = CGRect(x: 30, y: 80, width: UIScreen.main.bounds.width - 130, height: 30)
        
        self.addSubview(mainLabel)
        self.addSubview(descriptionLabel)
    }
    
    
    
    
}
