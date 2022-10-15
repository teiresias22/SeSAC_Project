import UIKit
import Network

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
    
    //네트워크 변경 감지 클래스
    let networkMonitor = NWPathMonitor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //네트워크 변경 감지 클래스를 통해 사용자의 네트워크 상태가 변경될 때마다 실행
        networkMonitor.pathUpdateHandler = { path in
            if path.status == .satisfied{
                print("Network Connected")
                
                if path.usesInterfaceType(.cellular) {
                    print("Cellular Status")
                } else if path.usesInterfaceType(.wifi) {
                    print("Wifi Status")
                } else {
                    print("Others")
                }
                
            } else {
                print("Network Disconnected")
            }
        }
        networkMonitor.start(queue: DispatchQueue.global())

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
        
        DispatchQueue.global().async {
            TranslatedAPIManager.shared.fetchTranslateData(text: text) { Code, json in
                
                switch Code {
                case 200:
                    print(json)
                    
                    DispatchQueue.main.async {
                        
                        self.translateText = json["message"]["result"]["translatedText"].stringValue
                        
                    }
                case 400:
                    print(json)
                    self.translateText = json["errorMessage"].stringValue
                default:
                    print("ERROR")
                }
            }
        }
    }
    
}
