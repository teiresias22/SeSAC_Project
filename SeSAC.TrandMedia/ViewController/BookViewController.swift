import UIKit

class BookViewController: UIViewController {

    @IBOutlet weak var bookCollectionView: UICollectionView!
    
    let tvInformation = tvShowInformation()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bookCollectionView.delegate = self
        bookCollectionView.dataSource = self
        
        let nibName = UINib(nibName: BookCollectionViewCell.identifier, bundle: nil)
        bookCollectionView.register(nibName, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let width = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: width / 2 , height: width / 2  )
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        
        bookCollectionView.collectionViewLayout = layout
    }
}

extension BookViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvInformation.tvShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else { return UICollectionViewCell() }
        
        let item = tvInformation.tvShow[indexPath.item]
        
        cell.bookTitle.text = item.title
        cell.bookTitle.textColor = .black
        cell.bookTitle.font = .boldSystemFont(ofSize: 20)
        cell.bookRate.text = "\(item.rate)"
        cell.bookRate.textColor = .black
        cell.bookCoverImage.image = UIImage(named: item.title)
        cell.backgroundColor = setColorSet(item.genre)
        cell.layer.cornerRadius = 16
        
        return cell
    }
    
    func setColorSet(_ genre:String) -> UIColor {
        if genre == "Mystery" || genre == "Crime" {
            return UIColor.customRed ?? .clear
        } else if genre == "Drama" || genre == "Comedy" {
            return UIColor.customYellow ?? .clear
        } else if genre == "Animation" {
            return UIColor.customBlue ?? .clear
        } else {
            return UIColor.customGreen ?? .clear
        }
    }
}
