//
//  CustomButtonH32.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/30.
//

import UIKit

class CustomButtonH32: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {return layer.cornerRadius}
        set {layer.cornerRadius = newValue}
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {return layer.borderWidth}
        set {layer.borderWidth = newValue}
    }
    
    @IBInspectable var borderColor: UIColor {
        get {return UIColor(cgColor: layer.borderColor!)}
        set {layer.borderColor = newValue.cgColor}
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .customGreen
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = .Title4_R14
        self.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
