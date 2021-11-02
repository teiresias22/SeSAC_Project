import UIKit
import RealmSwift

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let localRealm = try! Realm()
    var tasks: Results<UserDiary>!
    
    //var tasks: Results<UserDiary>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        let nibName = UINib(nibName: SearchTableViewCell.identifier, bundle: nil)
        
        tableView.register(nibName, forCellReuseIdentifier: SearchTableViewCell.identifier)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tasks = localRealm.objects(UserDiary.self)
        tableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        let row = tasks[indexPath.row]
        
        cell.titleLabel.text = row.diaryTitle
        cell.dateLabel.text = "\(row.writeDate)"
        cell.mainTextLabel.text = row.content
        
        cell.daiaryImageView.backgroundColor = .systemCyan
        cell.daiaryImageView.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 8
    }
    
    
}
