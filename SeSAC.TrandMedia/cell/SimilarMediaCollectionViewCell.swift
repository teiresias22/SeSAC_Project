import UIKit

class SimilarMediaCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SimilarMediaCollectionViewCell"

    @IBOutlet weak var mediaImage: UIImageView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        TitleLabel.font = UIFont().mainMedium
        genreLabel.textColor = .systemGray
        genreLabel.font = UIFont().mainLight
        releaseDateLabel.textColor = .systemGray
        releaseDateLabel.font = UIFont().mainLight
        overViewLabel.font = UIFont().mainLight
        overViewLabel.numberOfLines = 3
        self.layer.cornerRadius = 8
        
    }

}
