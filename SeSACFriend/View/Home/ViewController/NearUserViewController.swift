//
//  NearUserViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/02/05.
//

import UIKit
import FirebaseAuth

class NearUserViewController: BaseViewController {
    let mainView = HobbyView()
    var viewModel: HomeViewModel!
    
    override func loadView() {
        self.view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "새싹찾기"
        
    }
}
