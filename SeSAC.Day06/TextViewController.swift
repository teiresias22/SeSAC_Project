import UIKit
import TextFieldEffects

class TextViewController: UIViewController {
    @IBOutlet var enterTextField: HoshiTextField!
    @IBOutlet var enterTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Text View Setting
        enterTextView.layer.borderColor = UIColor.black.cgColor
        enterTextView.layer.borderWidth = 1
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func enterText(_ sender: HoshiTextField) {
        
    }
    
    @IBAction func addTextView(_ sender: UIButton) {
        
    }
    
    @IBAction func tabKeybordHide(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}
