import UIKit

class BookCollectionViewCell: UICollectionViewCell {

    static let identifier = "BookCollectionViewCell"
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookPrice: UILabel!
    @IBOutlet weak var bookPubDate: UILabel!
    @IBOutlet weak var bookCoverImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        bookTitle.font = .boldSystemFont(ofSize: 14)
        bookTitle.numberOfLines = 2
        
        bookAuthor.font = .systemFont(ofSize: 14)
        bookAuthor.textColor = .systemGray
        
        bookPrice.font = .systemFont(ofSize: 14)
        bookPrice.textColor = .systemGray
        
        bookPubDate.font = .systemFont(ofSize: 14)
        
        layer.cornerRadius = 8
    }

}
