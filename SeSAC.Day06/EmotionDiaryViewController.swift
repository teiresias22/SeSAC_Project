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
        
        updateCountNum(TextLabelCount1, "countNum1", "행복해")
        updateCountNum(TextLabelCount2, "countNum2", "좋아해")
        updateCountNum(TextLabelCount3, "countNum3", "사랑해")
        updateCountNum(TextLabelCount4, "countNum4", "심술나")
        updateCountNum(TextLabelCount5, "countNum5", "속상해")
        updateCountNum(TextLabelCount6, "countNum6", "우울해")
        updateCountNum(TextLabelCount7, "countNum7", "심심해")
        updateCountNum(TextLabelCount8, "countNum8", "당황해")
        updateCountNum(TextLabelCount9, "countNum9", "눈물나")
        // Do any additional setup after loading the view.
    }
    //viewDidLoad Label Func
    func updateCountNum(_ n: UILabel, _ t: String, _ v: String) {
        let t = UserDefaults.standard.integer(forKey: t)
        n.text = "\(v) \(t)개"
    }
    
    @IBAction func btnEmotionButton1(_ sender: UIButton) {
        emotionButtonClicked("countNum1", "행복해", TextLabelCount1)
    }
    
    @IBAction func btnEmotionButton2(_ sender: UIButton) {
        emotionButtonClicked("countNum2", "좋아해", TextLabelCount2)
    }
    
    @IBAction func btnEmotionButton3(_ sender: UIButton) {
        emotionButtonClicked("countNum3", "사랑해", TextLabelCount3)
    }
    
    @IBAction func btnEmotionButton4(_ sender: UIButton) {
        emotionButtonClicked("countNum4", "심술나", TextLabelCount4)
    }
    
    @IBAction func btnEmotionButton5(_ sender: UIButton) {
        emotionButtonClicked("countNum5", "속상해", TextLabelCount5)
    }
    
    @IBAction func btnEmotionButton6(_ sender: UIButton) {
        emotionButtonClicked("countNum6", "우울해", TextLabelCount6)
    }
    
    @IBAction func btnEmotionButton7(_ sender: UIButton) {
        emotionButtonClicked("countNum7", "심심해", TextLabelCount7)
    }
    
    @IBAction func btnEmotionButton8(_ sender: UIButton) {
        emotionButtonClicked("countNum8", "당황해", TextLabelCount8)
    }
    
    @IBAction func btnEmotionButton9(_ sender: UIButton) {
        emotionButtonClicked("countNum9", "눈물나", TextLabelCount9)
    }
    func emotionButtonClicked(_ target: String, _ text: String, _ number: UILabel) {
        let countNum = UserDefaults.standard.integer(forKey: target)
        UserDefaults.standard.set(countNum+1, forKey: target)
        let updateCountNum = UserDefaults.standard.integer(forKey: target)
        number.text = "\(text) \(updateCountNum)개"
    }
    

}
