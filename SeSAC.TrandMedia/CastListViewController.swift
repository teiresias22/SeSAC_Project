import UIKit

class CastListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var castListTableView: UITableView!
    
    let tvInformation = tvShowInformation()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        castListTableView.delegate = self
        castListTableView.dataSource = self
        
        //네비게이션 버튼 생성
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "My Midea", style: .plain, target: self, action: #selector(closeButtonClicked))
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvInformation.tvShow.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CastListTableViewCell.identifier, for: indexPath) as? CastListTableViewCell else {
            return UITableViewCell()
        }
        let row = tvInformation.tvShow[indexPath.row]
        
        cell.imgActorImage.image = UIImage(named: row.title)
        cell.lbActorName.text = row.title
        cell.lbCastName.text = row.genre
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    //e. 테이블 설정
    
    @objc
    func closeButtonClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    //e. 네비게이션 설정
}
