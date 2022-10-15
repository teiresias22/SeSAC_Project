
import UIKit

class BoardViewController: UIViewController {

    @IBOutlet var btnTextCollorChange: UIButton!
    @IBOutlet var btnTextChange: UIButton!
    
    @IBOutlet var tfTextField: UITextField!
    @IBOutlet var lbTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfTextField.placeholder = "텍스트를 입력해 주세요"
        
        lbTextLabel.text = "텍스트를 입력해 주세요"
        lbTextLabel.textColor = .white
        
        sendButtonClick(btnTextChange)
        colorChangeButtonClick(btnTextCollorChange)
    }
    
    func sendButtonClick (_ btn: UIButton) {
        btn.setTitle("보내기", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 14
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 1
    }
    
    func colorChangeButtonClick (_ btn: UIButton) {
        btn.setTitle("Aa", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.layer.cornerRadius = 14
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 1
    }
    
    @IBAction func btnLabelTextPrint(_ sender: UIButton) {
        lbTextLabel.text = tfTextField.text
    }
    
    @IBAction func btnLabelTextColorChange(_ sender: UIButton) {
        
    }
    
    @IBAction func tfTextFieldSearchBar(_ sender: UITextField) {
        view.endEditing(true)
    }
    
    @IBAction func grTabKeybordHide(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        
    }
    

}
