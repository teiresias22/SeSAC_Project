import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import SwiftUI

class SearchViewController: UIViewController {
    @IBOutlet weak var showSearchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    var movieData: [MovieModel] = []
    
    var text = "star"
    var startPage = 1
    var totalPageCount = 100
    var mediaType = "multi"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.prefetchDataSource = self
        
        showSearchBar.delegate = self
        showSearchBar.showsCancelButton = false
        showSearchBar.placeholder = "검색어를 입력하세요"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(closeButtonClicked))
        fetcMediaData()
    }
    
    //상단에 닫기 네비게이션 버튼 생성
    @objc
    func closeButtonClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func checkKeyWardText() -> String {
        let searchText: String? = showSearchBar.text
        
        guard let searchName = searchText else { return "star" }
        return searchName
    }

    func fetcMediaData() {
        text = checkKeyWardText()
        
        TMDBSearchAPIManager.shared.fetchTranslateData(mediaType: mediaType, text: text, startPage: startPage) { json in
            for item in json["results"].arrayValue {
                let poster_path = item["poster_path"].stringValue
                let genre_ids = item["genre_ids"].stringValue
                let id = item["id"].intValue
                let original_title = item["original_title"].stringValue
                let original_name = item["original_name"].stringValue
                let overview = item["overview"].stringValue
                let release_date = item["release_date"].stringValue
                let first_air_date = item["first_air_date"].stringValue
                let backdrop_path = item["backdrop_path"].stringValue
                
                let data = MovieModel(poster_path: poster_path, genre_ids: genre_ids, id: id, original_title: original_title, original_name: original_name, overview: overview, release_date: release_date, first_air_date: first_air_date, backdrop_path: backdrop_path)
                
                self.totalPageCount = json["total_results"].intValue
                self.movieData.append(data)
            }
            self.searchTableView.reloadData()
        }
    }
}

//MARK: TableViewDelegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    //셀의 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
    
    //셀의 내용
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        let row = movieData[indexPath.row]
        
        if row.poster_path != ""{
            let url = URL(string: Endpoint.TMDBImage + row.poster_path)
            cell.imgMediaPoster.kf.setImage(with: url)
        } else {
            cell.imgMediaPoster.image = UIImage(systemName: "star")
        }
        
        if row.original_title != "" {
            cell.lbSearchMediaTitle.text = row.original_title
            cell.lbSearchMediaSubTitle.text = row.release_date
        } else {
            cell.lbSearchMediaTitle.text = row.original_name
            cell.lbSearchMediaSubTitle.text = row.first_air_date
        }
        cell.lbSearchMediaSynopsis.text = row.overview
        
       return cell
    }
    
    //셀의 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    //셀 클릭시 이동대상
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "CastList", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CastListViewController") as! CastListViewController
        
        let row = movieData[indexPath.row]
        vc.movieData = row
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if movieData.count - 1 == indexPath.row && movieData.count < totalPageCount {
                startPage += 10
                fetcMediaData()
            }
        }
    }
    
    //취소
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("취소: \(indexPaths)")
    }
    
}


//MARK: SearchBarDelegate
extension SearchViewController : UISearchBarDelegate {
    
    //검색 버튼(키보드 리턴키)을 눌렀을 때 실행
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        movieData.removeAll()
        startPage = 1
        fetcMediaData()
    }
    
    //취소 버튼 눌렀을 때 실행
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        movieData.removeAll()
        searchTableView.reloadData()
        showSearchBar.setShowsCancelButton(false, animated: true)
    }
    
    //서치바에 커서 깜박이기 시작할 때
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        showSearchBar.setShowsCancelButton(true, animated: true)
    }
}
