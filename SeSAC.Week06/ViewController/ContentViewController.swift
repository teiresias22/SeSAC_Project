import UIKit
import RealmSwift

class ContentViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateSetButton: UIButton!
    @IBOutlet weak var mainTextView: UITextView!
    
    let localRealm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "IMG_0641 Small")
        
        
        title = "Content"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .plain, target: self, action: #selector(saveButtonClicked))
        
        print("Realm is located at:", localRealm.configuration.fileURL!)
        // Do any additional setup after loading the view.
    }
    
    @objc
    func closeButtonClicked() {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @objc
    func saveButtonClicked() {
        
        let task = UserDiary(diaryTitle: titleTextField.text!, content: mainTextView.text!, writeDate: Date(), regDate: Date() )
        try! localRealm.write {
            localRealm.add(task)
        }
    }
}
