//
//  SettingViewController.swift
//  SeSAC.Week14
//
//  Created by Joonhwan Jeon on 2022/01/04.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController {
    
    let testButton: UIButton = {
        let button = UIButton()
        button.setTitle("테스트용", for: .normal)
        button.addTarget(self, action: #selector(testButtonClicked), for: .touchDown)
        return button
    }()
    
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(name)
        view.backgroundColor = .systemGreen
        
        view.addSubview(testButton)
        
        testButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
            make.width.equalTo(view).multipliedBy(0.7)
            make.height.equalTo(view).multipliedBy(0.2)
        }
    }
    
    @objc func testButtonClicked() {
        let vc = testViewController()
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
}
