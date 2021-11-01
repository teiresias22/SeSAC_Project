import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var addContentButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addContentButton.image = UIImage(systemName: "plus", compatibleWith: nil)
        // Do any additional setup after loading the view.
    }
   
    @IBAction func addContentButtonClicked(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Content", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        vc.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        self.present(vc, animated: true)
    }

}
