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
    var koficCastList: [KoficCastModel] = []
    
    var movieNm = ""
    var movieNmEn = ""
    var showTm = ""
    var openDt = ""
    var typeNm = ""
    
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
            headerViewSet()
            loadMediaCreditsData()
        } else {
            boxofficeHeaderViewSet()
            loadKoficMediaData()
        }
    }
    
    //상단 이미지 영역 설정 TMDB만 가능
    func headerViewSet() {
        if movieData == nil {
            let url = URL(string: Endpoint.TMDBImage + mediaData!.backdropPath)
            mainMediaImage.kf.setImage(with: url)
            
            if mediaData!.mediaType == "movie" {
                mainMediaLabel.text = mediaData!.originalTitle
            } else {
                mainMediaLabel.text = mediaData!.originalName
            }
            
        } else {
            let url = URL(string: Endpoint.TMDBImage + movieData!.backdrop_path)
            mainMediaImage.kf.setImage(with: url)
            
            mainMediaLabel.text = movieData!.original_title
        }
        
        mainMediaImage.contentMode = .scaleAspectFill
        
        mainMediaLabel.textAlignment = .center
        mainMediaLabel.textColor = .white
        mainMediaLabel.font = UIFont().mainBold
    }
    
    //상단 이미지 영역 Boxoffice
    func boxofficeHeaderViewSet() {
        mainMediaImage.backgroundColor = .systemGray
        mainMediaLabel.text = boxofficeData!.movieNmData
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
        TMDBTypeAPIManager.shared.fetchTranslateData(mediaType: mediaData?.mediaType ?? "movie", mediaID: mediaData?.id ?? movieData!.id, APIType: "credits", startPage: startpage) { json in
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
    
    func loadKoficMediaData() {
        KobisDetailAPIManager.shared.fetchTranslateData(movieID: boxofficeData!.movieCdData) { [self] json in
            for movie in json["movieInfoResult"]["movieInfo"]["actors"].arrayValue {
                let peopleNm = movie["peopleNm"].stringValue
                let peopleNmEn = movie["peopleNmEn"].stringValue
                let cast = movie["cast"].stringValue
                let castEn = movie["castEn"].stringValue
                
                let data = KoficCastModel(peopleNm: peopleNm, peopleNmEn: peopleNmEn, cast: cast, castEn: castEn)
                koficCastList.append(data)
            }
            movieNm = json["movieInfoResult"]["movieInfo"]["movieNm"].stringValue
            movieNmEn = json["movieInfoResult"]["movieInfo"]["movieNmEn"].stringValue
            showTm = json["movieInfoResult"]["movieInfo"]["showTm"].stringValue
            openDt = json["movieInfoResult"]["movieInfo"]["openDt"].stringValue
            typeNm = json["movieInfoResult"]["movieInfo"]["typeNm"].stringValue
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
            if boxofficeData == nil {
                return "Overview"
            } else {
                return "Info"
            }
        }else {
            return "CastList"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            if boxofficeData == nil {
                return castList.count
            } else {
                return koficCastList.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier, for: indexPath) as? OverviewTableViewCell else {
                return UITableViewCell()
            }
            if boxofficeData == nil {
                let image = toggleButtonClick ? UIImage(systemName: "arrow.up.to.line.alt"): UIImage(systemName: "arrow.down.to.line.alt")
                let lines = toggleButtonClick ? 0 : 2
                
                cell.mediaOverviewSeeMoreButton.setTitle("", for: .normal)
                cell.mediaOverviewSeeMoreButton.setImage(image, for: .normal)
                cell.mediaOverviewSeeMoreButton.tintColor = .black
                
                cell.mediaOverviewLabel.numberOfLines = lines
                cell.mediaOverviewLabel.text = mediaData?.overview ?? movieData!.overview
                
            } else {
                cell.mediaOverviewSeeMoreButton.setTitle("", for: .normal)
                
                cell.mediaOverviewLabel.numberOfLines = 2
                cell.mediaOverviewLabel.text = "제목 : \(movieNm), \(movieNmEn)\n종류 : \(typeNm), 상영시간 : \(showTm), 개봉일 : \(openDt)"
            }
                        
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastListTableViewCell.identifier, for: indexPath) as? CastListTableViewCell else {
                return UITableViewCell()
            }
            if boxofficeData == nil {
                let row = castList[indexPath.row]
                let url = URL(string: Endpoint.TMDBImage + row.profile_path)
                
                cell.imgActorImage.kf.setImage(with: url, placeholder: UIImage(systemName: "person"))
                cell.lbActorName.text = row.name
                cell.lbCastName.text = row.character
            } else {
                let row = koficCastList[indexPath.row]
                
                cell.imgActorImage.backgroundColor = .systemGray
                cell.lbActorName.text = "\(row.peopleNm), \(row.peopleNmEn)"
                cell.lbCastName.text = "\(row.cast), \(row.castEn)"
            }
            cell.imgActorImage.contentMode = .scaleAspectFill
            cell.imgActorImage.layer.cornerRadius = 8
            
            return cell
        }
    }
    
    //글자수에 맞춰서 셀의 높이가 자동 설정이 되어야함
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if boxofficeData == nil {
                let cellSize:CGFloat = toggleButtonClick ? 250 : 100
                return cellSize
            } else {
                return 100
            }
        } else {
            return UIScreen.main.bounds.height / 10
        }
    }
}
