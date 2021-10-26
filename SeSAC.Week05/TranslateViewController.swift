import UIKit
import Alamofire
import SwiftyJSON

class TranslateViewController: UIViewController {
    @IBOutlet weak var sourceTextView: UITextView!
    @IBOutlet weak var targetTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func translateButtonClicked(_ sender: UIButton) {
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id":" CHfbyWsVTB6vKZOdPhrR",
            "X-Naver-Client-Secret":"xayOzRnNQk"
        ]
        
        let parameters = [
            "source": "ko",
            "target": "en",
            "text": sourceTextView.text!
        ]
        
        
        AF.request(url, method: .post, parameters: parameters, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let translated = json["message"]["result"]["translatedText"].string
                self.targetTextView.text = "\(translated!)"
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}
