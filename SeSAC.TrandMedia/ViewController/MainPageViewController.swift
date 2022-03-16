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
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        vc.mediaData = mediaData[selected.tag]
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalTransitionStyle = .coverVertical
        
        present(nav, animated: true, completion: nil)
    }
    
    //비슷한 컨텐츠 찾기 버튼 클릭
    @objc func similarViewLinkButtonClicked(selected: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//색상 설정
extension UIColor {
    class var customGreen:UIColor? {return UIColor(named: "CustomGreen")}
    class var customYellow:UIColor? {return UIColor(named: "CustomYellow")}
    class var customBlue:UIColor? {return UIColor(named: "CustomBlue")}
    class var customRed:UIColor? {return UIColor(named: "CustomRed")}
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
        let sb = UIStoryboard(name: "Main", bundle: nil)
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

/*
    Have To!
    네이버 / 영화진흥위원회 / TMDB를 다 섞어서 쓰면 데이터간 연동은 어케하지??
    장르 불러오기 어렵네 장르를 불러와서 배열을 만들고, 그 배열의 인덱스 값별로 장르데이터 값과 비교해서 name값을 불러온다?
    
    Castlist 에서 인물정보 넘어가기
    메인 상단 3버튼중 TV버튼 누르면 넘어갈 데이터 만들기
    
    9. 위치 권한 비허용시 허용 요청 알림 만들기
    10. 다크모드 적용시 문제점 해결
        1. 메인 바 버튼 검정 색상 -> 흰색상 변경
        2. 상단 3버튼 아이콘 흰색 배경 제거
        3. 메인 셀 베경 검정색에서 변경
        4. CastList에서 1번 섹션 토글 버튼 색상 변경
*/
