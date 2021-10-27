import UIKit
import SwiftyJSON

class VisionViewController: UIViewController {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func requestButtonClicked(_ sender: UIButton) {
        
        visionAPIManager.shared.fetchFaceData(image: postImageView.image!) { Code, json in
            print(json)
            
            let age = json["result"]["faces"][0]["facial_attributes"]["age"].doubleValue
            self.resultLabel.text = "\(round(age))살 입니다."
        }
    }
    
    
}
