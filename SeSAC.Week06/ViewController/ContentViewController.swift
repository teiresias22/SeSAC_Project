import UIKit

class ContentViewController: UIViewController {
    @IBOutlet weak var closeButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateSetButton: UIButton!
    @IBOutlet weak var mainTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeButton.image = UIImage(systemName: "xmark", compatibleWith: nil)
        addButton.image = UIImage(systemName: "pencil", compatibleWith: nil)
        imageView.image = UIImage(named: "IMG_0641 Small")
        navigationItem.title = "Content"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeButtonClicked(_ sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        
    }
    
    
    

}
