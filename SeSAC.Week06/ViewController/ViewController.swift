//
//  ViewController.swift
//  SeSAC.Week06
//
//  Created by Joonhwan Jeon on 2021/11/01.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        testLabel.text = NSLocalizedString("testlabel", comment: "")
        testLabel.font = UIFont().mainHeavy
    }


}

