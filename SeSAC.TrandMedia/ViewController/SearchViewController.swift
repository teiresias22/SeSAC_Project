import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    @IBOutlet weak var showSearchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    var movieData: [MovieModel] = []
    var startPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.prefetchDataSource = self
        
        showSearchBar.delegate = self
        showSearchBar.showsCancelButton = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(closeButtonClicked))
        
        //fetchMovieData()
        
    }
    //e. 뷰디드로드

    //셀의 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
    
    //셀의 내용
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        //let row = tvInformation.tvShow[indexPath.row]
        //cell.imgMediaPoster.image = UIImage(named: row.title)
        
        let row2 = movieData[indexPath.row]
        
        if let url = URL(string: row2.imageData){
            cell.imgMediaPoster.kf.setImage(with: url)
        } else {
            cell.imgMediaPoster.image = UIImage(systemName: "star")
        }
        
        cell.lbSearchMediaTitle.text = row2.titleData
        cell.lbSearchMediaSubTitle.text = row2.subTitleData
        
        cell.lbSearchMediaSynopsis.text = row2.subTitleData
        
       return cell
    }
    
    //셀의 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    //셀 클릭시 이동대상
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CastListViewController") as! CastListViewController
        
        let row = movieData[indexPath.row]
        vc.movieData = row
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // e. 테이블 셋팅
    
    //상단에 닫기 네비게이션 버튼 생성
    @objc
    func closeButtonClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    //e. 네비게이션 버튼 설정

    func fetchMovieData(query: String) {
        
        if let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let url = "https://openapi.naver.com/v1/search/movie.json?query=\(query)&display=10&start=\(startPage)"
            
            let header: HTTPHeaders = [
                "X-Naver-Client-Id": "CHfbyWsVTB6vKZOdPhrR",
                "X-Naver-Client-Secret": "xayOzRnNQk"
            ]
            
            AF.request(url, method: .get, headers: header).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
                    for item in json["items"].arrayValue {
                        let value = item["title"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                        let image = item["image"].stringValue
                        let link = item["link"].stringValue
                        let userRating = item["userRating"].stringValue
                        let subtitle = item["subtitle"].stringValue
                        let actor = item["actor"].stringValue
                        
                        let data = MovieModel(titleData: value, imageData: image, linkData: link, userRatingData: userRating, subTitleData: subtitle, actorDate: actor)
                        
                        
                        
                        self.movieData.append(data)
                    }
                    self.searchTableView.reloadData()
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if movieData.count - 1 == indexPath.row {
                startPage += 10
                fetchMovieData(query: showSearchBar.text ?? "")
            }
        }
    }
    
    //취소
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("취소: \(indexPaths)")
    }
}

extension SearchViewController : UISearchBarDelegate {
    
    //검색 버튼(키보드 리턴키)을 눌렀을 때 실행
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        if let text = showSearchBar.text {
            movieData.removeAll()
            startPage = 1
            fetchMovieData(query: text)
        }
    }
    
    //취소 버튼 눌렀을 때 실행
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        movieData.removeAll()
        searchTableView.reloadData()
        showSearchBar.setShowsCancelButton(false, animated: true)
    }
    
    //서치바에 커서 깜박이기 시작할 때
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print(#function)
        showSearchBar.setShowsCancelButton(true, animated: true)
    }
}

//extension SearchViewController : UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {}
