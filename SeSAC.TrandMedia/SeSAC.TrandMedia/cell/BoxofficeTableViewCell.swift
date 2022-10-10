import UIKit

class BoxofficeTableViewCell: UITableViewCell {
    
    static let identifier = "BoxofficeTableViewCell"

    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var movieNmLabel: UILabel!
    @IBOutlet weak var openDtLabel: UILabel!
    @IBOutlet weak var rankOldAndNewLabel: UILabel!
    @IBOutlet weak var audiAccLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        audiAccLabel.textColor = .customGreen
        rankLabel.textAlignment = .center
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
