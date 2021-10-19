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
        cell.bookRate.text = "\(item.rate)"
        cell.bookCoverImage.image = UIImage(named: item.title)
        cell.backgroundColor = .systemMint
        cell.layer.cornerRadius = 16
        
        return cell
    }
    
    
}
