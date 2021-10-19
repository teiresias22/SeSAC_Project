import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var showSearchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    let tvInformation = tvShowInformation()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(closeButtonClicked))
        
    }
    //e. 뷰디드로드

    //셀의 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvInformation.tvShow.count
    }
    
    //셀의 내용
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        let row = tvInformation.tvShow[indexPath.row]
        
        cell.imgMediaPoster.image = UIImage(named: row.title)
        cell.lbSearchMediaTitle.text = row.title
        cell.lbSearchMediaSubTitle.text = "\(row.releaseDate) | \(row.region)"
        cell.lbSearchMediaSynopsis.text = row.overview
        
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
        
        let row = tvInformation.tvShow[indexPath.row]
        vc.tvShow = row
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // e. 테이블 셋팅
    
    //상단에 닫기 네비게이션 버튼 생성
    @objc
    func closeButtonClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    //e. 네비게이션 버튼 설정

    

}
