//
//  TabBarController.swift
//  SeSAC.Week14
//
//  Created by Joonhwan Jeon on 2022/01/04.
//

import UIKit

//NavigationController, TabBarController
//TabBar, TabBarItem(title, image, selectImage), tintColor
//iOS13 : UITabBarAppearence 버전에 따른 분기 필요
class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstVC = SettingViewController(nibName: "SettingViewController", bundle: nil)
        firstVC.tabBarItem.title = "설정 화면"
        firstVC.tabBarItem.image = UIImage(systemName: "star")
        firstVC.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
        
        let secondVC = SnapDetailViewController()
        secondVC.tabBarItem = UITabBarItem(title: "스냅킷", image: UIImage(systemName: "trash"), selectedImage: UIImage(systemName: "trash.fill"))
        
        let thirdVC = DetailViewController()
        thirdVC.title = "디테일"
        let thirdNav = UINavigationController(rootViewController: thirdVC)
        //디테일뷰의 뷰디드로드에서 설정
        
        setViewControllers([firstVC, secondVC, thirdNav], animated: true)
        
        //첫 화면에서 다른 버튼이 안보이는것
        let appearence = UITabBarAppearance()
        appearence.configureWithOpaqueBackground()
        
        tabBar.standardAppearance = appearence
        tabBar.scrollEdgeAppearance = appearence
        tabBar.tintColor = .black
        
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(item)
    }
    
}
