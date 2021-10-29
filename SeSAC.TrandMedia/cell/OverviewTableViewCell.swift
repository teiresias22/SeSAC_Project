
import UIKit

class OverviewTableViewCell: UITableViewCell {
    
    static let identifier = "OverviewCell"
    
    @IBOutlet weak var mediaOverviewLabel: UILabel!
    @IBOutlet weak var mediaOverviewSeeMoreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
