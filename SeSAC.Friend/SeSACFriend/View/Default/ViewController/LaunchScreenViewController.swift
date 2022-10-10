//
//  LaunchScreenViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/25.
//

import UIKit
import FirebaseAuth

class LaunchScreenViewController: BaseViewController {
    let mainView = LaunchScreenView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().currentUser?.getIDToken { idToken, error in
            if let error = error {
                print("getIDTokenError", error)
                return
            }

            if let idToken = idToken {
                //PropertyWraooer -> example 추후에 적용할것, 요즘 많이 사용함
                //UserDefaults.standard.set(idToken, forKey
                UserDefaults.standard.set(idToken, forKey: UserDefault.idToken.rawValue)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            let isOnboarding = UserDefaults.standard.bool(forKey: UserDefault.isOnboarding.rawValue)
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            if isOnboarding {
                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: SignUpViewController())
            } else {
                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: OnboardingViewController())
            }
            windowScene.windows.first?.makeKeyAndVisible()
            
        }
    }
}
