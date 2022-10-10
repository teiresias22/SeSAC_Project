import UIKit
import Kingfisher

class SimilarMediaViewController: UIViewController {
    @IBOutlet weak var similarMediaLabrl: UILabel!
    @IBOutlet weak var SimilarCollectionView: UICollectionView!
    
    var mediaData: MediaModel?
    var similarData: [similarModel] = []
    var startPage = 1
    var totalPageCount = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SimilarCollectionView.delegate = self
        SimilarCollectionView.dataSource = self
        SimilarCollectionView.prefetchDataSource = self
        
        let nibName = UINib(nibName: SimilarMediaCollectionViewCell.identifier, bundle: nil)
        SimilarCollectionView.register(nibName, forCellWithReuseIdentifier: SimilarMediaCollectionViewCell.identifier)
        
        collectionViewSet()
        loadMediaData()

        // Do any additional setup after loading the view.
    }
    
    func collectionViewSet() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let width = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: width / 2 , height: width / 1.5  )
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        
        SimilarCollectionView.collectionViewLayout = layout
        
        if mediaData!.title != "" {
            similarMediaLabrl.text = mediaData!.title + "과 유사한 컨텐츠"
        } else if mediaData!.name != "" {
            similarMediaLabrl.text = mediaData!.name + "과 유사한 컨텐츠"
        }
        similarMediaLabrl.font = .systemFont(ofSize: 16, weight: .black)
        similarMediaLabrl.textAlignment = .center
        
        navigationItem.title = "유사한 컨텐츠 보기"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Main", style: .plain, target: self, action: #selector(closeButtonClicked))
    }
    
    func loadMediaData() {
        TMDBTypeAPIManager.shared.fetchTranslateData(mediaType: mediaData!.mediaType, mediaID: mediaData!.id, APIType: "similar", startPage: startPage) { json in
            for similar in json["results"].arrayValue {
                let title = similar["title"].stringValue
                let name = similar["name"].stringValue
                let genre_ids = similar["genre_ids"].intValue
                let backdrop_path = similar["backdrop_path"].stringValue
                let release_date = similar["release_date"].stringValue
                let first_air_date = similar["first_air_date"].stringValue
                let overview = similar["overview"].stringValue
                let id = similar["id"].intValue
                
                let data = similarModel(title: title, name: name, genre_ids: genre_ids, backdrop_path: backdrop_path, release_date: release_date, first_air_date: first_air_date, overview: overview, id: id)
                
                self.totalPageCount = json["total_results"].intValue
                self.similarData.append(data)
            }
            self.SimilarCollectionView.reloadData()
        }
    }
    @objc
    func closeButtonClicked(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension SimilarMediaViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarMediaCollectionViewCell.identifier, for: indexPath) as? SimilarMediaCollectionViewCell else { return UICollectionViewCell() }
        
        let item = similarData[indexPath.item]
        
        if item.name != "" {
            cell.TitleLabel.text = item.name
        } else {
            cell.TitleLabel.text = item.title
        }
        if let url = URL(string: Endpoint.TMDBImage + item.backdrop_path) {
            cell.mediaImage.kf.setImage(with: url)
        } else {
            cell.mediaImage.image = UIImage(systemName: "star")
        }
        if item.release_date != "" {
            cell.releaseDateLabel.text = item.release_date
        } else {
            cell.releaseDateLabel.text = item.first_air_date
        }
        
        //장르 표시
        cell.genreLabel.text = ""
        cell.overViewLabel.text = item.overview
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if similarData.count - 2 == indexPath.item && similarData.count < totalPageCount {
                startPage += 20
                loadMediaData()
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("취소")
    }
    
    /* 선택하면 CastList로 넘어가고 싶은데 데이터를 어떻게 연동시켜야 할까????
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "CastListViewController") as? CastListViewController else { return }
        
        let item = similarData[indexPath.item]
        vc.similarData = item
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
     */
}
