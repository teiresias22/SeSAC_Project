import UIKit

class MainPageTableViewCell: UITableViewCell {

    static let identifier = "MainPageCell"
    
    @IBOutlet weak var lbMediaTag: UILabel!
    @IBOutlet weak var lbMediaTitleEng: UILabel!
    @IBOutlet weak var imgMediaImage: UIImageView!
    @IBOutlet weak var lbMediaRating: UILabel!
    @IBOutlet weak var lbMediaTitleKr: UILabel!
    @IBOutlet weak var lbMediaOpeningDate: UILabel!
    @IBOutlet weak var mediaView: UIView!
    @IBOutlet weak var webViewLinkButton: UIButton!
    @IBOutlet weak var similarViewLinkButton: UIButton!
    @IBOutlet weak var rateExpactaion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mediaView.backgroundColor = .systemGray6
        mediaView.layer.cornerRadius = 10
        mediaView.layer.shadowColor = UIColor.gray.cgColor
        mediaView.layer.shadowRadius = 5
        mediaView.layer.shadowOpacity = 0.8
        
        webViewLinkButton.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        webViewLinkButton.setTitle("", for: .normal)
        webViewLinkButton.tintColor = .white
        webViewLinkButton.contentVerticalAlignment = .fill
        webViewLinkButton.contentHorizontalAlignment = .fill
        
        similarViewLinkButton.setTitle("비슷한 컨텐츠 찾기", for: .normal)
        similarViewLinkButton.tintColor = .customRed
        similarViewLinkButton.contentHorizontalAlignment = .left
        
        imgMediaImage.layer.cornerRadius = 11
        imgMediaImage.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        rateExpactaion.textColor = .white
        rateExpactaion.backgroundColor = .customRed ?? .red
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func webViewLinkButtonClicked(_ sender: UIButton) {
        
    }
    @IBAction func similarViewLinkButtonClicked(_ sender: UIButton) {
        
    }
    
}
