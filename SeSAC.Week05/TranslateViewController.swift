import UIKit
import Alamofire
import SwiftyJSON

class TranslateViewController: UIViewController {
    @IBOutlet weak var sourceTextView: UITextView!
    @IBOutlet weak var targetTextView: UITextView!
    
    var translateText: String = "" {
        didSet {
            targetTextView.text = translateText
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func translateButtonClicked(_ sender: UIButton) {
        
        //1옵셔널 강제 해제
        //TranslatedAPIManager.shared.fetchTranslateData(text: sourceTextView.text!)
        
        //2 옵셔널 해제 if let
        //if let value = sourceTextView.text {
        //    TranslatedAPIManager.shared.fetchTranslateData(text: sourceTextView.text)
        //}
        
        //3 옵셔널 해제 guard let
        guard let text = sourceTextView.text else { return }
        TranslatedAPIManager.shared.fetchTranslateData(text: text) { Code, json in
            
            switch Code {
            case 200:
                print(json)
                self.translateText = json["message"]["result"]["translatedText"].stringValue
            case 400:
                print(json)
                self.translateText = json["errorMessage"].stringValue
            default:
                print("ERROR")
            }
        }
    }
    
}
