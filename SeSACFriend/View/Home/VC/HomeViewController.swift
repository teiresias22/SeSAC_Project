//
//  HomeViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/25.
//

import UIKit
import FirebaseAuth

class HomeViewController: BaseViewController {
    let mainView = HomeView()
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
