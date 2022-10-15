import UIKit
import SwiftyJSON

class OCRViewController: UIViewController {
    @IBOutlet weak var textImage: UIImageView!
    @IBOutlet weak var OCRTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OCRTextView.textContainer.maximumNumberOfLines = 0

        // Do any additional setup after loading the view.
    }

    @IBAction func OCRButtonClicked(_ sender: UIButton) {
        
        OCRAPIManager.shared.fetchOCRData(image: textImage.image!) { Code, json in
            print(json)
            
            let textArray = json["result"].arrayValue
            let count: Int = textArray.count
            var imageText: [String] = []
            
            for num in 0...count {
                var textData = json["result"][num]["recognition_words"][0].stringValue
                imageText.append(textData)
            }
            
            self.OCRTextView.text = ""
            
            for i in 0...count {
                self.OCRTextView.text = self.OCRTextView.text + imageText[i] + "\n"
            }
            print(imageText)
            
            
        }
    }
}
