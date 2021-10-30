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
        
        TitleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        genreLabel.textColor = .systemGray
        genreLabel.font = .systemFont(ofSize: 14)
        releaseDateLabel.textColor = .systemGray
        releaseDateLabel.font = .systemFont(ofSize: 14)
        overViewLabel.font = .systemFont(ofSize: 14)
        overViewLabel.numberOfLines = 3
        self.layer.cornerRadius = 8
        
    }

}
