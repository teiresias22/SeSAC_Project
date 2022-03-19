import UIKit
import Kingfisher

class CastListViewController: UIViewController {
    @IBOutlet weak var mainMediaImage: UIImageView!
    @IBOutlet weak var mainMediaLabel: UILabel!
    @IBOutlet weak var castListTableView: UITableView!
    
    var mediaData: MediaModel?
    var movieData: MovieModel?
    var boxofficeData: BoxofficeModel?
    
    var castList: [castModel] = []
    var startpage = 1
    
    var toggleButtonClick:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        castListTableView.delegate = self
        castListTableView.dataSource = self
                
        //네비게이션 버튼 생성
        navigationItem.title = "상세정보"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(closeButtonClicked))
        
        if boxofficeData == nil {
            haderViewSetting()
            loadMediaCreditsData()
        } else {
            print("다른곳에서 왔습니다.")
        }
    }
    
    //상단 이미지 영역 설정 TMDB만 가능
    func haderViewSetting() {
        let url = URL(string: Endpoint.TMDBImage + mediaData!.backdropPath)
        mainMediaImage.kf.setImage(with: url)
        mainMediaImage.contentMode = .scaleAspectFill
        
        if mediaData!.mediaType == "movie" {
            mainMediaLabel.text = mediaData!.originalTitle
        } else {
            mainMediaLabel.text = mediaData!.originalName
        }
        
        mainMediaLabel.textAlignment = .center
        mainMediaLabel.textColor = .white
        mainMediaLabel.font = UIFont().mainBold
    }
    
    @IBAction func toggleButtonClicked(_ sender: UIButton) {
        toggleButtonClick = !toggleButtonClick
        castListTableView.reloadData()
    }
    
    //TMDB CastList
    func loadMediaCreditsData() {
        TMDBTypeAPIManager.shared.fetchTranslateData(mediaType: mediaData!.mediaType, mediaID: mediaData!.id, APIType: "credits", startPage: startpage) { json in
            for cast in json["cast"].arrayValue {
                let name = cast["name"].stringValue
                let character = cast["character"].stringValue
                let profile_path = cast["profile_path"].stringValue
                
                let data = castModel(name: name, character: character, profile_path: profile_path)
                self.castList.append(data)
            }
            self.castListTableView.reloadData()
        }
    }
    
    @objc
    func closeButtonClicked(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension CastListViewController: UITableViewDelegate, UITableViewDataSource {
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
            return castList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier, for: indexPath) as? OverviewTableViewCell else {
                return UITableViewCell()
            }
            let image = toggleButtonClick ? UIImage(systemName: "arrow.up.to.line.alt"): UIImage(systemName: "arrow.down.to.line.alt")
            let lines = toggleButtonClick ? 0 : 2
            
            cell.mediaOverviewLabel.numberOfLines = lines
            cell.mediaOverviewLabel.text = mediaData?.overview
            cell.mediaOverviewSeeMoreButton.setTitle("", for: .normal)
            cell.mediaOverviewSeeMoreButton.setImage(image, for: .normal)
            cell.mediaOverviewSeeMoreButton.tintColor = .black
                        
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastListTableViewCell.identifier, for: indexPath) as? CastListTableViewCell else {
                return UITableViewCell()
            }
            let row = castList[indexPath.row]
            let url = URL(string: Endpoint.TMDBImage + row.profile_path)
            
            cell.imgActorImage.kf.setImage(with: url, placeholder: UIImage(systemName: "person"))
            cell.imgActorImage.contentMode = .scaleAspectFill
            cell.imgActorImage.layer.cornerRadius = 8
            cell.lbActorName.text = row.name
            cell.lbCastName.text = row.character
            
            return cell
        }
    }
    
    //글자수에 맞춰서 셀의 높이가 자동 설정이 되어야함
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            let cellSize:CGFloat = toggleButtonClick ? 250 : 100
            return cellSize
        } else {
            return UIScreen.main.bounds.height / 10
        }
    }
}
