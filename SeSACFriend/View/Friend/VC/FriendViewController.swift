//
//  FriendViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/27.
//

import UIKit
import FirebaseAuth

class FriendViewController: BaseViewController {
    let mainView = FriendView()
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
