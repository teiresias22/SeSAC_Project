
import UIKit

class ViewController: UIViewController {
    @IBOutlet var tfUserSearchTextField: UITextField!
    
    @IBOutlet var btnRecomendSearchKeyWord1: UIButton!
    @IBOutlet var btnRecomendSearchKeyWord2: UIButton!
    @IBOutlet var btnRecomendSearchKeyWord3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        recomendButtonSetting(btnRecomendSearchKeyWord1, "title1")
        recomendButtonSetting(btnRecomendSearchKeyWord2, "title2")
        recomendButtonSetting(btnRecomendSearchKeyWord3, "title3")
    }
    
    func recomendButtonSetting(_ btn: UIButton, _ title : String) {
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 12
        btn.backgroundColor = .black
    }

    @IBAction func tfkeyboardReturnKeyKlicked(_ sender: UITextField) {
        view.endEditing(true)
    }
    @IBAction func btnRecomendButtonClicked(_ sender: UIButton) {
        tfUserSearchTextField.text = sender.currentTitle
    }
    
}

