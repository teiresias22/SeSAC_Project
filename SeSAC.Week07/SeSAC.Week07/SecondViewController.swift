import UIKit

protocol PassDateDelegate {
    func sendTextData(text: String)
}

class SecondViewController: UIViewController {
    
    var textSpace: String = ""
    
    @IBOutlet weak var textView: UITextView!
    
    var buttonActionHandler: (() -> ())?
    
    var delegate: PassDateDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = textSpace

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        
        buttonActionHandler?()
        
        guard let presentVC = self.presentingViewController else { return }
        
        self.dismiss(animated: true) {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ThirdViewController") as? ThirdViewController else { return }
            
            presentVC.present(vc, animated: true, completion: nil)
            
            print("화면이 닫혔습니다.")
        }
        
    }
    @IBAction func NotificationButtonClicked(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: .myNotification, object: nil, userInfo: ["myText": textView.text, "value": 123])
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func protocolButtonClicked(_ sender: UIButton) {
        
        if let text = textView.text {
            delegate?.sendTextData(text: text)
        }
        
        dismiss(animated: true, completion: nil)
        
    }
}
