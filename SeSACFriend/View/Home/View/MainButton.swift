//
//  MainButton.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/03/23.
//

import UIKit

public enum CSButtonType {
    case inactiveButton
    case fill
    case outline
    case cancel
    case disable
}


class MainButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        layer.cornerRadius = 8
        self.titleLabel?.font = .Body3_R14
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
    }
    
    convenience init(type: CSButtonType) {
        self.init()
        
        self.layer.cornerRadius = 8
        self.titleLabel?.font = .Body3_R14

        switch type {
        case .inactiveButton:
            self.clipsToBounds = true
            self.layer.borderColor = UIColor.customGray4?.cgColor
            self.layer.borderWidth = 1
            self.backgroundColor = .white
            self.setTitleColor(.black, for: .normal)
            
        case .fill:
            self.backgroundColor = .green
            self.setTitleColor(.white, for: .normal)
        
        
        case .disable:
            self.backgroundColor = .customGray6
            self.setTitleColor(.customGray3, for: .normal)
            
        case .outline:
            self.clipsToBounds = true
            self.layer.borderColor = UIColor.customGreen?.cgColor
            self.layer.borderWidth = 1
            self.backgroundColor = .white
            self.setTitleColor(.green, for: .normal)
            
        case .cancel:
            self.backgroundColor = .customGray2
            self.setTitleColor(.black, for: .normal)
        }
        
      
    }
    
    var style: CSButtonType = .fill {
        didSet {
            switch style {
            case .fill :
                self.backgroundColor = .green
                self.setTitleColor(.white, for: .normal)
                
            case .disable :
                self.backgroundColor = .customGray6
                self.setTitleColor(.customGray3, for: .normal)
                
            case .inactiveButton:
                self.backgroundColor = .white
                self.setTitleColor(.black, for: .normal)
                
            case .outline:
                self.clipsToBounds = true
                self.layer.borderColor = UIColor.customGreen?.cgColor
                self.layer.borderWidth = 1
                self.backgroundColor = .white
                self.setTitleColor(.green, for: .normal)
                
            case .cancel:
                self.backgroundColor = .customGray2
                self.setTitleColor(.black, for: .normal)
            }
        }
    }
    

}
