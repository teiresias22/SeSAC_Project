//
//  BaseViewController.swift
//  SeSAC.Week13
//
//  Created by Joonhwan Jeon on 2022/01/07.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupConstraints()
    }
    
    func configure() {
        view.backgroundColor = .white
    }
    
    func setupConstraints (){
        
    }
}
