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
    
    @IBAction func addTextView(_ sender: UIButton) {
        textViewreload()
        enterTextField.text = ""
    }
    
    func textViewreload() {
        enterTextView.text = enterTextView.text + enterTextField.text! + "\n"
    }
    
    @IBAction func resetTextView(_ sender: UIButton) {
        enterTextView.text = ""
    }
    
    @IBAction func tabKeybordHide(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}
