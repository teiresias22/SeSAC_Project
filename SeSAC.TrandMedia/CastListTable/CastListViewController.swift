import UIKit
import Kingfisher

class CastListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mainMediaImage: UIImageView!
    @IBOutlet weak var mainMediaLabel: UILabel!
    
    @IBOutlet weak var castListTableView: UITableView!
    
    //데이터 저장 공간 생성
    var tvShow: TvShow?
    let tvInformation = tvShowInformation()
    
    //toggleButton 설정
    var toggleButtonClick:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        castListTableView.delegate = self
        castListTableView.dataSource = self
        
        haderViewSetting()
        
        //네비게이션 버튼 생성
        navigationItem.title = "상세정보"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Main", style: .plain, target: self, action: #selector(closeButtonClicked))
        
    }
    
    func haderViewSetting() {
        let url = URL(string: tvShow?.backdropImage ?? "https://www.themoviedb.org/t/p/original/oaGvjB0DvdhXhOAuADfHb261ZHa.jpg")
        
        title = tvShow?.title ?? "연결이 되지 않았습니다."
        mainMediaImage.kf.setImage(with: url)
        mainMediaImage.contentMode = .scaleAspectFill
        
        mainMediaLabel.text = tvShow?.title ?? "연결이 되지 않았습니다."
        mainMediaLabel.textAlignment = .center
        mainMediaLabel.textColor = .white
        mainMediaLabel.font = .boldSystemFont(ofSize: 24)
    }
    //e. 뷰디드로드
    
    @IBAction func toggleButtonClicked(_ sender: UIButton) {
        toggleButtonClick = !toggleButtonClick
        castListTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Overview"
        }else {
            return "CastList"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            return tvInformation.tvShow.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier, for: indexPath) as? OverviewTableViewCell else {
                return UITableViewCell()
            }
            let row = tvInformation.tvShow[indexPath.row]
            
            cell.mediaOverviewLabel.text = row.overview
            cell.mediaOverviewSeeMoreButton.setTitle("", for: .normal)
            
            let lines = toggleButtonClick ? 2 : 0
            cell.mediaOverviewLabel.numberOfLines = lines
            
            let image = toggleButtonClick ? UIImage(systemName: "arrow.down.to.line.alt"): UIImage(systemName: "arrow.up.to.line.alt")
            
            cell.mediaOverviewSeeMoreButton.setImage(image, for: .normal)
            cell.mediaOverviewSeeMoreButton.tintColor = .black
                        
            return cell
        } else {
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
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            let cellSize:CGFloat = toggleButtonClick ? 100 : 140
            return cellSize
        } else {
            return UIScreen.main.bounds.height / 10
        }
    }
    //e. 테이블 설정
    
    @objc
    func closeButtonClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    //e. 네비게이션 설정


}
