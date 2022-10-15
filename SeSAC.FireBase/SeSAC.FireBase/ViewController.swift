//
//  ViewController.swift
//  SeSAC.FireBase
//
//  Created by Joonhwan Jeon on 2021/12/06.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
          //AnalyticsParameterItemID: "id-\(title!)",
          //AnalyticsParameterItemName: title!,
          AnalyticsParameterContentType: "cont",
        ])
    }

    @IBAction func crashlyticsTestButton(_ sender: UIButton) {
        let numbers = [0]
        let _ = numbers[1]
    }
    
}

