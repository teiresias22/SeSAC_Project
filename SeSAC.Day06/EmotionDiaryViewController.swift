import UIKit

class EmotionDiaryViewController: UIViewController {

    @IBOutlet var TextLabelCount1: UILabel!
    @IBOutlet var TextLabelCount2: UILabel!
    @IBOutlet var TextLabelCount3: UILabel!
    @IBOutlet var TextLabelCount4: UILabel!
    @IBOutlet var TextLabelCount5: UILabel!
    @IBOutlet var TextLabelCount6: UILabel!
    @IBOutlet var TextLabelCount7: UILabel!
    @IBOutlet var TextLabelCount8: UILabel!
    @IBOutlet var TextLabelCount9: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let countNum1 = UserDefaults.standard.integer(forKey: "countNum1")
        TextLabelCount1.text = "행복해 \(countNum1)개"
        
        let countNum2 = UserDefaults.standard.integer(forKey: "countNum2")
        TextLabelCount2.text = "좋아해 \(countNum2)개"
        
        let countNum3 = UserDefaults.standard.integer(forKey: "countNum3")
        TextLabelCount3.text = "사랑해 \(countNum3)개"
        
        let countNum4 = UserDefaults.standard.integer(forKey: "countNum4")
        TextLabelCount4.text = "심술나 \(countNum4)개"
        
        let countNum5 = UserDefaults.standard.integer(forKey: "countNum5")
        TextLabelCount5.text = "속상해 \(countNum5)개"
        
        let countNum6 = UserDefaults.standard.integer(forKey: "countNum6")
        TextLabelCount6.text = "우울해 \(countNum6)개"
        
        let countNum7 = UserDefaults.standard.integer(forKey: "countNum7")
        TextLabelCount7.text = "심심해 \(countNum7)개"
    
        let countNum8 = UserDefaults.standard.integer(forKey: "countNum8")
        TextLabelCount8.text = "당황해 \(countNum8)개"
        
        let countNum9 = UserDefaults.standard.integer(forKey: "countNum9")
        TextLabelCount9.text = "눈물나 \(countNum9)개"

        // Do any additional setup after loading the view.
    }
    @IBAction func btnEmotionButton1(_ sender: UIButton) {
        let countNum = UserDefaults.standard.integer(forKey: "countNum1")
        UserDefaults.standard.set(countNum+1, forKey: "countNum1")
        let updateCountNum = UserDefaults.standard.integer(forKey: "countNum1")
        TextLabelCount1.text = "행복해 \(updateCountNum)개"
    }
    
    @IBAction func btnEmotionButton2(_ sender: UIButton) {
        let countNum = UserDefaults.standard.integer(forKey: "countNum2")
        UserDefaults.standard.set(countNum+1, forKey: "countNum2")
        let updateCountNum = UserDefaults.standard.integer(forKey: "countNum2")
        TextLabelCount2.text = "좋아해 \(updateCountNum)개"
    }
    
    @IBAction func btnEmotionButton3(_ sender: UIButton) {
        let countNum = UserDefaults.standard.integer(forKey: "countNum3")
        UserDefaults.standard.set(countNum+1, forKey: "countNum3")
        let updateCountNum = UserDefaults.standard.integer(forKey: "countNum3")
        TextLabelCount3.text = "사랑해 \(updateCountNum)개"
    }
    
    @IBAction func btnEmotionButton4(_ sender: UIButton) {
        let countNum = UserDefaults.standard.integer(forKey: "countNum4")
        UserDefaults.standard.set(countNum+1, forKey: "countNum4")
        let updateCountNum = UserDefaults.standard.integer(forKey: "countNum4")
        TextLabelCount4.text = "심술나 \(updateCountNum)개"
    }
    
    @IBAction func btnEmotionButton5(_ sender: UIButton) {
        let countNum = UserDefaults.standard.integer(forKey: "countNum5")
        UserDefaults.standard.set(countNum+1, forKey: "countNum5")
        let updateCountNum = UserDefaults.standard.integer(forKey: "countNum5")
        TextLabelCount5.text = "속상해 \(updateCountNum)개"
    }
    
    @IBAction func btnEmotionButton6(_ sender: UIButton) {
        let countNum = UserDefaults.standard.integer(forKey: "countNum6")
        UserDefaults.standard.set(countNum+1, forKey: "countNum6")
        let updateCountNum = UserDefaults.standard.integer(forKey: "countNum6")
        TextLabelCount6.text = "우울해 \(updateCountNum)개"
    }
    
    @IBAction func btnEmotionButton7(_ sender: UIButton) {
        let countNum = UserDefaults.standard.integer(forKey: "countNum7")
        UserDefaults.standard.set(countNum+1, forKey: "countNum7")
        let updateCountNum = UserDefaults.standard.integer(forKey: "countNum7")
        TextLabelCount7.text = "심심해 \(updateCountNum)개"
    }
    
    @IBAction func btnEmotionButton8(_ sender: UIButton) {
        let countNum = UserDefaults.standard.integer(forKey: "countNum8")
        UserDefaults.standard.set(countNum+1, forKey: "countNum8")
        let updateCountNum = UserDefaults.standard.integer(forKey: "countNum8")
        TextLabelCount8.text = "당황해 \(updateCountNum)개"
    }
    
    @IBAction func btnEmotionButton9(_ sender: UIButton) {
        let countNum = UserDefaults.standard.integer(forKey: "countNum9")
        UserDefaults.standard.set(countNum+1, forKey: "countNum9")
        let updateCountNum = UserDefaults.standard.integer(forKey: "countNum9")
        TextLabelCount9.text = "눈물나 \(updateCountNum)개"
    }
        

}
