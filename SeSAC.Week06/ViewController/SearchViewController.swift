import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        let nibName = UINib(nibName: SearchTableViewCell.identifier, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: SearchTableViewCell.identifier)
        
        // Do any additional setup after loading the view.
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        cell.titleLabel.text = "제목이 들어갑니다."
        cell.dateLabel.text = "2021.11.01"
        cell.mainTextLabel.text = "본문이 들어갑니다.본문이 들어갑니다.본문이 들어갑니다.본문이 들어갑니다.본문이 들어갑니다.본문이 들어갑니다.본문이 들어갑니다.본문이 들어갑니다.본문이 들어갑니다.본문이 들어갑니다.본문이 들어갑니다.본문이 들어갑니다.본문이 들어갑니다.본문이 들어갑니다.본문이 들어갑니다.본문이 들어갑니다.본문이 들어갑니다.본문이 들어갑니다.본문이 들어갑니다.본문이 들어갑니다."
        cell.daiaryImageView.backgroundColor = .systemCyan
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 6
    }
    
    
}
