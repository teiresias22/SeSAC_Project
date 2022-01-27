//
//  MyViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/27.
//

import UIKit
import FirebaseAuth

class MyViewController: BaseViewController {
    let mainView = MyView()
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
