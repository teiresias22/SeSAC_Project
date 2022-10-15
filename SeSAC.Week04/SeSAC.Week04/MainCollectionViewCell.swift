

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "MainCollectionViewCell"

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
