import UIKit

class AsyncImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var collectionLabel: UILabel!
    let url = "https://images.unsplash.com/photo-1635431543098-fbbcec72cf72?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1528&q=80"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func requestButtonClicked(_ sender: UIButton) {
        DispatchQueue.global().async {
            if let url = URL(string: self.url), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
}
