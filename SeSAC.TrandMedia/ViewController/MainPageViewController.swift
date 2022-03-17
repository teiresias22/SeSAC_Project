import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import SwiftUI

class MainPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var btnMenuBarButton: UIBarButtonItem!
    @IBOutlet weak var btnSearchBarButton: UIBarButtonItem!
    @IBOutlet weak var lbWelcomeMessage: UILabel!
    @IBOutlet weak var btnMovieButton: UIButton!
    @IBOutlet weak var btnTvSeriesButton: UIButton!
    @IBOutlet weak var btnBookButton: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var mediaTableView: UITableView!
    
    var mediaData: [MediaModel] = []
    var mediaGenre: [GenreModel] = []
    var pageCount = 1
    var totalPageCount = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mediaTableView.delegate = self
        mediaTableView.dataSource = self
        mediaTableView.prefetchDataSource = self
        
        //네비게이션 버튼 설정
        setBarButton(btnMenuBarButton, "list.bullet", .black)
        setBarButton(btnSearchBarButton, "magnifyingglass", .black)
        
        //상단영역 3버튼 설정
        setButton(btnMovieButton, "film", .customGreen ?? .green)
        setButton(btnTvSeriesButton, "tv", .customYellow ?? .yellow)
        setButton(btnBookButton, "book.closed", .customBlue ?? .cyan)
        
        //상단영역 설정
        topViewSetting()
        
        //TMDB Data
        fetcMediaData()
        featGenreData()
    }
    
    //네비게이션 버튼 설정
    func setBarButton( _ target: UIBarButtonItem, _ name: String, _ color: UIColor ){
        target.image = UIImage(systemName: name)
        target.tintColor = color
    }
    
    //상단영역 3버튼 설정
    func setButton( _ target: UIButton, _ name: String, _ color: UIColor ){
        target.setImage(UIImage(systemName: name), for: .normal)
        target.setTitle("", for: .normal)
        target.tintColor = color
        target.contentVerticalAlignment = .fill
        target.contentHorizontalAlignment = .fill
    }
    
    //상단영역 설정
    func topViewSetting(){
        let layer = topView.layer
        
        title = "TREND MEDIA"
        
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 10
        
        lbWelcomeMessage.text = "Welcome Trand!"
        lbWelcomeMessage.backgroundColor = .customRed ?? .red
        lbWelcomeMessage.textColor = .white
        lbWelcomeMessage.font = UIFont().mainBold
    }
    
    //웹뷰 링크 버튼 클릭    
    @objc func webViewLinkButtonClicked(selected: UIButton) {
        let sb = UIStoryboard(name: "WebView", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        vc.mediaData = mediaData[selected.tag]
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalTransitionStyle = .coverVertical
        
        present(nav, animated: true, completion: nil)
    }
    
    //비슷한 컨텐츠 찾기 버튼 클릭
    @objc func similarViewLinkButtonClicked(selected: UIButton) {
        let sb = UIStoryboard(name: "SimilarMedia", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "SimilarMediaViewController") as? SimilarMediaViewController else { return }
        vc.mediaData = mediaData[selected.tag]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //BarButton Right Clicked
    @IBAction func searchBarButtonClicked(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Search", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //BarButton Left Clicked
    @IBAction func MapBarButtonClicked(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Map", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func movieButtonClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Boxoffice", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BoxofficeViewController") as! BoxofficeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tvSeriesButtonClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func bookButtonClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Book", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BookViewController") as! BookViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
}

//테이블뷰 설정
extension MainPageViewController : UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainPageTableViewCell.identifier, for: indexPath) as? MainPageTableViewCell else {
            return UITableViewCell()
        }
        let row = mediaData[indexPath.row]
        
        cell.webViewLinkButton.tag = indexPath.row
        cell.webViewLinkButton.addTarget(self, action: #selector(webViewLinkButtonClicked(selected:)), for: .touchUpInside)
        cell.similarViewLinkButton.tag = indexPath.row
        cell.similarViewLinkButton.addTarget(self, action: #selector(similarViewLinkButtonClicked(selected:)), for: .touchUpInside)
        cell.lbMediaRating.text = row.voteAverage
        cell.lbMediaRating.font = UIFont().mainLight
        cell.lbMediaTag.text = row.mediaType
        
        //메인 이미지가 없는 경우 시스템 아이콘 사용
        if let url = URL(string: Endpoint.TMDBImage + row.backdropPath){
            cell.imgMediaImage.kf.setImage(with: url)
        } else {
            cell.imgMediaImage.image = UIImage(systemName: "star")
        }
        //Movie와 Tv의 경우 이름이 다르게 적용됨
        if row.mediaType == "movie" {
            cell.lbMediaTitleEng.text = row.originalTitle
            cell.lbMediaTitleKr.text = row.title
            cell.lbMediaOpeningDate.text = row.releaseDate
                        
            print(row.genre_ids)
        } else {
            cell.lbMediaTitleEng.text = row.name
            cell.lbMediaTitleKr.text = row.originalName
            cell.lbMediaOpeningDate.text = row.first_air_date
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "CastList", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "CastListViewController") as? CastListViewController else { return }
        
        let row = mediaData[indexPath.row]
        vc.mediaData = row
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if mediaData.count - 2 == indexPath.row && mediaData.count <= totalPageCount {
                pageCount += 1
                fetcMediaData()
            }
        }
    }
    
    func fetcMediaData() {
        TMDBAPIManager.shared.fetchTranslateData(page: pageCount, mediaType: "all", timeWindow: "week") { json in
            
            for mediaItem in json["results"].arrayValue {
                let original_title = mediaItem["original_title"].stringValue
                let title = mediaItem["title"].stringValue
                let original_name = mediaItem["original_name"].stringValue
                let name = mediaItem["name"].stringValue
                let backdrop_path = mediaItem["backdrop_path"].stringValue
                let vote_average = mediaItem["vote_average"].stringValue
                let release_date = mediaItem["release_date"].stringValue
                let first_air_date = mediaItem["first_air_date"].stringValue
                let media_type = mediaItem["media_type"].stringValue
                let overview = mediaItem["overview"].stringValue
                let id = mediaItem["id"].intValue
                let genre_ids = mediaItem["genre_ids"].arrayValue
                
                let data = MediaModel(originalTitle: original_title, title: title, originalName: original_name, name: name, backdropPath: backdrop_path, voteAverage: vote_average, releaseDate: release_date, first_air_date: first_air_date, mediaType: media_type, id: id, genre_ids: genre_ids, overview: overview)
                
                self.totalPageCount = json["total_pages"].intValue
                self.mediaData.append(data)
            }
            self.mediaTableView.reloadData()
        }
    }
    
    func featGenreData() {
        TMDBGenreAPIManager.shared.fetchTranslateData(mediaType: "movie") { json in
            for mediaGenre in json["genres"].arrayValue {
                let id = mediaGenre["id"].intValue
                let name = mediaGenre["name"].stringValue
                
                let data = GenreModel(id: id, name: name)
                self.mediaGenre.append(data)
            }
        }
    }
}
