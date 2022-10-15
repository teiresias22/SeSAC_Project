import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let array = [
        Array(repeating: "a", count: 10),
        Array(repeating: "b", count: 20),
        Array(repeating: "c", count: 15),
        Array(repeating: "d", count: 5),
        Array(repeating: "e", count: 8),
        Array(repeating: "f", count: 12),
        Array(repeating: "g", count: 16)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        
        cell.data = array[indexPath.row]
        cell.collectionView.tag = indexPath.row
        
        //셀 재사용에서 꼬이는 부분을 해결하기 위한 필수 요소
        cell.collectionView.reloadData()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 1 ? 300 : 170
    }
    
}
