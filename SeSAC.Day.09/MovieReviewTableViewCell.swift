import UIKit

class MovieReviewTableViewCell: UITableViewCell {
    
    static let identifier = "MovieReviewCell"

    @IBOutlet weak var MoviePoster: UIImageView!
    @IBOutlet weak var lbMovieTitle: UILabel!
    @IBOutlet weak var lbMovieOpenDate: UILabel!
    @IBOutlet weak var lbMovieSummery: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
