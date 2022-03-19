import UIKit

class BookViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var bookCollectionView: UICollectionView!
    
    var bookData: [BookModel] = []
    var startPage = 1
    var totalPageCount = 100
    var service = "book"
    var query = "개발자"
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        collectionViewSet()
        setSearchBar()
        fetcBookData()
    }
    
    func collectionViewSet() {
        bookCollectionView.delegate = self
        bookCollectionView.dataSource = self
        bookCollectionView.prefetchDataSource = self
        
        let nibName = UINib(nibName: BookCollectionViewCell.identifier, bundle: nil)
        bookCollectionView.register(nibName, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let width = UIScreen.main.bounds.width - (spacing * 3)
        
        layout.itemSize = CGSize(width: width / 2 , height: width / 1.3  )
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        
        bookCollectionView.collectionViewLayout = layout
        navigationItem.title = "도서"
    }
    
    func setSearchBar(){
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        searchBar.placeholder = "도서를 검색하세요"
    }
    
    func fetcBookData() {
        NaverAPIManager.shared.fetchMovieData(serviceType: service, query: query, startPage: startPage) { json in
            for item in json["items"].arrayValue {
                let title = item["title"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                let link = item["link"].stringValue
                let image = item["image"].stringValue
                let author = item["author"].stringValue
                let price = item["price"].stringValue
                let pubdate = item["pubdate"].stringValue
                let description = item["description"].stringValue
                let isbn = item["isbn"].stringValue
                
                let data = BookModel(title: title, link: link, image: image, author: author, price: price, pubdate: pubdate, description: description, isbn: isbn)
                
                self.totalPageCount = json["total"].intValue
                self.bookData.append(data)
            }
            self.bookCollectionView.reloadData()
        }
    }
}

extension BookViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else { return UICollectionViewCell() }
        
        let item = bookData[indexPath.item]
        
        cell.bookTitle.text = item.title
        cell.bookAuthor.text = item.author
        cell.bookPrice.text = "금액: " + item.price + " 원"
        cell.bookPubDate.text = "출판일: " + item.pubdate
        
        if let url = URL(string: item.image) {
            cell.bookCoverImage.kf.setImage(with: url)
        } else {
            cell.bookCoverImage.image = UIImage(systemName: "star")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if bookData.count - 2 == indexPath.item && bookData.count < totalPageCount {
                startPage += 20
                fetcBookData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("취소")
    }
}

extension BookViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        bookData.removeAll()
        query = searchBar.text ?? "개발자"
        fetcBookData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
}
