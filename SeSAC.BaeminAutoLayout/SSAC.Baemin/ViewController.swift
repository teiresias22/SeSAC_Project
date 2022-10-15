//
//  ViewController.swift
//  SSAC.Baemin
//
//  Created by Joonhwan Jeon on 2021/09/28.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var lbMenuTitle1: UILabel!
    @IBOutlet var lbMenuTitle2: UILabel!
    @IBOutlet var lbMenuTitle3: UILabel!
    @IBOutlet var lbMenuTitle4: UILabel!
    @IBOutlet var lbMenuTitle5: UILabel!
    @IBOutlet var lbMenuTitle6: UILabel!
    @IBOutlet var lbMenuTitle7: UILabel!
    @IBOutlet var lbMenuTitle8: UILabel!
    @IBOutlet var lbMenuTitle9: UILabel!
    @IBOutlet var lbMenuTitle10: UILabel!
    @IBOutlet var lbMenuTitle11: UILabel!
    @IBOutlet var lbMenuTitle12: UILabel!
    @IBOutlet var lbMenuTitle13: UILabel!
    @IBOutlet var lbMenuTitle14: UILabel!
    @IBOutlet var lbMenuTitle15: UILabel!
    @IBOutlet var lbMenuTitle16: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lbMenuTitle(lbMenuTitle1, "B마트")
        lbMenuTitle(lbMenuTitle2, "배민라이더스")
        lbMenuTitle(lbMenuTitle3, "1인분")
        lbMenuTitle(lbMenuTitle4, "배민오더")
        lbMenuTitle(lbMenuTitle5, "한식")
        lbMenuTitle(lbMenuTitle6, "분식")
        lbMenuTitle(lbMenuTitle7, "카페,디저트")
        lbMenuTitle(lbMenuTitle8, "동까스,회,일식")
        lbMenuTitle(lbMenuTitle9, "치킨")
        lbMenuTitle(lbMenuTitle10, "피자")
        lbMenuTitle(lbMenuTitle11, "아시안,양식")
        lbMenuTitle(lbMenuTitle12, "중국집")
        lbMenuTitle(lbMenuTitle13, "족발,보쌈")
        lbMenuTitle(lbMenuTitle14, "야식")
        lbMenuTitle(lbMenuTitle15, "찜,탕")
        lbMenuTitle(lbMenuTitle16, "도시락")
    }
    
    func lbMenuTitle(_ lb : UILabel, _ t: String) {
        lb.text = t
    }

}

