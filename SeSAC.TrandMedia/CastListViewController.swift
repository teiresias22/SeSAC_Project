import UIKit

class CastListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mainMediaImage: UIImageView!
    @IBOutlet weak var mainMediaLabel: UILabel!
    
    @IBOutlet weak var castListTableView: UITableView!
    
    //데이터 저장 공간 생성
    var tvShow: TvShow?
    
    let tvInformation = tvShowInformation()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        castListTableView.delegate = self
        castListTableView.dataSource = self
        
        //let url = URL(string: tvShow?.backdropImage ?? "")
        //var image: UIImage?
        //let data = try? Data(contentsOf: url!)
        
        title = tvShow?.title ?? "연결이 되지 않았습니다."
        //mainMediaImage.image = UIImage(data: data!)
        mainMediaImage.image = UIImage(named: tvShow?.title ?? "")
        mainMediaImage.contentMode = .scaleAspectFill
        
        mainMediaLabel.text = tvShow?.title ?? "연결이 되지 않았습니다."
        mainMediaLabel.textAlignment = .center
        mainMediaLabel.textColor = .white
        mainMediaLabel.font = .boldSystemFont(ofSize: 24)
        
        //네비게이션 버튼 생성
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "My Midea", style: .plain, target: self, action: #selector(closeButtonClicked))
        
    }
    //e. 뷰디드로드
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvInformation.tvShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CastListTableViewCell.identifier, for: indexPath) as? CastListTableViewCell else {
            return UITableViewCell()
        }
        let row = tvInformation.tvShow[indexPath.row]
        
        cell.imgActorImage.image = UIImage(named: row.title)
        cell.imgActorImage.contentMode = .scaleAspectFill
        cell.imgActorImage.layer.cornerRadius = 8
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
