//
//  TabBarViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/27.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .customGreen
        tabBar.unselectedItemTintColor = .customGray6
        tabBar.backgroundColor = .customWhite
        
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem.image = UIImage(named: "Home_ic")
        homeVC.tabBarItem.title = "홈"
        
        let shopVC = UINavigationController(rootViewController: ShopViewController())
        shopVC.tabBarItem.image = UIImage(named: "Shop_ic")
        shopVC.tabBarItem.title = "새싹샵"
        
        let friendVC = UINavigationController(rootViewController: FriendViewController())
        friendVC.tabBarItem.image = UIImage(named: "Friend_ic")
        friendVC.tabBarItem.title = "새싹친구"
        
        let myVC = UINavigationController(rootViewController: MyViewController())
        myVC.tabBarItem.image = UIImage(named: "My_ic")
        myVC.tabBarItem.title = "내정보"
        
        viewControllers = [homeVC, shopVC, friendVC, myVC]
        
    }
}
