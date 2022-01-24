//
//  CustomGenderView.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/24.
//

import UIKit
import SnapKit

class CustomGenderView: UIView {
    let setImate = ""
    let setTitle = ""
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = setTitle
        
        
        return label
    }()
    
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
        self.cornerRadius = 8
        self.borderWidth = 1
        self.borderColor = .customGray6 ?? .systemGray6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
