import UIKit

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "HOME"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addContentButtonCliced))
        
        // Do any additional setup after loading the view.
    }
    
    @objc
    func addContentButtonCliced() {
        let sb = UIStoryboard(name: "Content", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        let nav = UINavigationController(rootViewController: vc)
        nav.modalTransitionStyle = .crossDissolve
        self.present(nav, animated: true, completion: nil)
    }

}
