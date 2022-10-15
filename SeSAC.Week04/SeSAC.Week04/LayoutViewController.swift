//
//  LayoutViewController.swift
//  SeSAC.Week04
//
//  Created by Joonhwan Jeon on 2021/10/22.
//

import UIKit

class LayoutViewController: UIViewController {

    @IBOutlet weak var conteinerViewHeight: NSLayoutConstraint!
    
    var heightStatus = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func blackButtonClicked(_ sender: UIButton) {
        
        heightStatus = !heightStatus
        
        conteinerViewHeight.constant = heightStatus ? UIScreen.main.bounds.height * 0.2 : 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    

}
