//
//  ShopViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/27.
//

import UIKit
import FirebaseAuth

class ShopViewController: BaseViewController {
    let mainView = ShopView()
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "새싹샵"
        
    }
}
