import UIKit
import Kingfisher

class MainPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var btnMenuBarButton: UIBarButtonItem!
    @IBOutlet weak var btnSearchBarButton: UIBarButtonItem!
    
    @IBOutlet weak var lbWelcomeMessage: UILabel!
    @IBOutlet weak var btnMovieButton: UIButton!
    @IBOutlet weak var btnTvSeriesButton: UIButton!
    @IBOutlet weak var btnBookButton: UIButton!
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var mediaTableView: UITableView!
    
    let tvInformation = tvShowInformation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mediaTableView.delegate = self
        mediaTableView.dataSource = self
        
        lbWelcomeMessage.text = "OH JOON!"
        lbWelcomeMessage.textColor = .white
        
        setBarButton(btnMenuBarButton, "list.bullet", .black)
        setBarButton(btnSearchBarButton, "magnifyingglass", .black)
        
        setButton(btnMovieButton, "film", .green)
        setButton(btnTvSeriesButton, "tv", .yellow)
        setButton(btnBookButton, "book.closed", .cyan)
        
        topViewSetting()
    }
    //e. 뷰디드로드

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
    
    //상단영역 3버튼 배경 설정
    func topViewSetting(){
        let layer = topView.layer
        
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 10
    }
    //e. 상단세팅
    
    //테이블의 링크 버튼 클릭
    @objc func linkButtonClicked(selectButton: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        vc.tvShow = tvInformation.tvShow[selectButton.tag]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //셀 갯수 설정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvInformation.tvShow.count
    }
    
    //셀 내용 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainPageTableViewCell.identifier, for: indexPath) as? MainPageTableViewCell else {
            return UITableViewCell()
        }
        
        let row = tvInformation.tvShow[indexPath.row]
        //url image 불러오기 [옵셔널 이게 맞나??)
        let data = try? Data(contentsOf: URL(string: row.backdropImage)!)
        
        cell.mediaView.layer.cornerRadius = 10
        cell.mediaView.layer.shadowColor = UIColor.gray.cgColor
        cell.mediaView.layer.shadowRadius = 5
        cell.mediaView.layer.shadowOpacity = 0.8
        cell.mediaView.backgroundColor = .systemGray6
        
        cell.webViewLinkButton.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        cell.webViewLinkButton.setTitle("", for: .normal)
        cell.webViewLinkButton.tintColor = .white
        cell.webViewLinkButton.contentVerticalAlignment = .fill
        cell.webViewLinkButton.contentHorizontalAlignment = .fill
        cell.webViewLinkButton.tag = indexPath.row
        cell.webViewLinkButton.addTarget(self, action: #selector(linkButtonClicked(selectButton:)), for: .touchUpInside)
        
        cell.imgMediaImage.image = UIImage(data: data!)
        cell.imgMediaImage.layer.cornerRadius = 11
        cell.imgMediaImage.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        cell.lbMediaTag.text = "\(row.genre)"
        cell.lbMediaTitleEng.text = row.title
        cell.lbMediaTitleKr.text = row.title
        cell.lbMediaOpeningDate.text = row.releaseDate
        cell.lbMediaRating.text = "\(row.rate)"
        
        return cell
    }
    
    //셀 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 2
    }
    
    //셀 클릭시 이동
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CastListViewController") as! CastListViewController
        
        let row = tvInformation.tvShow[indexPath.row]
        vc.tvShow = row
        
        self.navigationController?.pushViewController(vc, animated: true)
        //클릭하면 왜 두번 이동???????????
        //1. 셀 안에 뷰가 하나 더 있어서 그런가??
    }
    //e. 테이블 뷰 세팅
    
    //검색 바버튼 클릭시 이동
    @IBAction func searchBarButtonClicked(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func MapBarButtonClicked(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //e. 바버튼 클릭 세팅
}

/*
    1. Main에서 CastList로 갈떄 두번 뜨는 현상 해결
    6. BookCollection에서 색상 무작위 배치
 
    7. MapView 핀 추가
    8. MapView Alert에 따라 핀 정보 갱신, Label에 선택한 필터 표시
*/
