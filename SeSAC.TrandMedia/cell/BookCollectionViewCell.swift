import UIKit

class BookCollectionViewCell: UICollectionViewCell {

    static let identifier = "BookCollectionViewCell"
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookRate: UILabel!
    @IBOutlet weak var bookCoverImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
