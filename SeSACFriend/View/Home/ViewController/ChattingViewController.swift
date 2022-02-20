//
//  ChattingViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/02/12.
//

import UIKit
import FirebaseAuth

class ChattingViewController: BaseViewController {
    let mainView = NearUserView()
    var viewModel: HomeViewModel!
    
    override func loadView() {
        self.view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
}
 
