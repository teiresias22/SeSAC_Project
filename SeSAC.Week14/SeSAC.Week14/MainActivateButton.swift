//
//  MainActivateButton.swift
//  SeSAC.Week14
//
//  Created by Joonhwan Jeon on 2022/01/02.
//

import UIKit

@IBDesignable
class MainActiveButton: UIButton {
    
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
        self.backgroundColor = .systemBlue
        self.setTitleColor(.white, for: .normal)
        self.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
