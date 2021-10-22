import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    var tvShow: TvShow?
    let tvInformation = tvShowInformation()
    
    @IBOutlet weak var mediaPosterImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = tvShow?.title ?? "Title"
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textColor = .black
        titleLabel.shadowColor = .purple
        titleLabel.shadowOffset = .init(width: 1.2, height: 1.2)
        
        mediaPosterImage.image = UIImage(named: tvShow?.title ?? "")
    }
    


}
