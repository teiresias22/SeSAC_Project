//
//  LaunchScreenViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/25.
//

import UIKit

class LaunchScreenViewController: BaseViewController {
    let mainView = LaunchScreenView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            let isOnboarding = UserDefaults.standard.bool(forKey: "isOnboarding")
            print("isOnboarding", isOnboarding)
            
            if isOnboarding == true {
                self.navigationController?.pushViewController(SignUpViewController(), animated: true)
            } else {
                self.navigationController?.pushViewController(OnboardingViewController(), animated: true)
            }
        }
    }
}
