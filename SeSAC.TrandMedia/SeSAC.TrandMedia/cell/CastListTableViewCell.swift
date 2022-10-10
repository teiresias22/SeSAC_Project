
import UIKit

class CastListTableViewCell: UITableViewCell {
    
    static let identifier = "CastListCell"

    @IBOutlet weak var imgActorImage: UIImageView!
    @IBOutlet weak var lbActorName: UILabel!
    @IBOutlet weak var lbCastName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        lbActorName.font = UIFont().mainMedium
        lbCastName.font = UIFont().mainLight
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
