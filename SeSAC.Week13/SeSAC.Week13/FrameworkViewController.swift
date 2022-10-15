//
//  FrameworkViewController.swift
//  SeSAC.Week13
//
//  Created by Joonhwan Jeon on 2022/01/08.
//

import UIKit
import SeSACFramework

class FrameworkViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let sesac = SeSACOpen()
        sesac.presentWebViewController(url: "http://www.naver.com", transitionStyle: .push, vc: self)
    }
}
