import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import SwiftUI

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    @IBOutlet weak var showSearchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    var movieData: [MovieModel] = []
    var startPage = 1
    var totalPageCount = 100
    
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
        let row = movieData[indexPath.row]
        
        if let url = URL(string: row.imageData){
            cell.imgMediaPoster.kf.setImage(with: url)
        } else {
            cell.imgMediaPoster.image = UIImage(systemName: "star")
        }
        cell.lbSearchMediaTitle.text = row.titleData
        cell.lbSearchMediaSubTitle.text = row.subTitleData
        cell.lbSearchMediaSynopsis.text = row.subTitleData
        
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
    
    //상단에 닫기 네비게이션 버튼 생성
    @objc
    func closeButtonClicked(){
        self.navigationController?.popViewController(animated: true)
    }

    func fetcMediaData() {
        let text = showSearchBar.text ?? "StarWars"
        NaverAPIManager.shared.fetchMovieData(query: text, startPage: startPage) { json in
            
            for item in json["items"].arrayValue {
                let value = item["title"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                let image = item["image"].stringValue
                let link = item["link"].stringValue
                let userRating = item["userRating"].stringValue
                let subtitle = item["subtitle"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                let actor = item["actor"].stringValue
                
                let data = MovieModel(titleData: value, imageData: image, linkData: link, userRatingData: userRating, subTitleData: subtitle, actorDate: actor)
                
                self.totalPageCount = json["total"].intValue
                self.movieData.append(data)
            }
            self.searchTableView.reloadData()
        }
        
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

extension SearchViewController : UISearchBarDelegate {
    
    //검색 버튼(키보드 리턴키)을 눌렀을 때 실행
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        movieData.removeAll()
        startPage = 1
        fetcMediaData()
    }
    
    //취소 버튼 눌렀을 때 실행
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("취소" + #function)
        movieData.removeAll()
        searchTableView.reloadData()
        showSearchBar.setShowsCancelButton(false, animated: true)
    }
    
    //서치바에 커서 깜박이기 시작할 때
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("서치" + #function)
        showSearchBar.setShowsCancelButton(true, animated: true)
    }
}
